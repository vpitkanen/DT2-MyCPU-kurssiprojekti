`include "mycpu.svh"

import mycpu_pkg::*;

module muxd
  #(parameter N = 3)
  (input logic [$clog2(N)-1:0] sel_in,
   input logic [N-1:0][15:0]  d_in,
   output logic [15:0] m_out);
   
//Kun sel_in on pienempi kuin suoritetaan m_out = d_in[sel_in], jos sel_in > N niin m_out = 0
always_comb
begin : mux_logic
	if (sel_in < N)
	begin 
	m_out = d_in[sel_in];
	end

	else
	begin
	m_out = 0;
	end

end : mux_logic

endmodule
