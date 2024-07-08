`timescale 1ns / 1ps

module SingleCycle_Top_tb import typedefs::*;
();

    // Parameters
    localparam CLK_PERIOD = 10;
    localparam SIM_TIME = 1000; // Tempo total de simulação em ns

    // Inputs
    reg CLK;
    reg RST;
    reg [9:0] SW;

    // Outputs
    wire [9:0] LEDS;
    wire [7:0] HEX0;
    wire [9:0] HEX1;
    wire [5:0] HEX2;
    wire [7:0] HEX3;
    wire [7:0] HEX4;
    wire [7:0] HEX5;

    // Instantiate the Unit Under Test (UUT)
    SingleCycle_Top uut (
        .CLK(CLK),
        .RST(RST),
        .SW(SW),
        .LEDS(LEDS),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #(CLK_PERIOD/2) CLK = ~CLK;
    end

    // Test sequence
    initial begin
	 
		//force uut.control_block.op = ADD;
		// Force specific values to the inst_mem file array
		//
		force uut.inst_mem.file[0] = 16'b0110000000000000;
		force uut.inst_mem.file[1] = 16'b0111000000000001;
		force uut.inst_mem.file[2] = 16'b0110000000010111;
		force uut.inst_mem.file[3] = 16'b0000001111111111;
		force uut.inst_mem.file[4] = 16'b0110000000010111;
		force uut.inst_mem.file[5] = 16'b0110000000011111;
		force uut.inst_mem.file[6] = 16'b0000000000000110;
		force uut.inst_mem.file[7] = 16'b0110000000010000;
		force uut.inst_mem.file[8] = 16'b0110000000011111;
		force uut.inst_mem.file[9] = 16'b0000000000001011;
		force uut.inst_mem.file[10] = 16'b0110000000010001;
		force uut.inst_mem.file[11] = 16'b0110000000010000;
		force uut.inst_mem.file[12] = 16'b0111000000010111;
		force uut.inst_mem.file[13] = 16'b0000001011110111;
		force uut.inst_mem.file[14] = 16'b0110000000010111;
		force uut.inst_mem.file[15] = 16'b0110000000010001;
		force uut.inst_mem.file[16] = 16'b0110000010100000;
		
        // Initialize Inputs
        RST = 1;
		  
        #(CLK_PERIOD * 2);
        RST = 0;
		  
        // Wait for global reset to finish
        #(CLK_PERIOD * 2);
        RST = 1;

//        // Apply stimulus
//        SW = 10'b0000000001;
//        #(CLK_PERIOD * 10);
//        SW = 10'b0000000010;
//        #(CLK_PERIOD * 10);
//        SW = 10'b0000000100;
//        #(CLK_PERIOD * 10);

		
		// Wait for some time to observe the forced values
		#(CLK_PERIOD * 20);

  // Release the forced values
		  //release uut.op;
//        release uut.inst_mem.file[0];
//        release uut.inst_mem.file[1];
//        release uut.inst_mem.file[2];
//        release uut.inst_mem.file[3];
//        release uut.inst_mem.file[4];
//        release uut.inst_mem.file[5];
//        release uut.inst_mem.file[6];
//        release uut.inst_mem.file[7];
//		  release uut.inst_mem.file[8];
//        release uut.inst_mem.file[9];
//        release uut.inst_mem.file[10];
//        release uut.inst_mem.file[11];
//        release uut.inst_mem.file[12];
//        release uut.inst_mem.file[13];
//        release uut.inst_mem.file[14];
//        release uut.inst_mem.file[15];
//		  release uut.inst_mem.file[16];

        // Additional test cases can be added here

        // End simulation
        #(SIM_TIME);
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | CLK = %b | RST = %b | SW = %b | LEDS = %b | HEX0 = %h | HEX1 = %h | HEX2 = %h | HEX3 = %h | HEX4 = %h | HEX5 = %h", 
                 $time, CLK, RST, SW, LEDS, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    end

endmodule
