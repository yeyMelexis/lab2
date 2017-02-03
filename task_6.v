module multiplier_4bit_tb;
  
  reg  [3:0] x_in, y_in;
  wire [7:0] prod_out;
  
  reg  [7:0]  gold_product;
  
  parameter DELAY = 1;
  integer i,j,k;
  integer count = 0;
  
  ///////////////////////////
  /// Clock Generator //////
  /////////////////////////
  parameter PERIOD = 4;
  reg clk;
  
  initial begin 
    clk = 0;
    forever #(PERIOD/2) clk = ~clk;
  end
  /////////////////////////////
  
 initial begin    
    for(i = 0; i < 16; i = i + 1) begin
      for(j = 0; j < 16; j = j + 1) begin
        @(posedge clk);
        x_in = i;
        y_in = j;
        gold_product = x_in * y_in;                                
      end   
  end
     
    #DELAY;     
    $display("Number of errors is %d", count);     
    $finish; 
  end 
  
  initial begin
    forever begin
      @(negedge clk);
      if(gold_product !== prod_out) begin
          $display("error at", $time);
          $display("gold_product = %d  prod_out = %d", gold_product, prod_out);
          count = count + 1;          
      end
    end
  end
  
  multiplier_4bit mult_1( .x_in(x_in), 
                          .y_in(y_in), 
                          .prod_out(prod_out)
                          );
  
  
  
endmodule


