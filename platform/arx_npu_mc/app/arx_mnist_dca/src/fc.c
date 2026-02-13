#include "ervp_malloc.h"
#include "ervp_printf.h"
#include "ervp_assert.h"
#include "ervp_matrix.h"
#include "ervp_matrix_op.h"
#include "ervp_matrix_op_sw.h"
#include "ervp_matrix_op_transform.h"
#include "ervp_profiling.h"

#include "map_your_matrix_hw.h"

#include "API.h"
#include "ONES_MATH.h"

#define INTEGER_TYPE int

#if 1
int fullyconnected_i8_shift(unsigned char* input, unsigned char *kernel, int *bias, unsigned char *output, unsigned char* outputOffset,
    unsigned int inputDim0, unsigned int inputDim1, unsigned int kernelDim0, unsigned int kernelDim1,
    bool doBias, int* shift, unsigned int outputDim0, unsigned int outputDim1)
{
  //profiling_start("fc");
  /*
     kernelDim0 = inputDim0 * inputDim1;
     kernelDim1 = outputDim0 * outputDim1;
     */

  assert(inputDim0==1);
  assert(inputDim1==kernelDim0);
  assert(kernelDim1==outputDim1);
  assert(outputDim0==1);

  int count = 0;
  unsigned int input_size = inputDim0 * inputDim1; // 예: 256
  unsigned int output_size = outputDim0 * outputDim1; // 예: 10

#if 1
  //printf("fullyconnected_i8_shift hw\n");
  ervp_hwtask_busy_fx_t hwtask_busy_fx;
  static ervp_mop_mapping_t *mop_mapping = NULL;
  if(mop_mapping == NULL)
  {
    mop_mapping = matrix_op_mapping_alloc();
    map_your_matrix_function(mop_mapping);
  }

  ErvpMatrixInfo *input_info = matrix_generate_info(MATRIX_DATATYPE_UINT08, inputDim0, inputDim1, input, NULL);
  ErvpMatrixInfo *kernel_info = matrix_alloc(MATRIX_DATATYPE_SINT32, kernelDim0, kernelDim1, NULL);
  ErvpMatrixInfo *output_info = matrix_alloc(MATRIX_DATATYPE_SINT32, outputDim0, outputDim1, NULL);

  int (*kernel_sint32_2d)[kernelDim1] = kernel_info->addr;
  int *output_sint32 = output_info->addr;

  for(int i = 0; i < output_size; i++) {
    for(int j = 0; j < input_size; j++) {
      // kernel은 uint8 형태로 저장되어 있으므로, 원래의 int8 값은 (stored_value - 127)입니다.
      kernel_sint32_2d[j][i] = ((int)*(kernel + j * output_size + i)) - 127;
    }
  }

  hwtask_busy_fx = mop_mapping->matrix_mult(mop_mapping, input_info, kernel_info, output_info, 0); 
  hwtask_wait_complete(hwtask_busy_fx);

  count = output_size*input_size;

  for(int i = 0; i < output_size; i++) {
    INTEGER_TYPE temp = output_sint32[i];

    // Bias 적용 (있다면)
    if(doBias) {
      temp += bias[i];
    }

    // shift 연산: 먼저 rounding을 더하고 오른쪽으로 shift
    INTEGER_TYPE rounding = 1 << (shift[i]-1);
    temp = (temp + rounding) >> shift[i];
    temp = temp + outputOffset[0];

    // overflow/underflow 처리
    if(temp > 255)       output[i] = 255;
    else if(temp < 0)    output[i] = 0;
    else                output[i] = temp;
  }

  free(input_info);
  matrix_free(kernel_info);
  matrix_free(kernel_info);

#else
  // matrix multiplication
  for(int i = 0; i < output_size; i++) {
    // 32비트 또는 64비트 연산을 INTEGER_TYPE으로 수행
    INTEGER_TYPE temp = 0;

    for(int j = 0; j < input_size; j++) {
      // kernel은 uint8 형태로 저장되어 있으므로, 원래의 int8 값은 (stored_value - 127)입니다.
      INTEGER_TYPE kernel_val = ((INTEGER_TYPE)*(kernel + j * output_size + i)) - 127;
      temp += input[j] * kernel_val;
      count++;
    }

    // Bias 적용 (있다면)
    if(doBias) {
      temp += bias[i];
    }

    // shift 연산: 먼저 rounding을 더하고 오른쪽으로 shift
    INTEGER_TYPE rounding = 1 << (shift[i]-1);
    temp = (temp + rounding) >> shift[i];
    temp = temp + outputOffset[0];

    // overflow/underflow 처리
    if(temp > 255)       output[i] = 255;
    else if(temp < 0)    output[i] = 0;
    else                output[i] = temp;
  }
#endif

  //profiling_end("fc");
  return count;
}
#endif

