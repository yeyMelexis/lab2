//// HALF SUBSCTRACTOR ////
module half_sub(a_in, b_in, d_out, bor_out);
input   a_in, b_in;
output  d_out, bor_out;

assign  d_out =   a_in ^ b_in;
assign  bor_out = ! a_in & b_in;  
  
endmodule

//// FULL SUBSCTRACTOR ////
module full_sub(a_in, b_in, bor_in, d_out, bor_out);
  input   a_in, b_in, bor_in;
  output  d_out, bor_out;
  
  wire  bor_out_1, d_out_1, bor_out_2;
  
  half_sub half_sub_1(  .a_in(a_in),
                        .b_in(b_in),
                        .d_out(d_out_1),
                        .bor_out(bor_out_1)
                        );
  half_sub half_sub_2(  .a_in(d_out_1),
                        .b_in(bor_in),
                        .d_out(d_out),
                        .bor_out(bor_out_2)
                        );
                        
  assign bor_out = bor_out_1 | bor_out_2;
  
endmodule

//// FULL 4 BITS SUBSCTRACTOR ////
module four_bits_sub(a_in, b_in, bor_in, d_out, bor_out);
  
  input   [3:0] a_in, b_in;
  input         bor_in;
  
  output  [3:0] d_out;
  output        bor_out;
  
  wire    [3:0] bor;
  
  assign  bor_out = bor[3];
  
  full_sub full_sub_1(.a_in(a_in[0]), 
                      .b_in(b_in[0]), 
                      .bor_in(bor_in), 
                      .d_out(d_out[0]), 
                      .bor_out(bor[0])
                      );

  full_sub full_sub_2(.a_in(a_in[1]), 
                      .b_in(b_in[1]), 
                      .bor_in(bor[0]), 
                      .d_out(d_out[1]), 
                      .bor_out(bor[1])
                      );

  full_sub full_sub_3(.a_in(a_in[2]), 
                      .b_in(b_in[2]), 
                      .bor_in(bor[1]), 
                      .d_out(d_out[2]), 
                      .bor_out(bor[2])
                      );

  full_sub full_sub_4(.a_in(a_in[3]), 
                      .b_in(b_in[3]), 
                      .bor_in(bor[2]), 
                      .d_out(d_out[3]), 
                      .bor_out(bor[3])
                      );
endmodule




