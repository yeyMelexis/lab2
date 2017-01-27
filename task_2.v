///// TESTBENCH FOR 4 BIT ADDER /////

`timescale 1ns/1ps
module four_bits_add_tb;
  reg [3:0] a_in, b_in;
  reg       c_in;
  
  wire [3:0]  s_out;
  wire        c_out;
  reg  [4:0]  gold_sum;
  
  parameter DELAY = 1;
  integer i,j,k;
  integer count = 0;
  
  initial begin
    a_in = 4'd0;
    b_in = 4'd0;
    c_in = 1'b0;
    gold_sum = 0;
    
    #DELAY;
    
   for(k = 0; k < 2; k = k + 1) begin
     c_in = k;
    for(i = 0; i < 16; i = i + 1) begin
      for(j = 0; j < 16; j = j + 1) begin
        a_in = i;
        b_in = j;
        gold_sum = a_in + b_in + c_in;
        
        #DELAY;
        
        if(gold_sum!== {c_out,s_out}) begin
          $display("error at", $time);
          $display("gold_sum = %d  s_out = %d", gold_sum[3:0], s_out);
          count = count + 1;
        end                    
      end   
    end
 end 
    
    #DELAY;
        
    $display("Number of errors is %d", count);
    
    
    $finish;
  
  end 
  
  four_bits_add four_bits_add_1(.a_in(a_in), 
                                .b_in(b_in), 
                                .c_in(c_in), 
                                .s_out(s_out), 
                                .c_out(c_out)
                                );
  
  
endmodule

