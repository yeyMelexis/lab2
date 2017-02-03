///// TESTBENCH FOR SUBSTRACTOR /////
`timescale 1ns/1ps
module four_bits_sub_tb;
  reg [3:0] a_in, b_in;
  reg       bor_in;
  
  wire [3:0]  d_out;
  wire        bor_out;
  
  reg  [4:0]  gold_sub;
  
  parameter DELAY = 1;
  integer i,j,k;
  integer count = 0;
  
  
  ///////////////////////////
  /// Clock Generator //////
  /////////////////////////
  parameter PERIOD = 4;
  reg clk;
  
  initial begin 
    clk = 0;
    forever #(PERIOD/2) clk = ~clk;
  end
  /////////////////////////
  initial begin    
   for(k = 0; k < 2; k = k + 1) begin
    for(i = 0; i < 16; i = i + 1) begin
      for(j = 0; j < 16; j = j + 1) begin
        @(posedge clk)
        bor_in = k;
        a_in = i;
        b_in = j;
        gold_sub = a_in - b_in - bor_in;                     
      end   
    end
  end 
    
    #DELAY;   
    $display("Number of errors is %d", count);   
    $finish; 
  end 
    
  initial begin
    forever begin
      @(negedge clk);
      if(gold_sub!== {bor_out,d_out}) begin
          $display("error at", $time);
          $display("gold_sub = %d  d_out = %d", gold_sub[3:0], d_out);
          count = count + 1;
      end
    end
  end
  four_bits_sub four_bits_sub_1(.a_in(a_in), 
                                .b_in(b_in), 
                                .bor_in(bor_in), 
                                .d_out(d_out), 
                                .bor_out(bor_out)
                                );
  
  
endmodule


