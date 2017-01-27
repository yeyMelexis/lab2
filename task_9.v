///// NAND 4 BITS /////
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


