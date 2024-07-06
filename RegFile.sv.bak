// QUARTUS DOES NOT ACCEPT LOCALPARAM WTFFFFFFFFFFF
// DO NOT USE ADD_SIZE PARAMETER, LET THE BLOCK ITSELF CALCULATE THE VALUE
module RegFile
#(
    parameter  WIDTH     = 16,
    parameter  DEPTH     = 32,
    parameter ADDR_SIZE = $clog2(DEPTH)
)
(
    input  [ADDR_SIZE-1:0] a1    ,
    input  [ADDR_SIZE-1:0] a2    ,
    input  [WIDTH-1:0]     wdata ,
    input                  we    ,
    input                  clk   ,
    input                  rst   ,
    output [WIDTH-1:0]     rd1   ,
    output [WIDTH-1:0]     rd2
);

logic [WIDTH-1:0] file [ADDR_SIZE-1:0];

logic [WIDTH-1:0] out1 , out2;

assign rd1 = out1;
assign rd2 = out2;

// READ BLOCK
// as said before, needs to be async
always_latch begin
    if(rst == 1'b0) begin
		for(int i = 0 ; i < ADDR_SIZE ; ++i) begin
			file[i] = '0;
		end
	end
    else if(we == 1'b0) begin
        out1 = file[a1];
        out2 = file[a2];
    end
end

// WRITE BLOCK
always_ff@(posedge clk) begin
    if((we == 1'b1) && (rst == 1'b1)) begin
        file[a1] <= wdata;
    end
end

endmodule