module detecta_tb;
  
  reg clk, rst_n, E0, E1, E2;
  wire S1, S2;
  reg LED;
  
  detecta detecta_u0 (.clk(clk), .rst_n(rst_n), .e0(E0),.e2(E2),.e1(E1), .s1(S1), .s2(S2), .led(LED));
  
  initial begin
    clk = 0;
    while (1) begin
      #10;
      clk=~clk;
    end;
  end
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars;
    
    E0=0; E1=0; E2=0; rst_n=0;
    @(negedge clk);
    rst_n=1;
  	@(negedge clk);  
    //CORRETO
    E0=0;
    E1=1;
    E2=1;
    @(negedge clk);
    E2=0;
    @(negedge clk);
    E1=1;
    E0=1;
    E2=1;
    @(negedge clk);
    E2=0;
    //ERRADO
    @(negedge clk);
    E0=1;
    E1=1;
    E2=1;
    @(negedge clk);
    E2=0;
    @(negedge clk);
    E1=1;
    E0=1;
    E2=1;
    @(negedge clk);
    E2=0;
    repeat (10) @(negedge clk);
    E2=1;
    @(negedge clk);
    E2=0;
    #200;
  
    $finish();
    end
 
endmodule
      
