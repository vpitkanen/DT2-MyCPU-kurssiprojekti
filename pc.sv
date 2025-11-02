`include "mycpu.svh"

import mycpu_pkg::*;

module pc
  (
   input logic 	       clk,
   input logic 	       rst_n,
   input logic [1:0]   ps_in,
   input logic [15:0]  ins_in,
   input logic [15:0]  ra_in, 
   output logic [15:0] pc_out      
   );

logic [15:0] pc_r;
logic signed [5:0] ba;


//sekvenssi blokissa käydään if else lauseella läpi jokainen ps_in tila ja määritetään seuraava tila.
   always_ff @(posedge clk or negedge rst_n)
     begin : pc_regs

	if (rst_n == '0)
	  begin
	     pc_r <= 16'b0;
	     
	  end

	else
	 begin
	  
          if (ps_in == 2'b01)
	  
	   pc_r <= pc_r + 1;
	  

	  else if (ps_in == 2'b10)
	  begin
	   ba = $signed({ins_in[8:6], ins_in[2:0]}); //klipataan ins_in tulosta 6 bitin bittivektori.
	   pc_r <= $signed(pc_r) + ba;
	  end

     	  else if (ps_in == 2'b11)
	  
           pc_r <= ra_in;
	  
	  else
	   pc_r <= pc_r;
	 end
	  
end : pc_regs

assign pc_out = pc_r; //Yhdistetään pc_r pc_out:iin
   
endmodule
   
