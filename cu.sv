`include "mycpu.svh"

import mycpu_pkg::*;

module cu
  (
   input logic 	       clk,
   input logic 	       rst_n,
   input logic [15:0]  ins_in,
   input logic [1:0]   nz_in,
   output logic        il_out,
   output logic [1:0]  ps_out,
   output logic        rw_out,
   output logic [11:0] rs_out,
   output logic [3:0]  mx_out,
   output 	       fs_t fs_out, 
   output logic        wen_out,
   output logic        iom_out   
   );

   cu_state_t          st_r;
   cu_state_t          ns;   
   opcode_t 	       opcode;


assign opcode = opcode_t'(ins_in[15:9]);


//sekvenssi prosessilla tilan siirtymiset
always_ff @(posedge clk or negedge rst_n)
     begin : fsm_state
	if (rst_n == 0)
	  st_r <= RST;
	else
	  st_r <= ns;
     end : fsm_state



//kombinaatio logiikalla tilojen dekoodaus 
always_comb
     begin : fsm_logic
//default arvot(vältetään latcheja)
	ns = INF;
	ps_out = 2'b11;
	il_out = '0;
	rw_out = '0;
	rs_out = 12'b111111111111;
	mx_out = 4'b1111;
	fs_out = FMOVA;
	wen_out = '1;
	iom_out = '0;


case (st_r)
	RST: begin
	ns = INF;
	ps_out = 2'b00;
	il_out = '0;
	rw_out = '0;
	rs_out = 12'b000000000000;
	mx_out = 4'b0000;
	fs_out = FMOVA;
	wen_out = '1;
	iom_out = '0;
	end

	INF: begin
	ns = EX0;
	ps_out = 2'b00;
	il_out = '1;
	rw_out = '0;
	rs_out = 12'b000000000000;
	mx_out = 4'b0001;
	fs_out = FMOVA;
	wen_out = '1;
	iom_out = '0;
	end

	HLT: begin
	ns = HLT;
	ps_out = 2'b00;
	il_out = '0;
	rw_out = '0;
	rs_out = 12'b000000000000;
	mx_out = 4'b0000;
	fs_out = FMOVA;
	wen_out = '0;
	iom_out = '0;
	end
	


	EX0: begin
		case(opcode)
			MOVA: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0]};
			mx_out = 4'b0100;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '0;
			end

			INC: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FINC;
			wen_out = '1;
			iom_out = '0;
			end
			ADD: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FADD;
			wen_out = '1;
			iom_out = '0;
			end
			MUL: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FMUL;
			wen_out = '1;
			iom_out = '0;
			end
			SRA: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b1100;
			fs_out = FSRA;
			wen_out = '1;
			iom_out = '0;
			end
			SUB: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FSUB;
			wen_out = '1;
			iom_out = '0;
			end
			DEC: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FDEC;
			wen_out = '1;
			iom_out = '0;
			end
			SLA: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b1100;
			fs_out = FSLA;
			wen_out = '1;
			iom_out = '0;
			end
			AND: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FAND;
			wen_out = '1;
			iom_out = '0;
			end
			OR: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FOR;
			wen_out = '1;
			iom_out = '0;
			end
			XOR: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FXOR;
			wen_out = '1;
			iom_out = '0;
			end
			NOT: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FNOT;
			wen_out = '1;
			iom_out = '0;
			end
			MOVB: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FMOVB;
			wen_out = '1;
			iom_out = '0;
			end
			SHR: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FSHR;
			wen_out = '1;
			iom_out = '0;
			end
			SHL: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FSHL;
			wen_out = '1;
			iom_out = '0;
			end
			USR: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0100;
			fs_out = FUSR;
			wen_out = '1;
			iom_out = '0;
			end
			LD: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0010;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '0;
			end
			ST: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '0;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '0;
			iom_out = '0;
			end
			LDI: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b1100;
			fs_out = FMOVB;
			wen_out = '1;
			iom_out = '0;
			end
			ADI: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b1100;
			fs_out = FADD;
			wen_out = '1;
			iom_out = '0;
			end
			BRZ: begin
			if (nz_in[0]) begin
				ns = INF;
				ps_out = 2'b10;
				il_out = '0;
				rw_out = '0;
				rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
				mx_out = 4'b0000;
				fs_out = FMOVA;
				wen_out = '1;
				iom_out = '0;
			end else begin
			
				ns = INF;
				ps_out = 2'b01;
				il_out = '0;
				rw_out = '0;
				rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
				mx_out = 4'b0000;
				fs_out = FMOVA;
				wen_out = '1;
				iom_out = '0;
				end
			end
			BRN: begin
			    if (nz_in[1]) begin
				ns = INF;
				ps_out = 2'b10;
				il_out = 1'b0;
				rw_out = 1'b0;
				rs_out = {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0]};
				mx_out = 4'b0000;
				fs_out = FMOVA;
				wen_out = 1'b1;
				iom_out = 1'b0;
			    end else begin
				ns = INF;
				ps_out = 2'b01;
				il_out = 1'b0;
				rw_out = 1'b0;
				rs_out = {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0]};
				mx_out = 4'b0000;
				fs_out = FMOVA;
				wen_out = 1'b1;
				iom_out = 1'b0;
			    end
			end
			JMP: begin
			ns = INF;
			ps_out = 2'b11;
			il_out = '0;
			rw_out = '0;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '0;
			end
			IOR: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '1;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '1;
			end
			IOW: begin
			ns = INF;
			ps_out = 2'b01;
			il_out = '0;
			rw_out = '0;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '0;
			iom_out = '1;
			end
			HAL: begin
			ns = HLT;
			ps_out = 2'b00;
			il_out = '0;
			rw_out = '0;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '0;
			end
			default: begin	
			ns = HLT;
			ps_out = 2'b00;
			il_out = '0;
			rw_out = '0;
			rs_out =  {'0, ins_in[8:6], '0, ins_in[5:3], '0, ins_in[2:0] };
			mx_out = 4'b0000;
			fs_out = FMOVA;
			wen_out = '1;
			iom_out = '0;
			end
		endcase

	end
endcase	
end : fsm_logic       
     
endmodule
   

   


