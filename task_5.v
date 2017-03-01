//// MULTIPLIER ////
module multiplier_4bit(x_in, y_in, prod_out);

  input     [3:0]  x_in, y_in;
  output    [7:0]  prod_out;
  
  wire      [3:0]  summand[0:3];
  
  wire  [3:0] sum [0:2];
  wire        c   [0:2];
  
  
  assign summand[0] = x_in & {4{y_in[0]}};
  assign summand[1] = x_in & {4{y_in[1]}};
  assign summand[2] = x_in & {4{y_in[2]}};
  assign summand[3] = x_in & {4{y_in[3]}};
  
  four_bits_add four_bits_add_0(.a_in(summand[1]), 
                                .b_in({1'b0, summand[0][3:1]}), 
                                .c_in(1'b0), 
                                .s_out(sum[0]), 
                                .c_out(c[0])
                                );
  
  four_bits_add four_bits_add_1(.a_in(summand[2]), 
                                .b_in({c[0], sum[0][3:1]}), 
                                .c_in(1'b0), 
                                .s_out(sum[1]), 
                                .c_out(c[1])
                                );
  four_bits_add four_bits_add_2(.a_in(summand[3]), 
                                .b_in({c[1], sum[1][3:1]}), 
                                .c_in(1'b0), 
                                .s_out(sum[2]), 
                                .c_out(c[2])
                                );  
  
  assign  prod_out = {c[2], sum[2], sum[1][0], sum[0][0], summand[0][0]};                           
  
  
endmodule

