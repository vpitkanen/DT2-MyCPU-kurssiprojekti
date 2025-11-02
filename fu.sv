`include "mycpu.svh"

import mycpu_pkg::*;

module fu
  (
   input logic [15:0]  a_in,
   input logic [15:0]  b_in, 
   input 	       fs_t fs_in, 
   output logic [15:0] f_out,
   output logic [1:0]  nz_out
   );
   
logic signed [15:0] alu;	    
logic signed [15:0] mul;	    
logic signed [15:0] usr;	      
logic signed [31:0] m;
logic signed [15:0] s;
logic signed [15:0] ma;
logic signed [15:0] mb;



//Valitaan fs_in mukaan mikä funktio suoritetaan.
//FMUL ja FUSR on 0 koska ne suoritetaan erillisessä blokissa.      
always_comb
begin : alu_logic
	case (fs_in)
	FMOVA : alu = a_in;
	FINC : alu = a_in + 1;
	FADD : alu = a_in + b_in;
        FMUL : alu = '0;
        FSRA : alu = $signed(a_in) >>> (b_in[2:0]+1);
	FSUB : alu = a_in - b_in;
	FDEC : alu = a_in - 1;
	FSLA : alu = $signed(a_in) <<< (b_in[2:0]+1);
	FAND : alu = a_in & b_in;
	FOR  : alu = a_in | b_in;
	FXOR : alu = a_in ^ b_in;
	FNOT : alu = ~a_in;
	FMOVB: alu = b_in;
	FSHR : alu = b_in >> 1;
	FSHL : alu = b_in << 1;
	FUSR : alu = '0;
	endcase
end : alu_logic

//Suoritetaan kertolasku erillisiessä blokissa
//Jos fs_in on FMUL, muuttujat ma ja mb asetetaan etumerkillisiksi a_in ja b_in arvoiksi, muuten ne asetetaan nolliksi. Ma ja mb kerrotaan keskenään etumerkillisinä ja jos tulos on isompi kuin etumerkillisen 16 bittisen maksimi arvo, asetetaan m muuttujaan tulokseksi maksimi arvo. Jos tulos on pienempi kuin 16 bittisien minimi arvo, asetetaan minimi arvo. Muussa tapauksessa s = m.
always_comb

begin : mul_logic
	
	if (fs_in == FMUL)
	begin
	ma = $signed(a_in);
	mb = $signed(b_in);
	end	

	else
	begin
	ma = '0;
	mb = '0;
	end

	m = $signed(ma) * $signed(mb);

	if (m > 16'sb01111111_11111111)
	  s= 16'b01111111_11111111;
	else if (m < 16'sb10000000_00000000)
	  s= 16'b10000000_00000000;
	else
	  s= 16'(m);

        mul = $unsigned(s);
        

end : mul_logic

//Suoritetaan user_logic jos fs_in valinta on FUSR
always_comb
   begin : user_logic

parameter logic [9:0] PI_FIXED = 10'b11_00100100;  // määritys π:lle
logic [15:0] doubled_radius;
logic [25:0] pi_result;

// Alustetaan oletusarvoihin, jotta vältetään latchien syntyminen
    doubled_radius = 16'b0;
    pi_result = 26'b0;
    

     if (fs_in == FUSR)
       begin
	 // Vaihe 1: Kerrotaan säde kahdella
         doubled_radius = a_in << 1; // 2 * säde

	 // Vaihe 2: Kerrotaan tulos π:llä
         pi_result = doubled_radius * PI_FIXED;  // Laskenta: 2 * säde * π

	 // Vaihe 3: Pyöristetään tulos alaspäin kokonaisluvuksi ja tallennetaan `usr`
         usr = pi_result[25:10]; // Pyöristä alaspäin ottamalla kokonaisosa
	  end
	else
	  usr = '0;
end : user_logic

//Tässä blokissa valitaan ulostulon arvo. Sekä määritetään lipputulo, joka riippuu f_outin arvosta.
// (alu | mul | usr) operaatio valitsee näistä arvon f_out:iin.
always_comb
begin : output_logic

	f_out = (alu | mul | usr);

	if (f_out == '0)
	nz_out[0] = '1;
	else
	nz_out[0] = '0;
	

	if (f_out[15] == 1)
	
	nz_out[1] = 1;
	else
	nz_out[1] = 0;
	
end : output_logic 
	


endmodule
