///// ALU BEHAVIOUR STYLE /////
module ALU_behav(a_in, b_in, q_out, sel_in);
  parameter DATA_WIDTH = 4;
  
  input  [DATA_WIDTH-1:0] a_in, b_in;
  input  [2:0]  sel_in;
  output reg [2*DATA_WIDTH-1:0] q_out;
  
  always @* begin
    case(sel_in)
      3'd0: q_out = a_in + b_in;
      3'd1: q_out = a_in - b_in;
      3'd2: q_out = a_in * b_in;
      3'd3: q_out = {4'd0, ~(a_in & b_in)};
      3'd4: q_out = {4'd0, ~(a_in | b_in)};
      default: q_out = 0;
    endcase
  
  end
  
endmodule

