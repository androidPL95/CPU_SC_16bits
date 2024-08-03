module SingleCycle_Top import typedefs::*;
(
	input				CLK	,
	input				RST	,
	input	 [9:0]	SW		,
	output [9:0]	LEDS	,
	output [7:0]	HEX0	,
	output [9:0]	HEX1	,
	output [5:0]	HEX2	,
	output [7:0]	HEX3	,
	output [7:0]	HEX4	,
	output [7:0]	HEX5
);

	/************************
	*   WIRE DECLARATIONS   *
	************************/

	wire [15:0] sel_pc_out;
	wire [15:0] pc_out;
	wire [15:0] im_out;
	wire [15:0] alu_in;
	wire [15:0] rd1;
	wire [15:0] rd2;
	wire [15:0] alu_imm_out;
	wire [15:0] alu_out;
	wire [15:0] alu_bypass_out;
	wire [15:0] aux_out;
	wire [15:0] mem_out;
	wire [15:0] mem_bypass_out;
	wire [15:0] store_pc_out;
	wire [15:0] sum_imm_out;
	wire [15:0] int_addr;
	wire [15:0] int_mux_out;
	wire		enable_interrupt;
	// Use this signal to indicate routine end, following the load of original PC
	wire		end_routine;
	wire [15:0] rtrn_addr;

	wire        ier_set_flag;
	wire        ier_unset_flag;
	wire        ifr_set_flag;
	wire        ifr_unset_flag;
	wire        end_routine;

	opcode_t           op;
	wire               comp;
	wire               sel_pc;    
	wire               sum_imm;   
	wire               store_pc;  
	wire               reg_we;    
	wire               alu_imm;   
	alu_opcode_t       alu_ctrl;  
	wire               alu_bypass;
	wire					 alu_feedback_in;
	wire               mem_we;    
	wire               mem_bypass;

	/*************************
	*     INSTANTIATIONS     *
	*************************/

	Controller control_block(
		.clk(CLK), 
		.op(opcode_t'(im_out[15:10])), 
		.comp(comp), 
		.sel_PC(sel_pc), 
		.sum_imm(sum_imm), 
		.store_pc(store_pc), 
		.reg_we(reg_we), 
		.alu_imm(alu_imm), 
		.alu_ctrl(alu_ctrl), 
		.alu_bypass(alu_bypass),
		.alu_feedback_in(alu_feedback_in),
		.mem_we(mem_we), 
		.mem_bypass(mem_bypass),
		.ier_set_flag,
		.ier_unset_flag,
		.ifr_set_flag,
		.ifr_unset_flag,
		.end_routine
	);

	// STILL NEED TO CONNECT THE INTERRUPTION SIGNALS
	InterruptController int_cont (
		.clk,
    	.rst,
    	.reg_addr(im_out[9:0]),
		.ier_set_flag,
		.ier_unset_flag,
		.ifr_set_flag,
		.ifr_unset_flag,
		.end_routine,
		.rtrn_addr_in(pc_out),
		.enable(enable_interrupt),
		.addr_out(int_addr)
	);
	
	Mux2x1 feedback_mux(
		.a(rd1), 
		.b(aux_out), 
		.sel(alu_feedback_in), 
		.out(alu_in)
	);

	Mux2x1 pc_mux(
		.a(pc_out + sum_imm_out), 
		.b(aux_out), 
		.sel(sel_pc), 
		.out(sel_pc_out)
	);

	// SELECT SIGNAL NEEDS TO BE 
	Mux2x1 int_mux (
		.a(sel_pc_out),
		.b(int_addr),
		.sel(enable_interrupt),
		.out(int_mux_out)
	)
	
	Mux2x1 sum_imm_mux(
		.a(16'h1), 
		.b(aux_out), 
		.sel(sum_imm), 
		.out(sum_imm_out)
	);

	Reg pc(
		.in(int_mux_out), 
		.clk(CLK),
		.rst(RST), 
		.out(pc_out)
	);
	
	
	Mem inst_mem(
		.addr(pc_out[9:0]), 
		.clk(CLK), 
		.wdata('0), 
		.we('0),
		.rst('1),
		.out(im_out)
	);

	RegFile reg_file(
		.a1(im_out[9:5]), 
		.a2(im_out[4:0]), 
		.wdata(store_pc_out), 
		.we(reg_we), 
		.clk(CLK),
		.rst(RST),
		.rd1(rd1), 
		.rd2(rd2)
	);

	Mux2x1 alu_imm_mux(
		.a(rd2), 
		.b({8'h0, im_out[7:0]}), 
		.sel(alu_imm), 
		.out(alu_imm_out)
	);

	ALU my_alu(
		.a(alu_in), 
		.b(alu_imm_out), 
		.opcode(alu_ctrl), 
		.out(alu_out), 
		.comp(comp)
	);

	Mux2x1 alu_bypass_mux(
		.a(alu_out), 
		.b(alu_imm_out), 
		.sel(alu_bypass), 
		.out(alu_bypass_out)
	);

	Reg aux(
		.in(alu_bypass_out), 
		.clk(CLK), 
		.rst(RST),
		.out(aux_out)
	);

	Data_Mem data_mem(
		.addr(aux_out), 
		.clk(CLK), 
		.wdata(rd2), 
		.we(mem_we), 
		.rst(RST),
		.out(mem_out),
		
		.leds(LEDS),
		.hex0(HEX0),
		.hex1(HEX1),
		.hex2(HEX2),
		.hex3(HEX3),
		.hex4(HEX4),
		.hex5(HEX5),
		.switchs(SW)
	);

	Mux2x1 mem_bypass_mux(
		.a(mem_out), 
		.b(aux_out), 
		.sel(mem_bypass), 
		.out(mem_bypass_out)
	);


	Mux2x1 store_pc_mux(
		.a(mem_bypass_out), 
		.b(pc_out), 
		.sel(store_pc), 
		.out(store_pc_out)
	);

endmodule
