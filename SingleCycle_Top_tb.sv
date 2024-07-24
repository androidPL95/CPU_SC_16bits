`timescale 1ns / 1ps

module SingleCycle_Top_tb import typedefs::*;
();

    // Parameters
    localparam CLK_PERIOD = 10;
    localparam SIM_TIME = 1000; // Tempo total de simulação em ns

    // Inputs
    reg CLK;
    reg RST;


    // Instantiate the Unit Under Test (UUT)
    SingleCycle_Top uut (
        .CLK(CLK),
        .RST(RST),
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #(CLK_PERIOD/2) CLK = ~CLK;
    end

    // Test sequence
    initial begin
		
        // Initialize Inputs
        RST = 1;
		  
        #(CLK_PERIOD * 2);
        RST = 0;
		  
        // Wait for global reset to finish
        #(CLK_PERIOD * 2);
        RST = 1;

		
		// Wait for some time to observe the forced values
		#(CLK_PERIOD * 20);


        // Additional test cases can be added here

        // End simulation
        #(SIM_TIME);
        $finish;
    end

endmodule
