module Mux2x1
( 
  input  a   ,
  input  b   ,
  input  sel ,
  output out 
);

logic aux;

assign out = aux;

always_comb begin
    if((sel != 1'b0) && (sel != 1'b1)) begin
        aux = 1'bX;
    end
    else begin
        aux = (sel == 1'b1) ? b : a;
    end
end

endmodule