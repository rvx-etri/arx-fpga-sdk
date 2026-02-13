#include "platform_info.h"
#include "ervp_assert.h"
#include "ervp_printf.h"
#include "ervp_matrix_op_transform.h"
#include "ervp_blocked_matrix_op.h"
#include "ervp_caching.h"
#include "core_dependent.h"

#include "ip_instance_info.h"
#include "dca_matrix_conv2d.h"
#include "dca_matrix_mac.h"

#include "map_your_matrix_hw.h"

const char matrix_hw_name[] = "DCA";

////////////////////////////////////////////////////////////////////////////

static int CHECK_FUNCTION = 0;

////////////////////////////////////////////////////////////////////////////

ervp_hwtask_busy_fx_t i_dca_matrix_conv2d_oneblock(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, int conv_options)
{
  return dca_matrix_conv2d_oneblock(mop_mapping, i_dca_matrix_conv00_info, ma_info, mb_info, mc_info, conv_options);
}

ervp_hwtask_busy_fx_t i_dca_matrix_conv2d_oneblock_sharedoutput(ervp_mop_mapping_t *mop_mapping, int num_input, const ErvpMatrixInfo **input_info_list, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo *output_info, int conv_options, int init_ouptut)
{
  return dca_matrix_conv2d_oneblock_sharedoutput(mop_mapping, i_dca_matrix_conv00_info, num_input, input_info_list, kernel_info_list, output_info, conv_options, init_ouptut);
}

////////////////////////////////////////////////////////////////////////////

static ervp_blocked_matrix_info_t *blocked_info_conv;

ervp_hwtask_busy_fx_t i_blocked_matrix_conv(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int conv_option_value)
{
  if (CHECK_FUNCTION)
    printf_function();
  blocked_info_conv->block_size = i_dca_matrix_conv00_info->output_matrix_size + mb_info->num_row - 1;
  return blocked_matrix_conv(blocked_info_conv, ma_info, mb_info, mc_info, conv_option_value);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_conv_sharedinput(ervp_mop_mapping_t *mop_mapping, int num_output, const ErvpMatrixInfo *input_info, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo **output_info_list, unsigned int conv_option_value)
{
  if (CHECK_FUNCTION)
    printf_function();
  blocked_info_conv->block_size = i_dca_matrix_conv00_info->output_matrix_size + kernel_info_list[0]->num_row - 1;
  return blocked_matrix_conv_sharedinput(blocked_info_conv, num_output, input_info, kernel_info_list, output_info_list, conv_option_value);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_conv_sharedoutput(ervp_mop_mapping_t *mop_mapping, int num_input, const ErvpMatrixInfo **input_info_list, const ErvpMatrixInfo **kernel_info_list, ErvpMatrixInfo *output_info, unsigned int conv_option_value, int init_ouptut)
{
  if (CHECK_FUNCTION)
    printf_function();
  blocked_info_conv->block_size = i_dca_matrix_conv00_info->output_matrix_size + kernel_info_list[0]->num_row - 1;
  return blocked_matrix_conv_sharedoutput(blocked_info_conv, num_input, input_info_list, kernel_info_list, output_info, conv_option_value, init_ouptut);
}

////////////////////////////////////////////////////////////////////////////

ervp_hwtask_busy_fx_t i_dca_matrix_mac00_add(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return dca_matrix_add(mop_mapping, i_dca_matrix_mac00_info, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_dca_matrix_mac00_sub(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return dca_matrix_sub(mop_mapping, i_dca_matrix_mac00_info, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_dca_matrix_mac00_ewmult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return dca_matrix_ewmult(mop_mapping, i_dca_matrix_mac00_info, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_dca_matrix_mac00_mult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return dca_matrix_mult(mop_mapping, i_dca_matrix_mac00_info, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_dca_matrix_mac00_scalar_mult_fixed(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, int scalar_value, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return dca_matrix_scalar_mult_fixed(mop_mapping, i_dca_matrix_mac00_info, ma_info, scalar_value, mc_info, option_value);
}

////////////////////////////////////////////////////////////////////////////

static ervp_blocked_matrix_info_t* blocked_info_mac;

ervp_hwtask_busy_fx_t i_blocked_matrix_add(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return blocked_matrix_add(blocked_info_mac, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_sub(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return blocked_matrix_sub(blocked_info_mac, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_ewmult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return blocked_matrix_ewmult(blocked_info_mac, ma_info, mb_info, mc_info, option_value);
}

ervp_hwtask_busy_fx_t i_blocked_matrix_mult(ervp_mop_mapping_t *mop_mapping, const ErvpMatrixInfo *ma_info, const ErvpMatrixInfo *mb_info, ErvpMatrixInfo *mc_info, unsigned int option_value)
{
  return blocked_matrix_mult(blocked_info_mac, ma_info, mb_info, mc_info, option_value);
}

////////////////////////////////////////////////////////////////////////////


void map_your_matrix_function(ervp_mop_mapping_t *mop_mapping)
{
  /* map your own functions */
  blocked_info_conv = blocked_matrix_info_alloc();
  blocked_info_conv->subop_mapping = matrix_op_mapping_alloc();
  blocked_info_conv->subop_mapping->matrix_conv = i_dca_matrix_conv2d_oneblock;
  blocked_info_conv->subop_mapping->matrix_conv_sharedoutput = i_dca_matrix_conv2d_oneblock_sharedoutput;

  mop_mapping->matrix_conv = i_blocked_matrix_conv;
  mop_mapping->matrix_conv_sharedinput = i_blocked_matrix_conv_sharedinput;
  mop_mapping->matrix_conv_sharedoutput = i_blocked_matrix_conv_sharedoutput;

  blocked_info_mac = blocked_matrix_info_alloc();
  blocked_info_mac->block_size = i_dca_matrix_mac00_info->num_col;
  blocked_info_mac->subop_mapping = matrix_op_mapping_alloc();
  blocked_info_mac->subop_mapping->matrix_add = i_dca_matrix_mac00_add;
  blocked_info_mac->subop_mapping->matrix_sub = i_dca_matrix_mac00_sub;
  blocked_info_mac->subop_mapping->matrix_ewmult = i_dca_matrix_mac00_ewmult;
  blocked_info_mac->subop_mapping->matrix_mult = i_dca_matrix_mac00_mult;
  blocked_info_mac->subop_mapping->matrix_scalar_mult_fixed = i_dca_matrix_mac00_scalar_mult_fixed;

  mop_mapping->matrix_add = i_dca_matrix_mac00_add;
  mop_mapping->matrix_sub = i_dca_matrix_mac00_sub;
  mop_mapping->matrix_ewmult = i_dca_matrix_mac00_ewmult;
  mop_mapping->matrix_mult = i_dca_matrix_mac00_mult;
}
