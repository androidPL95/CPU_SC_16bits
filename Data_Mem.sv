// QUARTUS DOES NOT ACCEPT LOCALPARAM WTFFFFFFFFFFF
// DO NOT USE ADD_SIZE PARAMETER, LET THE BLOCK ITSELF CALCULATE THE VALUE
module Data_Mem
#(
    parameter  WIDTH    = 16  ,
    parameter  DEPTH    = 1024,
    parameter ADD_SIZE = $clog2(DEPTH)
)
(
    input  [ADD_SIZE-1:0] addr   ,
    input                 clk    ,
    input  [WIDTH-1:0]    wdata  ,
    input                 we     ,
    output [WIDTH-1:0]    out    ,
	 
	 output [WIDTH-1:0]	  leds   ,
	 output [WIDTH-1:0]	  hex0   ,
	 output [WIDTH-1:0]	  hex1   ,
	 output [WIDTH-1:0]	  hex2   ,
	 output [WIDTH-1:0]	  hex3   ,
	 output [WIDTH-1:0]	  hex4   ,
	 output [WIDTH-1:0]	  hex5   ,
	 input  [WIDTH-1:0]	  switchs
);

logic [WIDTH-1:0] file [ADD_SIZE-1:0];

logic aux_out;
logic aux_hex0;
logic aux_hex1;
logic aux_hex2;
logic aux_hex3;
logic aux_hex4;
logic aux_hex5;
logic aux_leds;

assign hex0 = aux_hex0;
assign hex1 = aux_hex1;
assign hex2 = aux_hex2;
assign hex3 = aux_hex3;
assign hex4 = aux_hex4;
assign hex5 = aux_hex5;
assign leds = aux_leds;
assign out  = aux_out;

// READ BLOCK
// Read must be async, otherwise we can't implement a single cycle CPU
always_latch begin
    if(we == 1'b0) begin
        aux_out = file[addr];
    end
	 
	aux_hex0 = file[0];
	aux_hex1 = file[1];
	aux_hex2 = file[2];
	aux_hex3 = file[3];
	aux_hex4 = file[4];
	aux_hex5 = file[5];
	aux_leds = file[6];
end

// WRITE BLOCK
always_ff@(posedge clk) begin
	if(we == 1'b1) begin
		if(addr != 7) begin
			file[addr] <= wdata;
			file[7] <= switchs;
		end else begin
			file[7] <= switchs;
		end
	end
end

// InicializaÃ§Ã£o da memÃ³ria
initial begin
    $readmemb("initial_memory_contents.txt", file);
end

endmodule