module detecta(input clk,input rst_n, input e0, input e1, input e2, output s1, output s2, output reg led);
  reg [2:0] estado;
  reg [2:0] proximoestado;
 

  localparam [2:0]	INI = 3'd1,
  			B1 = 3'd2,
                    	B2 = 3'd3,
  			OPEN = 3'd4,
  			ERROR = 3'd5;
  					
  
  always @(*) begin
    if(estado == INI)
      proximoestado = e2 ? ((e0==0 & e1==1)? B1: B2) :INI;
    else if (estado == B1)
      proximoestado = e2 ? ((e0==1 & e1==1)? OPEN: ERROR) :B1; 
    else if (estado == B2)
      proximoestado = e2 ? ERROR: B2;
    else if (estado == OPEN)
      proximoestado = INI;
    else if (estado == ERROR)
      proximoestado = e2? INI: ERROR;
  end


  
  always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)
		estado <= INI; 
	else
      estado <= proximoestado;
  end


  assign s1= estado==OPEN?1'b1 : 1'b0;
  assign s2= estado==ERROR?1'b1 : 1'b0;


  
   always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        led <= 0; 
    else if (s1 == 1 && s2 == 0)
        led <= 0; 
    else if (s1 == 0 && s2 == 1)
        led <= ~led; 
    else
        led <= 0; 
end
endmodule
