# DT2-MyCPU-kurssiprojekti (SystermVerilog)
Tämä projekti sisältää osan kurssiprojektista, jossa suunniteltiin 16-bittinen prosessoriydin SystemVerilogilla.
Repository sisältää eri moduulien suunnittelutiedostot, jotka muodostavat yksinkertaisen CPU-arkkitehtuurin.
---
### Moduulit
- **`pc.sv`** – ohjelmalaskuri, hallitsee seuraavan käskyn osoitteen  
- **`ir.sv`** – käskyrekisteri, säilyttää parhaillaan suoritettavan käskyn  
- **`cu.sv`** – ohjausyksikkö, sisältää ohjaustilakoneen ja käskydekooderin  
- **`rb.sv`** – rekisteripankki (16×16 bittiä)  
- **`fu.sv`** – funktioyksikkö, suorittaa aritmeettiset ja loogiset toiminnot  
- **`muxm.sv`** – multiplekseri, valitsee ohjelmalaskurin tai väylän muistiosoitteen lähteeksi  
- **`muxd.sv`** – multiplekseri, valitsee kirjoitusdatan lähteen  
- **`muxb.sv`** – multiplekseri, valitsee väylän `bbus` lähteen
- **`mycpu.sv`** – Ei sisällä toiminnallista koodia, vaan yhdistää moduulit kokonaisuudeksi
---
### Huomio
Tämä repository sisältää vain moduulien suunnittelutiedostot kurssiprojektista. Kurssin muut tiedostot ja testausympäristöt eivät sisälly tähän.
---
