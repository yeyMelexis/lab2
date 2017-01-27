///// MULTIPLEXOR TESTBENCH /////
`timescale 1 ns / 1 ps
module mux_8bit_tb;
  
  parameter DATA_WIDTH = 8;   
  reg   [DATA_WIDTH - 1:0] data [0:7];
  reg   [2:0] sel;
  
  wire  [DATA_WIDTH - 1:0] mux_out;
  
  integer i;
  
  initial begin
    
    sel = 0;
    for (i = 0; i < 8; i = i + 1) begin
      data[i] = $random();
    end
    
    repeat(20) begin
      sel = $random();
      #2;
    end
    
    $finish;
    
  end
  
  
  mux_8bit #(.DATA_WIDTH(DATA_WIDTH)) mux_8bit1(.data0(data[0]), 
                                                .data1(data[1]), 
                                                .data2(data[2]), 
                                                .data3(data[3]), 
                                                .data4(data[4]), 
                                                .data5(data[5]), 
                                                .data6(data[6]), 
                                                .data7(data[7]), 
                                                .sel(sel), 
                                                .mux_out(mux_out)
                                                );
  
  
  
endmodule
