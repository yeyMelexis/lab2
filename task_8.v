///// MULTIPLEXOR TESTBENCH /////
`timescale 1 ns / 1 ps
//multiplexor testbench
module mux_tb;
  
parameter DATA_WIDTH = 8;
reg   [DATA_WIDTH - 1:0] a, b;
reg         c;
wire  [DATA_WIDTH - 1:0] out;

initial begin
  a = $random;
  b = $random;
  
  c = 1'b0;
  #5    if(a !== out) $display("ERROR: c = %b", c);
        else $display("No ERRORS c = 0");
  c = 1'b1;
  #5    if(b !== out) $display("ERROR: c = %b", c);
        else $display("No ERRORS c = 1");
  
  #2 $finish;
end


mux #(.DATA_WIDTH (DATA_WIDTH )) mux1( .a(a), 
									  .b(b), 
									  .c(c), 
									  .out(out)
									  );

endmodule

