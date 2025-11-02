`include "mycpu.svh"

import mycpu_pkg::*;

module muxm
  (input logic sel_in,
   input logic [15:0] d0_in,
   input logic [15:0] d1_in,
   output logic [15:0] m_out);

//sel_in päättää m_out arvon,kun sel_in on 0 m_out=d_in muuten m_out=d0_in.		   
always_comb
begin : mux_logic
	if (sel_in == 0)
	begin m_out = d0_in;
	end

	else 
	begin m_out = d1_in;
	end 
end : mux_logic
   
endmodule

