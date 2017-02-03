//// MULTIPLEXOR ////
module mux(a, b, c, out);
  
parameter DATA_WIDTH = 4;
input   [DATA_WIDTH - 1:0] a, b;
input         c;
output  [DATA_WIDTH - 1:0] out;

assign  out = a & ~{DATA_WIDTH{c}} | b & {DATA_WIDTH{c}};

endmodule


////		  For ALU 			////
//// MULTIPLEXOR 8 DATA INPUTS ////
module mux_8bit(data0, 
                data1, 
                data2, 
                data3, 
                data4, 
                data5, 
                data6, 
                data7, sel, mux_out);
                
  parameter DATA_WIDTH = 4;              
  input   [DATA_WIDTH - 1:0]  data0, 
                              data1, 
                              data2, 
                              data3, 
                              data4, 
                              data5, 
                              data6, 
                              data7;
                
  input   [2:0] sel;
  
  output  [DATA_WIDTH - 1:0] mux_out;
  
  wire    [DATA_WIDTH - 1:0] mux_1bit [0:5];
  
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux1( .a(data0), 
            .b(data1), 
            .c(sel[0]), 
            .out(mux_1bit[0]));
  
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux2( .a(data2), 
            .b(data3), 
            .c(sel[0]), 
            .out(mux_1bit[1]));
            
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux3( .a(data4), 
            .b(data5), 
            .c(sel[0]), 
            .out(mux_1bit[2]));
            
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux4( .a(data6), 
            .b(data7), 
            .c(sel[0]), 
            .out(mux_1bit[3]));          
            
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux5( .a(mux_1bit[0]), 
            .b(mux_1bit[1]), 
            .c(sel[1]), 
            .out(mux_1bit[4]));
            
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux6( .a(mux_1bit[2]), 
            .b(mux_1bit[3]), 
            .c(sel[1]), 
            .out(mux_1bit[5])); 
            
  mux #(.DATA_WIDTH(DATA_WIDTH)) mux7( .a(mux_1bit[4]), 
            .b(mux_1bit[5]), 
            .c(sel[2]), 
            .out(mux_out));                              
endmodule


