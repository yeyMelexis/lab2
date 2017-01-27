module nand_tb;
  parameter DATA_WIDTH = 4;
  parameter DELAY = 2;
  reg   [DATA_WIDTH-1:0] a_in, b_in;
  wire  [DATA_WIDTH-1:0] nand_out;
  
  reg  [DATA_WIDTH-1:0] gold_nand;
  integer i, j, count = 0;
  
  initial begin
    for(i = 0; i < 2**DATA_WIDTH; i = i + 1) begin
      for(j = 0; j < 2**DATA_WIDTH; j = j + 1) begin
        a_in = i;
        b_in = j;
        
        gold_nand = ~(a_in & b_in);
        #0;
        
        if(gold_nand !== nand_out) begin
          $display("error at", $time);
          $display("gold_nand = %d  nand_out = %d", gold_nand, nand_out);
          count = count + 1;
          
        end
        
        #DELAY;
         
      end    
    end
  
  $display("Number of ERROR is %d", count); 
  $finish;
  end 
   
NAND NAND1(.a_in(a_in), 
           .b_in(b_in), 
           .nand_out(nand_out)
           );


endmodule

