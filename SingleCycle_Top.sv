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
	wire               reg_we;    // PROPAGATE
	wire			   store_pc;  // PROPAGATE
	wire			   alu_feedback_in;

	wire [15:0] next_pc;
	wire [15:0] pc;
	wire [15:0] instruction1_in;
	wire [15:0] sum_imm_out;
	wire [15:0] 	pc1_out;
	wire [15:0] 	instruction1_out;
	wire			branch2_in;
	wire        	alu_bypass2_in;
	wire        	mem_we2_in;
	wire        	mem_bypass2_in;
	wire        	jump2_in;
	alu_opcode_t	alu_ctrl2_in;
	wire            alu_imm; 
	wire [15:0] rd1_2_out;
	wire [15:0] rd2_2_out;
	wire [15:0] alu_imm_mux_out;

	wire			branch2_out;
	wire        	alu_bypass2_out;
	wire        	mem_we2_out;
	wire			mem_bypass2_out;
	wire        	jump2_out;
	alu_opcode_t	alu_ctrl2_out;
	wire [15:0] 	instruction2_out;
	wire [15:0] 	rd1_2_out;
	wire [15:0] 	rd2_2_out;
	wire [15:0] 	alu_imm2_out;
	wire [4:0] 		wa2_out;
	wire [15:0] 	alu_out;
	wire [15:0] 	alu_bypass_out;
	wire			reg_we2_out;
	wire			store_pc2_out;

	wire [15:0] 	alu_in_a;
	wire [15:0] 	alu_in_b;
	wire			reg_we3_out;
	wire			store_pc3_out;

	//wire [15:0] 	aux_value4;
	wire [4:0] 		wa3_out;
	wire        	mem_we3_out;
	wire			mem_bypass3_out;
	wire [15:0] 	mem_out;
	wire [15:0] 	mem_bypass_out;	
	wire			reg_we4_out;
	wire			store_pc4_out;

	//wire [15:0] 	mem_bypass_out5;
	wire [4:0] 		wa4_out;

	/*************************
	*     INSTANTIATIONS     *
	*************************/
	
//	Hazzard_controller ctrlh(	//EXAMPLE OF INSTANTIATION
//		.instruction(instruction2_out),
//		.wa2(wa2),
//		.wa2_out(wa2_out),
//		.wa3_out(wa3_out),
//		.stall(),
//		.flush(),
//		.aux_feedback(),
//		.forwarding_alu_in_a(),
//		.forwarding_alu_in_b()
//	);

//===|Stage 1|=============================|
	
	Mem inst_mem(
		.addr(pc[9:0]), 
		.clk(CLK), 
		.wdata('0), 
		.we('0),
		.rst('1),
		.out(instruction1_in)
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
		.sel(jump2_out), 
		.out(next_pc)
	);
	
	Mux2x1 sum_imm_mux(
		.a(16'h1), 
		.b(aux_out), 
		.sel(branch2_out && comp), 
		.out(sum_imm_out)
	);
	
	Pipeline_Stage1 ppl1(
		.clk(CLK),
		.reset(RST),
		.enable(),//---------------|<stall
		.in_instruction(instruction1_in),
		.in_PC(pc),
		.out_instruction(instruction1_out),
		.out_PC(pc1_out)
	);
	
//===|Stage 2|=============================|.

	Controller control_block(
		.clk(CLK), 
		.op(opcode_t'(instruction1_out[15:10])), 
		.sel_PC 
		.sum_imm(sum_imm), 
		.store_pc(store_pc), 
		.reg_we(reg_we), 
		.alu_imm(alu_imm), 
		.alu_ctrl(alu_ctrl2_in), 
		.alu_bypass(alu_bypass2_in),
		.alu_feedback_in(alu_feedback_in),
		.mem_we(mem_we2_in), 
		.mem_bypass(mem_bypass2_in),
		.branch(branch2_in),//-----------------|<implementar
		.jump(jump2_in)//------------------|<implementar
	);
	

	RegFile reg_file(
		.a1(instruction1_out[9:5]), 
		.a2(instruction1_out[4:0]),
		.waddr(store_data_address),//-------------|<implementar
		.wdata(store_data), 
		.we(reg_we), 
		.clk(CLK),
		.rst(RST),
		.rd1(rd1), 
		.rd2(rd2)
	);
	
	Mux2x1 alu_imm_mux(
		.a(rd2), 
		.b({8'h0, instruction1_out[7:0]}), 
		.sel(alu_imm), 
		.out(alu_imm_mux_out)
	);
	
	Mux2x1 store_pc_mux(
		.a(ppl4_out), 
		.b(pc1_out), 
		.sel(store_pc), 
		.out(store_data)
	);
	
	Mux2x1 store_pc_address_mux(
		.a(wa4_out), 
		.b(/*endereço do registrador $ra*/), 
		.sel(store_pc), 
		.out(store_data_address)
	);
	
	Pipeline_Stage2 ppl2(
		.clk(CLK)
		.reset(RST or /*something here*/), //------------|<flush
		
		//Control signals
		//in
		.reg_we_in(reg_we),
		.store_pc_in(store_pc),
		.in_branch(branch2_in),
		.in_ALU_bypass(alu_bypass2_in),
		.in_Mem_WE(mem_we2_in),
		.in_Mem_bypass(mem_bypass2_in),
		.in_jump(jump2_in),
		.in_ALU_control(alu_ctrl2_in),
		.in_instruction(instruction1_out),
		//out
		.reg_we_in(reg_we2_out),
		.store_pc_in(store_pc2_out),
		.out_branch(branch2_out),
		.out_ALU_bypass(alu_bypass2_out),
		.out_Mem_WE(mem_we2_out),
		.out_Mem_bypass(mem_bypass2_out),
		.out_jump(jump2_out),
		.out_ALU_control(alu_ctrl2_out),
		.out_instruction(instruction2_out),

		.in_RD1(rd1),
		.in_RD2(rd2),
		.in_immmux(alu_imm_mux_out),
		.in_wa(instruction1_out[4:0]),

		.out_RD1(rd1_2_out),
		.out_RD2(rd2_2_out),
		.out_immmux(alu_imm2_out),
		.out_wa(wa2_out)
	);
	
//===|Stage 3|=============================|
	
	Mux3x1 forwarding1(
		.a(aux_out),
		.b(rd1_2_out),
		.c(ppl4_out),
		.sel(/* UNIDADE DE HAZARDS */),
		.out(alu_in_a)
	);
	
	Mux3x1 forwarding2(
		.a(aux_out),
		.b(rd2_2_out),
		.c(ppl4_out),
		.sel(/* UNIDADE DE HAZARDS */),
		.out(alu_in_b)
	);

	ALU my_alu(
		.a(alu_in_a), 
		.b(alu_in_b), 
		.opcode(alu_ctrl2_out), 
		.out(alu_out), 
		.comp(comp)
	);

	Mux2x1 alu_bypass_mux(
		.a(alu_out), 
		.b(alu_imm2_out), 
		.sel(alu_bypass2_out), 
		.out(alu_bypass_mux_out)
	);

	Mux2x1 aux_feedback_mux(
		.a(aux_out), 
		.b(alu_bypass_mux_out), 
		.sel(/* UNIDADE DE HAZARDS */), 
		.out(aux_feedback_mux_out)
	);
	
	Pipeline_Stage3 ppl3(
		.clk(CLK),
		.rst(RST or /*something here*/), //------------|<flush
		.reg_we_in(reg_we2_out),
		.reg_we_out(reg_we3_out),
		.store_pc_in(store_pc2_out),
		.store_pc_out(store_pc3_out),
		.mem_bypass_in(mem_bypass2_out),
		.mem_bypass_out(mem_bypass3_out),
		.mem_we_in(mem_we2_out),
		.mem_we_out(mem_we3_out),
		.aux_in(aux_feedback_mux_out),
		.aux_out(aux_out),
		.wa_in(wa2_out),
		.wa_out(wa3_out)
	);

//===|Stage 4|=============================|

	Data_Mem data_mem(
		.addr(aux_out), 
		.clk(CLK),
		// Shouldn't rd2 be stored on stage 3?
		.wdata(rd2_2_out), 
		.we(mem_we3_out), 
		.rst(RST),
		.out(mem_out),
		
	);

	Mux2x1 mem_bypass_mux(
		.a(mem_out), 
		.b(aux_out), 
		.sel(mem_bypass3_out), 
		.out(mem_bypass_out)
	);
	
	Pipeline_Stage4 ppl4(
		.clk(CLK),
		.rst(RST or /*something here*/), //------------|<flush

		.reg_we_in(reg_we3_out),
		.reg_we_out(reg_we4_out),
		.store_pc_in(store_pc3_out),
		.store_pc_out(store_pc4_out),

		.mux_in(mem_bypass_out),
		.mux_out(ppl4_out),

		.wa_in(wa3_out),
		.wa_out(wa4_out)
	);

endmodule
