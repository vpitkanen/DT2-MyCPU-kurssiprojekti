`include "mycpu.svh"

import mycpu_pkg::*;

module rb
  (
   input logic 	       clk,
   input logic 	       rst_n,
   input logic [15:0]  d_in,
   input logic 	       rw_in,
   input logic [11:0]   rs_in,
   output logic [15:0] a_out,
   output logic [15:0] b_out
   );

// Määritellään kaksi rekisteripankkia
   
logic [7:0][15:0] rb_r; // Käyttäjärekisteripankki, 8 x 16 bittiä
logic [7:0][15:0] hb_r; // Piilorekisteripankki, 8 x 16 bittiä

	  
// Kirjoituslogiikka ja asynkroninen resetti
always_ff @(posedge clk or negedge rst_n) 
begin : writer
    
    if (rst_n == 0) begin
        // Nollataan kaikki rekisterit
        for (int i = 0; i < 8; i++) begin
            rb_r[i] <= 16'b0;
            hb_r[i] <= 16'b0;
        end
    end
    // Kirjoituslogiikka positiivisella kelloreunalla
    else if (rw_in) begin
        // Jos rs_in[11:8] on 0000 - 0111, kirjoitetaan rb_r:ään
        if (rs_in[11:8] <= 4'b0111) begin
            rb_r[rs_in[11:8]] <= d_in;
        end

        // Jos rs_in[11:8] on 1000 - 1111, kirjoitetaan hb_r:ään
        else if (rs_in[11:8] >= 4'b1000) begin
            hb_r[rs_in[11:8] - 4'b1000] <= d_in;
        end
    end
end : writer

// Lukulogiikka (multipleksaajat a_out ja b_out varten)
always_comb begin
    // Valitaan a_out: rs_in[7:4] perusteella
    if (rs_in[7:4] <= 4'b0111) begin
        a_out = rb_r[rs_in[7:4]];  // Käyttäjärekisteripankki
    end else begin
        a_out = hb_r[rs_in[7:4] - 4'b1000];  // Piilorekisteripankki
    end
    
    // Valitaan b_out: rs_in[3:0] perusteella
    if (rs_in[3:0] <= 4'b0111) begin
        b_out = rb_r[rs_in[3:0]];  // Käyttäjärekisteripankki
    end else begin
        b_out = hb_r[rs_in[3:0] - 4'b1000];  // Piilorekisteripankki
    end
end



   
endmodule

