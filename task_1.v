///// HALF ADDER /////
module half_add(a_in, b_in, s_out, c_out);
input   a_in, b_in;
output  s_out, c_out;

assign  s_out = a_in ^ b_in;
assign  c_out = a_in & b_in;  
  
endmodule

///// FULL ADDER /////
module full_add(a_in, b_in, c_in, s_out, c_out);
  input   a_in, b_in, c_in;
  output  s_out, c_out;
  
  wire  c_out_1, s_out_1, c_out_2;
  
  half_add half_add_1(  .a_in(a_in),
                        .b_in(b_in),
                        .s_out(s_out_1),
                        .c_out(c_out_1)
                        );
  half_add half_add_2(  .a_in(s_out_1),
                        .b_in(c_in),
                        .s_out(s_out),
                        .c_out(c_out_2)
                        );
                        
  assign c_out = c_out_1 | c_out_2;
  
endmodule

///// FULL 4 BITS ADDER /////
module four_bits_add(a_in, b_in, c_in, s_out, c_out);
  
  input   [3:0] a_in, b_in;
  input         c_in;
  
  output  [3:0] s_out;
  output        c_out;
  
  wire    [3:0] c;
  
  assign  c_out = c[3];
  
  full_add full_add_1(.a_in(a_in[0]), 
                      .b_in(b_in[0]), 
                      .c_in(c_in), 
                      .s_out(s_out[0]), 
                      .c_out(c[0])
                      );

  full_add full_add_2(.a_in(a_in[1]), 
                      .b_in(b_in[1]), 
                      .c_in(c[0]), 
                      .s_out(s_out[1]), 
                      .c_out(c[1])
                      );

  full_add full_add_3(.a_in(a_in[2]), 
                      .b_in(b_in[2]), 
                      .c_in(c[1]), 
                      .s_out(s_out[2]), 
                      .c_out(c[2])
                      );

  full_add full_add_4(.a_in(a_in[3]), 
                      .b_in(b_in[3]), 
                      .c_in(c[2]), 
                      .s_out(s_out[3]), 
                      .c_out(c[3])
                      );
endmodule

