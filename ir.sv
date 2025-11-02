`include "mycpu.svh"

import mycpu_pkg::*;

module ir
  (
   input logic 	       clk,
   input logic 	       rst_n,
   input logic 	       il_in,
   input logic [15:0]  ins_in,
   output logic [15:0] ins_out
   );

logic [15:0] ir_r;

always_ff @(posedge clk or negedge rst_n)
    begin : ir_regs
	if (rst_n == '0)
	 begin
	     ir_r <= '0;
	 end

	else
	 begin
	  if (il_in == '1)
	  
             ir_r <= ins_in;
          else
             ir_r <= ir_r;	     
	  end
    end

assign ins_out = ir_r;
      
endmodule


