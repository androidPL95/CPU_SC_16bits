module tb_Mem;

// Parameters
parameter WIDTH = 16;
parameter DEPTH = 1024;
parameter ADD_SIZE = $clog2(DEPTH);

// Inputs
reg [ADD_SIZE-1:0] addr;
reg clk;
reg [WIDTH-1:0] wdata;
reg we;
reg rst;

// Outputs
wire [WIDTH-1:0] out;

// Instantiate the module
Mem #(WIDTH, DEPTH, ADD_SIZE) uut (
    .addr(addr),
    .clk(clk),
    .wdata(wdata),
    .we(we),
    .rst(rst),
    .out(out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns period clock
end

// Test sequence
initial begin
    // Initialize inputs
    addr = 0;
    wdata = 0;
    we = 0;
    rst = 0;
    
    // Apply reset
    rst = 1;
    #10;
    rst = 0;
    #10;
    rst = 1;
    #10;
    
    // Write and read test
    addr = 5;
    wdata = 16'hABCD;
    we = 1;
    #10;
    we = 0;
    #10;
    
    // Check the output
    if (out != 16'hABCD) $display("Test failed: expected 16'hABCD, got %h", out);
    else $display("Test passed: got %h", out);
    
    // Another write and read test
    addr = 10;
    wdata = 16'h1234;
    we = 1;
    #10;
    we = 0;
    #10;
    
    // Check the output
    if (out != 16'h1234) $display("Test failed: expected 16'h1234, got %h", out);
    else $display("Test passed: got %h", out);

    // Test after reset
    rst = 0;
    #10;
    rst = 1;
    #10;

    // Check the output should be 0 after reset
    addr = 5;
    #10;
    if (out != 16'h0000) $display("Test failed after reset: expected 16'h0000, got %h", out);
    else $display("Test passed after reset: got %h", out);

    $stop;
end

endmodule
