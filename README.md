# DT2-MyCPU-kurssiprojekti (SystermVerilog)
Tämä projekti sisältää osan kurssiprojektista, jossa suunniteltiin 16-bittinen prosessoriydin SystemVerilogilla.
Repository sisältää eri moduulien suunnittelutiedostot, jotka muodostavat yksinkertaisen CPU-arkkitehtuurin.
---
# Moduulit
● PC (pc), ohjelmalaskuri
● IR (ir), käskyrekisteri
 ● CU (cu), ohjausyksikkö, joka sisältää ohjaustilakoneen ja käskydekooderin
● RB (rb), 16 x 16-bittinen rekisteripankki, jonka rekisterit R0 - R7 ovat käyttäjärekistereitä ja
    rekisterit HR0 - HR7 piilorekistereitä, joita ei voida käyttää käskyjen operandeina.
 ● FU (fu), funktioyksikkö, joka toteuttaa erilaisia aritmeettisia ja loogisia toimintoja
    kombinaatiologiikalla
● MUXM (muxm), multipleksaaja, jolla valitaan ohjelmalaskuri tai väylä abus muistin
    osoiteväylän lähteeksi
● MUXD (muxd), multipleksaaja, jolla valitaan funktioyksikön lähtö us, muistin lukudatatulo
    d_in tai oheislaitteen lukuväylä io_in rekisteripankin kirjoitusdatatuloksi
● MUXB (muxb), multipleksaaja, jolla valitaan joko rekisteripankin bdat lähtösignaali tai
    käskyrekisterin lähtösignaali ins väylän bbus lähteeksi. Käskyrekisterin biteistä erotetaan
    multipleksaajan sisällä 3-bittinen välitön arvo, joka täytetään nollilla 16-bittiseksi.'¨
---
### Huomio
Tämä repository sisältää vain moduulien suunnittelutiedostot kurssiprojektista. Kurssin muut tiedostot ja testausympäristöt eivät sisälly tähän.
---
