///////////////////////////////////
///////Parametrical adder ////////
/////////////////////////////////
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



//////// Generate parametrical module addre-substractor ////////
module generate_add(a_in, b_in, q_out, c_out);
  parameter WIDTH = 4;
  parameter mode = 0;
  
  input   [WIDTH - 1: 0]  a_in, b_in;
    
  output  [WIDTH - 1: 0]  q_out;
  output  c_out;
   
  wire   [WIDTH - 1: 0]  c, c_in, w_b_in;
  
  assign c_out = c[WIDTH - 1]; 
  
  genvar i;
  generate
    for(i = 0; i < WIDTH; i = i + 1) begin
      if(i >= 1) begin
      assign c_in[i] = c[i - 1]; 
      end
      
      if(mode) begin
        assign c_in[0] = 1'b0;
        assign w_b_in = b_in;
      end
    else begin
     assign c_in[0] = 1'b1;
     assign w_b_in = ~ b_in;
    end
    
    full_add full_add_1(.a_in(a_in[i]), 
                        .b_in(w_b_in[i]), 
                        .c_in(c_in[i]), 
                        .s_out(q_out[i]), 
                        .c_out(c[i])
                        );
    
    end
  endgenerate
endmodule

