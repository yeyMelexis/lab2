/////////////////////////////
//***Parametrical ADDER***//
///////////////////////////
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


//////////Parametrical adder-substractor //////////

`define ADD
//`define SUB

module ifdef_add(a_in, b_in, q_out, c_out);
  
  parameter DATA_WIDTH = 8;

  input   [DATA_WIDTH - 1: 0]  a_in, b_in;
  wire    [DATA_WIDTH - 1: 0]  w_b_in;
    
  output  [DATA_WIDTH - 1: 0]  q_out;
  output  c_out;
  
  wire c_in;
  
  `ifdef ADD
  assign c_in   = 1'b0;
  assign w_b_in = b_in;
 `else
  assign c_in   =   1'b1;
  assign w_b_in = ~ b_in;
  `endif
   
  
  add_4bit #(.DATA_WIDTH(DATA_WIDTH)) add_4bit1( .a_in(a_in), 
												 .b_in(w_b_in), 
												 .c_in(c_in), 
												 .sum_out(q_out), 
												 .c_out(c_out)
												 );
  
  
endmodule
