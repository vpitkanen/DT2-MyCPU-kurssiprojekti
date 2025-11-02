`include "mycpu.svh"

import mycpu_pkg::*;

module muxb
  (input logic sel_in,
   input logic [15:0] d0_in,
   input logic [15:0] d1_in,
   output logic [15:0] m_out);

//Tulon d1_in ollessa valittuna lähdön m_out bittien m_out[2:0] arvoiksi asetetaan tulon d1_in bittien d1_in[2:0] arvot
// ja lähdön bittien m_out[15:3] arvoiksi asetetaan 0. Tulon d0_in ollessa valittuna lähtö on m_out	   
always_comb
begin : mux_logic
	if (sel_in == '0)
	begin m_out = d0_in;
	end

	else
	begin
	m_out[15:3] = '0;
	m_out[2:0] = d1_in[2:0];
	end
end : mux_logic
   
   
endmodule

