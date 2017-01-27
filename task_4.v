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
  
  initial begin

    a_in = 4'd0;
    b_in = 4'd0;
    bor_in = 1'b0;
    gold_sub = 0;
    
    #DELAY;
    
   for(k = 0; k < 2; k = k + 1) begin
     bor_in = k;
    for(i = 0; i < 16; i = i + 1) begin
      for(j = 0; j < 16; j = j + 1) begin
        a_in = i;
        b_in = j;
        gold_sub = a_in - b_in - bor_in;
        
        #DELAY;
        
        if(gold_sub!== {bor_out,d_out}) begin
          $display("error at", $time);
          $display("gold_sub = %d  d_out = %d", gold_sub[3:0], d_out);
          count = count + 1;
        end
        
               
      end   
    end
 end 
    
    #DELAY;
    
    
    $display("Number of errors is %d", count);
    
    
    $finish;
  
  end 
  
  four_bits_sub four_bits_sub_1(.a_in(a_in), 
                                .b_in(b_in), 
                                .bor_in(bor_in), 
                                .d_out(d_out), 
                                .bor_out(bor_out)
                                );
  
  
endmodule


