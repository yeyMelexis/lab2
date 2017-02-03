///// TESTBENCH FOR COMPARE GATE LEVEL ALU AND BEHAVIOUR STYLE ALU /////
module ALU_compare_tb;
  
  parameter DATA_WIDTH = 4;
  
  reg  [DATA_WIDTH-1:0] a_in, b_in;
  reg  [2:0]  sel_in;
  wire [2*DATA_WIDTH-1:0] q_out0, q_out1;
  
  integer i, count = 0;
  
  ///////////////////////////
  /// Clock Generator //////
  /////////////////////////
  parameter PERIOD = 4;
  reg clk;
  
  initial begin 
    clk = 0;
    forever #(PERIOD/2) clk = ~clk;
  end
  /////////////////////////
  
  ALU_gate #(.DATA_WIDTH(DATA_WIDTH)) ALU_gate1(  .a_in(a_in), 
                                                  .b_in(b_in), 
                                                  .q_out(q_out0), 
                                                  .sel_in(sel_in));
                      
  ALU_behav #(.DATA_WIDTH(DATA_WIDTH)) ALU_behav1(  .a_in(a_in), 
                                                    .b_in(b_in), 
                                                    .q_out(q_out1), 
                                                    .sel_in(sel_in));                    
  ///////////////////////////
  /////// Testbench ////////
  /////////////////////////  
  initial begin
    a_in = 0;
    b_in = 0;
    sel_in = 0;
    
    repeat(10) begin
      for(i = 0; i < 5; i = i + 1) begin
        @(posedge clk);
        sel_in = i;
        a_in = $random();
        b_in = $random();
      end
    end
      
      $display("Number of ERROR is %d", count);
      $finish;
  end
  
    initial begin
      forever begin
        @(negedge clk);
        if(q_out0 !== q_out1) begin
          $strobe("Error. Time %d", $time);
          $strobe("q_out0 = %d q_out1 = %d", q_out0, q_out1);
          count = count + 1;
        end
      end
    end
 
endmodule

