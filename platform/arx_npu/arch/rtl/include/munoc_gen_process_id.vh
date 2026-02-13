reg valid_access;
reg [32-1:0] process_id_temp;
reg [32-1:0] process_id_onehot_temp;

always@(*)
begin
	process_id_temp = 0;
	process_id_onehot_temp = 0;
	valid_access = 0;
	case(master_nodeid)
		`NODE_ID_I_MNIM_I_MAIN_CORE_NO_NAME:
		begin
			process_id_temp = `PROCESS_ID_I_MNIM_I_MAIN_CORE_NO_NAME;
			process_id_onehot_temp[`PROCESS_ID_I_MNIM_I_MAIN_CORE_NO_NAME] = 1'b 1;
			valid_access = 1;
		end
	endcase
end