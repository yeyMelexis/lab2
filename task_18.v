////////////////////////////////////
/////// Parametrical adder ////////
//////////////////////////////////
module add_4bit(a_in, b_in, c_in, sum_out, c_out);
  parameter DATA_WIDTH = 4;
  ///Inputs
  input   [DATA_WIDTH - 1: 0] a_in, b_in;
  input   c_in;
  //Outputs
  output  [DATA_WIDTH - 1: 0] sum_out;
  output  c_out;
  
  //Wire for carry_in and carry_out
  wire   [DATA_WIDTH - 1: 0] w_c_in, c;
  
  
  assign c_out = c[DATA_WIDTH - 1];
  
  //Generate construction for parametrical adder
  genvar i;
  generate
    for(i = 0; i < DATA_WIDTH; i = i + 1) begin: adder
      if(i >= 1) begin
        assign w_c_in[i] = c[i - 1]; 
      end
      assign w_c_in[0] = c_in;
      
      full_add full_add_1(.a_in(a_in[i]), 
                        .b_in(b_in[i]), 
                        .c_in(w_c_in[i]), 
                        .s_out(sum_out[i]), 
                        .c_out(c[i])
                        );
    end
  endgenerate 
  
  
endmodule

////////////////////////////////
/// Parametrical substractor //
//////////////////////////////


module sub_param(a_in, b_in, bor_in, d_out, bor_out);
  parameter DATA_WIDTH = 4;
  ///Inputs
  input   [DATA_WIDTH - 1: 0] a_in, b_in;
  input   bor_in;
  //Outputs
  output  [DATA_WIDTH - 1: 0] d_out;
  output  bor_out;
  
  //Wire for carry_in and carry_out
  wire   [DATA_WIDTH - 1: 0] w_bor_in, bor;
  
  
  assign bor_out = bor[DATA_WIDTH - 1];
  
  //Generate construction for parametrical adder
  genvar i;
  generate
    for(i = 0; i < DATA_WIDTH; i = i + 1) begin: adder
      if(i >= 1) begin
        assign w_bor_in[i] = bor[i - 1]; 
      end
      assign w_bor_in[0] = bor_in;
      
      full_sub full_sub_1(.a_in(a_in[i]), 
                          .b_in(b_in[i]), 
                          .bor_in(w_bor_in[i]), 
                          .d_out(d_out[i]), 
                          .bor_out(bor[i])
                          );
    end
  endgenerate 
  
  
endmodule



////////////////////////////////////
/////// Parametrical NAND /////////
//////////////////////////////////


module NAND(a_in, b_in, nand_out);
  parameter DATA_WIDTH = 4;
  input   [DATA_WIDTH-1:0] a_in, b_in;
  output  [DATA_WIDTH-1:0] nand_out;
  
  genvar i;
  generate
    for(i = 0; i < DATA_WIDTH; i = i + 1) begin
      nand Nand(nand_out[i], a_in[i], b_in[i]);
    end
  endgenerate
  
  
endmodule




////////////////////////////////////
/////// Parametrical NOR //////////
//////////////////////////////////


module NOR(a_in, b_in, nor_out);
  parameter DATA_WIDTH = 4;
  input   [DATA_WIDTH-1:0] a_in, b_in;
  output  [DATA_WIDTH-1:0] nor_out;
  
  genvar i;
  generate
    for(i = 0; i < DATA_WIDTH; i = i + 1) begin
      nor Nor(nor_out[i], a_in[i], b_in[i]);
    end
  endgenerate
  
  
endmodule





////////////////////////////////////
/////// Parametrical multiplier ///
//////////////////////////////////

module multiplier_param(a_in, b_in, product_out);
  parameter DATA_WIDTH = 4;
  
  input   [DATA_WIDTH - 1: 0] a_in, b_in;
  
  output  [2*DATA_WIDTH - 1: 0] product_out;
  
  wire    [DATA_WIDTH - 1: 0] and_out [DATA_WIDTH - 1: 0];
  wire    [DATA_WIDTH - 1: 0] sum_out [1: DATA_WIDTH - 1];
  wire                        c_out   [1: DATA_WIDTH - 1];
  
  genvar i;
  generate
    for(i = 0; i < DATA_WIDTH; i = i + 1) begin: adder
      assign and_out[i] = a_in & {DATA_WIDTH{b_in[i]}};
      
      if(i > 0) begin
        if(i == 1) begin
            add_4bit #(.DATA_WIDTH(DATA_WIDTH)) add_4bit1 ( .a_in({1'b0, and_out[0][DATA_WIDTH-1: 1]}), 
                                                            .b_in(and_out[1]), 
                                                            .c_in(1'b0), 
                                                            .sum_out(sum_out[i]), 
                                                            .c_out(c_out[i])
                                                            );
        end
        else begin
            add_4bit #(.DATA_WIDTH(DATA_WIDTH)) add_4bit1 ( .a_in({c_out[i-1], sum_out[i-1][DATA_WIDTH-1:1]}), 
                                                            .b_in(and_out[i]), 
                                                            .c_in(1'b0), 
                                                            .sum_out(sum_out[i]), 
                                                            .c_out(c_out[i])
                                                            );
        end        
      end
      
      if(i == 0)  assign product_out[0] = and_out[0][0];
      else  begin if(i < (DATA_WIDTH-1))
                  assign product_out[i] = sum_out[i][0];
                  
            else  assign product_out[2*DATA_WIDTH - 1: DATA_WIDTH - 1] = {c_out[i], sum_out[i]};
            end
    end    
  endgenerate
  
  
endmodule

////////////////////////////////////
/////// Parametrical ALU //////////
//////////////////////////////////

module ALU_param(a_in, b_in, q_out, sel_in);
  
  parameter DATA_WIDTH = 8;
  
  input  [DATA_WIDTH-1:0] a_in, b_in;
  input  [2:0]  sel_in;
  output [2*DATA_WIDTH-1:0] q_out;
  
  wire   [2*DATA_WIDTH-1:0] to_mux [0:4];
  wire   [DATA_WIDTH-1:0] from_out [0:4];
  wire    carry, borrow;
  
  assign  to_mux[0] = {{(DATA_WIDTH-1){1'b0}}, carry,  from_out[0]};
  assign  to_mux[1] = {{DATA_WIDTH{borrow}}, from_out[1]};
  assign  to_mux[3] = {{DATA_WIDTH {1'b0}}, from_out[3]};
  assign  to_mux[4] = {{DATA_WIDTH {1'b0}}, from_out[4]};
  
mux_8bit #(.DATA_WIDTH(DATA_WIDTH)) mux_8bit1(.data0(to_mux[0]), 
                   .data1(to_mux[1]), 
                   .data2(to_mux[2]), 
                   .data3(to_mux[3]), 
                   .data4(to_mux[4]), 
                   .data5(0), 
                   .data6(0), 
                   .data7(0), 
                   .sel(sel_in), 
                   .mux_out(q_out)
                   );
                   
  multiplier_param  #(.DATA_WIDTH(DATA_WIDTH))   mult( .a_in(a_in), 
                                                      .b_in(b_in), 
                                                      .product_out(to_mux[2])
                                                      );   
                          
  add_4bit #(.DATA_WIDTH(DATA_WIDTH)) adder(.a_in(a_in), 
                                            .b_in(b_in), 
                                            .c_in(1'b0), 
                                            .sum_out(from_out[0]), 
                                            .c_out(carry)
                                             );
                                
  sub_param #(.DATA_WIDTH(DATA_WIDTH)) sub(.a_in(a_in), 
                                           .b_in(b_in), 
                                           .bor_in(1'b0), 
                                           .d_out(from_out[1]), 
                                           .bor_out(borrow)
                                            );
                                
 NAND #(.DATA_WIDTH(DATA_WIDTH)) nand_4_bit1( .a_in(a_in), 
                                                    .b_in(b_in), 
                                                    .nand_out(from_out[3]));                                                                                               
                   
 NOR #(.DATA_WIDTH(DATA_WIDTH)) nor_4_bit1(   .a_in(a_in), 
                                                    .b_in(b_in), 
                                                    .nor_out(from_out[4]));   
  
endmodule



