module Mux2x1
( 
  input  [15:0] a   ,
  input  [15:0] b   ,
  input  sel ,
  output [15:0] out 
);

logic [15:0] aux;

assign out = aux;

always_comb begin
//    if((sel != 1'b0) && (sel != 1'b1)) begin
//        aux = 1'bX;
//    end
//    else begin
        aux = (sel == 1'b1) ? b : a;
//    end
end

endmodule