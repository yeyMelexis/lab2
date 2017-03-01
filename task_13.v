///// ALU GATE LEVEL /////
module ALU_gate(a_in, b_in, q_out, sel_in);
  
  parameter DATA_WIDTH= 4;
  
  input  [DATA_WIDTH-1:0] a_in, b_in;
  input  [2:0]  sel_in;
  output [2*DATA_WIDTH-1:0] q_out;
  
  wire   [2*DATA_WIDTH-1:0] to_mux [0:4];
  wire   [DATA_WIDTH-1:0] from_out [0:4];
  wire    carry, borrow;
  
  assign  to_mux[0] = {1'b0, 1'b0, 1'b0, carry,  from_out[0]};
  assign  to_mux[1] = {borrow, borrow, borrow, borrow, from_out[1]};
  assign  to_mux[3] = {1'b0, 1'b0, 1'b0, 1'b0, from_out[3]};
  assign  to_mux[4] = {1'b0, 1'b0, 1'b0, 1'b0, from_out[4]};
  
mux_8bit #(.DATA_WIDTH(2*DATA_WIDTH)) mux_8bit1(.data0(to_mux[0]), 
											   .data1(to_mux[1]), 
											   .data2(to_mux[2]), 
											   .data3(to_mux[3]), 
											   .data4(to_mux[4]), 
											   .data5(4'd0), 
											   .data6(4'd0), 
											   .data7(4'd0), 
											   .sel(sel_in), 
											   .mux_out(q_out)
											   );
                   
  multiplier_4bit mult_1( .x_in(a_in), 
                          .y_in(b_in), 
                          .prod_out(to_mux[2])
                          );   
                          
  four_bits_add four_bits_add_1(.a_in(a_in), 
                                .b_in(b_in), 
                                .c_in(1'b0), 
                                .s_out(from_out[0]), 
                                .c_out(carry)
                                );
                                
  four_bits_sub four_bits_sub_1(.a_in(a_in), 
                                .b_in(b_in), 
                                .bor_in(1'b0), 
                                .d_out(from_out[1]), 
                                .bor_out(borrow)
                                );
                                
 NAND nand_4_bit1( .a_in(a_in), 
                         .b_in(b_in), 
                         .nand_out(from_out[3]));                                                                                               
                   
 NOR nor_4_bit1(   .a_in(a_in), 
                         .b_in(b_in), 
                         .nor_out(from_out[4]));   
  
endmodule

