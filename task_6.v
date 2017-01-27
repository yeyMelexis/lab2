
module multiplier_4bit_tb;
  
  reg  [3:0] x_in, y_in;
  wire [7:0] prod_out;
  
  reg  [7:0]  gold_product;
  
  parameter DELAY = 1;
  integer i,j,k;
  integer count = 0;
  
 initial begin
    x_in = 4'd0;
    y_in = 4'd0;
    gold_product = 0;
    
    #DELAY;
    
    for(i = 0; i < 16; i = i + 1) begin
      for(j = 0; j < 16; j = j + 1) begin
        x_in = i;
        y_in = j;
        gold_product = x_in * y_in;
        
        #DELAY;
        
        if(gold_product!== prod_out) begin
          $display("error at", $time);
          $display("gold_product = %d  prod_out = %d", gold_product, prod_out);
          count = count + 1;
        end                      
      end   
  end
     
    #DELAY;  
    
    $display("Number of errors is %d", count);  
   
    $finish; 
  end 
  
  multiplier_4bit mult_1( .x_in(x_in), 
                          .y_in(y_in), 
                          .prod_out(prod_out)
                          );
  
  
  
endmodule


