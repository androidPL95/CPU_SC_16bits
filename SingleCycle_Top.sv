module SingleCycle_Top import typedefs::*;
(
	input				CLK	,
	input				RST	,
);

	/************************
	*   WIRE DECLARATIONS   *
	************************/

	opcode_t           op;
	wire               comp;
	wire               sel_pc;    
	wire               sum_imm;   
	wire               store_data;  
	wire               reg_we;    
	wire					 alu_feedback_in;

	/*************************
	*     INSTANTIATIONS     *
	*************************/
	
//	Hazzard_controller ctrlh(	//EXAMPLE OF INSTANCIATION
//		.instruction(instruction3),
//		.wa2(wa2),
//		.wa3(wa3),
//		.wa4(wa4),
//		.stall(),
//		.flush(),
//		.aux_feedback(),
//		.forwarding_alu_in_a(),
//		.forwarding_alu_in_b()
//	);

	
//===|Stage 1|=============================|

	wire [15:0] next_pc;
	wire [15:0] pc;
	wire [15:0] instruction1;
	wire [15:0] sum_imm_out;
	
	Mem inst_mem(
		.addr(pc[9:0]), 
		.clk(CLK), 
		.wdata('0), 
		.we('0),
		.rst('1),
		.out(instruction1)
	);
	
	Reg pc(
		.in(next_pc), 
		.clk(CLK),
		.rst(RST), 
		.out(pc)
	);
	
	Mux2x1 pc_mux(
		.a(pc + sum_imm_out), 
		.b(aux_out), 
		.sel(jump3), 
		.out(next_pc)
	);
	
	Mux2x1 sum_imm_mux(
		.a(16'h1), 
		.b(aux_out), 
		.sel(sum_imm), 
		.out(sum_imm_out)
	);
	
//===|Stage 2|=============================|.

	wire [15:0] 	pc2;
	wire [15:0] 	instruction2;
	wire				branch2;
	wire        	alu_bypass2;
	wire        	mem_we2;
	wire        	mem_bypass2;
	wire        	jump2;
	alu_opcode_t	alu_ctrl2;
	wire           alu_imm; 
	
	wire [15:0] rd1_2;
	wire [15:0] rd2_2;
	wire [15:0] alu_imm_out2;
	
	Pipeline_Stage1 ppl1(
		.clk(CLK),
		.reset(RST),
		.enable(),//---------------|<stall
		.in_instruction(instruction1),
		.in_PC(pc),
		.out_instruction(instruction2),
		.out_PC(pc2)
	);
	

	Controller control_block(
		.clk(CLK), 
		.op(opcode_t'(instruction2[15:10])), 
		.comp(comp), 
		.sel_PC 
		.sum_imm(sum_imm), 
		.store_pc(store_pc), 
		.reg_we(reg_we), 
		.alu_imm(alu_imm), 
		.alu_ctrl(alu_ctrl2), 
		.alu_bypass(alu_bypass2),
		.alu_feedback_in(alu_feedback_in),
		.mem_we(mem_we2), 
		.mem_bypass(mem_bypass2),
		.branch(branch2),//-----------------|<implementar
		.jump(jump2)//------------------|<implementar
	);
	

	RegFile reg_file(
		.a1(instruction2[9:5]), 
		.a2(instruction2[4:0]),
		.waddress(store_data_address),//-------------|<implementar
		.wdata(store_data), 
		.we(reg_we), 
		.clk(CLK),
		.rst(RST),
		.rd1(rd1_2), 
		.rd2(rd2_2)
	);
	
	Mux2x1 alu_imm_mux(
		.a(rd2_2), 
		.b({8'h0, instruction2[7:0]}), 
		.sel(alu_imm), 
		.out(alu_imm_out2)
	);
	
	Mux2x1 store_pc_mux(
		.a(mem_bypass_out), 
		.b(pc2), 
		.sel(store_pc), 
		.out(store_data)
	);
	
	Mux2x1 store_pc_address_mux(
		.a(wa5), 
		.b(/*endereço do registrador $ra*/), 
		.sel(store_pc), 
		.out(store_data_address)
	);
	
//===|Stage 3|=============================|

	wire				branch3;
	wire        	alu_bypass3;
	wire        	mem_we3;
	wire				mem_bypass3;
	wire        	jump3;
	alu_opcode_t	alu_ctrl3;
	wire [15:0] 	instruction3;
	wire [15:0] 	rd1_3;
	wire [15:0] 	rd2_3;
	wire [15:0] 	alu_imm_out3;
	wire [4:0] 		wa3;
	wire [15:0] 	alu_out;
	wire [15:0] 	alu_bypass_out;
	
	Pipeline_Stage2 ppl2(
		.clk(CLK)
		.reset(RST or /*something here*/), //------------|<flush
		
		//Control signals
		//in
		.in_branch(branch2),
		.in_ALU_bypass(alu_bypass2),
		.in_Mem_WE(mem_we2),
		.in_Mem_bypass(mem_bypass2),
		.in_jump(jump2),
		.in_ALU_control(alu_ctrl2),
		.in_instruction(instruction2),
		//out
		.out_branch(branch3),
		.out_ALU_bypass(alu_bypass3),
		.out_Mem_WE(mem_we3),
		.out_Mem_bypass(mem_bypass3),
		.out_jump(jump3),
		.out_ALU_control(alu_ctrl3),
		.out_instruction(instruction3),

		.in_RD1(rd1_2),
		.in_RD2(rd2_2),
		.in_immmux(alu_imm_out2),
		.in_wa(instruction2[4:0]),

		.out_RD1(rd1_3),
		.out_RD2(rd2_3),
		.out_immmux(alu_imm_out3),
		.out_wa(wa3)
	);
	
	wire [15:0] 	alu_in_a
	wire [15:0] 	alu_in_b
	
	Mux3x1 forwarding1(
		.a(),
		.b(),
		.c(),
		.sel(),
		.out(alu_in_a)
	);
	
	Mux3x1 forwarding2(
		.a(),
		.b(),
		.c(),
		.sel(),
		.out(alu_in_b)
	);

	ALU my_alu(
		.a(alu_in_a), 
		.b(alu_in_b), 
		.opcode(alu_ctrl3), 
		.out(alu_out), 
		.comp(comp)
	);

	Mux2x1 alu_bypass_mux(
		.a(alu_out), 
		.b(alu_imm_out3), 
		.sel(alu_bypass), 
		.out(alu_bypass_out)
	);
	
	wire [15:0] 	aux_value3

	Mux2x1 aux_feedback_mux(
		.a(alu_out), 
		.b(alu_bypass_out), 
		.sel(aux_feedback), 
		.out(aux_value2)
	);

	
//===|Stage 4|=============================|

	wire [15:0] 	aux_value4;
	wire [4:0] 		wa4;
	wire        	mem_we4;
	wire				mem_bypass4;
	wire [15:0] 	mem_out4;
	wire [15:0] 	mem_bypass_out4;
	
	Pipeline_Stage3 ppl3(
		.clk(CLK),
		.rst(RST or /*something here*/), //------------|<flush
		.mem_bypass_in(mem_bypass3),
		.mem_bypass_out(mem_bypass4),
		.mem_we_in(mem_we3),
		.mem_we_out(mem_we4),
		.aux_in(aux_value3),
		.aux_out(aux_value4),
		.wa_in(wa3),
		.wa_out(wa4)
	);

	Data_Mem data_mem(
		.addr(aux_value4), 
		.clk(CLK), 
		.wdata(rd2_3), 
		.we(mem_we4), 
		.rst(RST),
		.out(mem_out4),
		
	);

	Mux2x1 mem_bypass_mux(
		.a(mem_out4), 
		.b(aux_value4), 
		.sel(mem_bypass4), 
		.out(mem_bypass_out4)
	);

//===|Stage 5|=============================|

	wire [15:0] 	mem_bypass_out5;
	wire [4:0] 		wa5;
	
	Pipeline_Stage4 ppl4(
		.clk(CLK),
		.rst(RST or /*something here*/), //------------|<flush

		.mux_in(mem_bypass_out4),
		.mux_out(mem_bypass_out5),

		.wa_in(wa4),
		.wa_out(wa5)
	);

endmodule
