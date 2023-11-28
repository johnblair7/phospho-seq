---
title: Data
type: landing

view: 3
columns: '2'

---

All data is available in preprocessed Seurat Objects from [Zenodo](https://zenodo.org/records/10120360). Below are plots from these processed datasets emphasizing ADT expression for each ADT as well as ATAC coverage, RNA expression, and chromVAR scores if applicable.

<!DOCTYPE html>
<html> 
<head> 
<style> 
/* Dropdown Button */ 
.dropdown-button { 
    background-color: #0000b3; 
    color: white;
    padding: 16px; 
    font-size: 16px; 
    border: none; 
} 
.dropdown { 
    position: relative; 
    display: inline-block; 
} 
/* Dropdown Content (Hidden by Default) */ 
.dropdown-list { 
    display: none; 
    position: relative; 
    background-color: #f1f1f1; 
    min-width: 160px; 
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); 
    max-height: 150px;  
    overflow-y: auto;
    z-index: 1000; 
} 
/* Links inside the dropdown */ 
.dropdown-list a { 
    color: black; 
    padding: 12px 16px; 
    text-decoration: none; 
    display: block; 
    font-family: verdana; 
    z-index: 1000;
} 
/* Change color of dropdown links on hover */ 
.dropdown-list a:hover { 
    background-color: #ddd; 
} 
/* Show the dropdown list on hover */ 
.dropdown:hover .dropdown-list { 
    display: block; 
} 
/* Change the background color of the dropdown button when the dropdown list is shown */ 
.dropdown:hover .dropdown-button { 
    background-color: #6666ff; 
} 
/* Change the background color of the dropdown button when the dropdown list is shown */ 
ul { 
    list-style-type: none; 
    list-style-position: inside;
    margin-left: 0;
    padding-left: 0;
} 
</style> 
</head> 
<body> 
    <div class="dropdown">
    <button class="dropdown-button" type="button" data-toggle="dropdown">Choose an Antibody
    <span class="caret"></span></button>
    <ul class="dropdown-list">
        <li><a href="AIPL1/">AIPL1</a> </li>
        <li><a href="AMPK/">AMPK</a> </li>
        <li><a href="Bactin/">Bactin</a> </li>
        <li><a href="Bassoon/">Bassoon</a> </li>
        <li><a href="BCatenin/">BCatenin</a> </li>
        <li><a href="BRN3A/">BRN3A</a> </li>
        <li><a href="CCNE1/">CCNE1</a> </li>
        <li><a href="CHX10/">CHX10</a> </li>
        <li><a href="CLUAP1/">CLUAP1</a> </li>
        <li><a href="COL2A1/">COL2A1</a> </li>
        <li><a href="CRALBP/">CRALBP</a> </li>
        <li><a href="DCX/">DCX</a> </li>
        <li><a href="DDX6/">DDX6</a></li>
        <li><a href="DYN1/">DYN1</a> </li>
        <li><a href="EPHB2/">EPHB2</a> </li>
        <li><a href="ERK1/">ERK1</a> </li>
        <li><a href="FOS/">FOS</a> </li>
        <li><a href="FoxG1/">FOXG1</a> </li>
        <li><a href="FOXO1/">FOXO1</a> </li>
        <li><a href="GAPDH/">GAPDH</a> </li>
        <li><a href="GATA1/">GATA1</a> </li>
        <li><a href="Gephyrin/">Gephyrin</a> </li>
        <li><a href="gli3/">GLI3</a> </li>
        <li><a href="GLUR2/">GLUR2</a> </li>
        <li><a href="GluR4/">GLUR4</a> </li>
        <li><a href="GSK3B/">GSK3B</a> </li>
        <li><a href="GTubulin/">GTubulin</a> </li>
        <li><a href="HOPX/">HOPX</a> </li>
        <li><a href="HSP60/">HSP60</a> </li>
        <li><a href="IMPDH1/">IMPDH1</a> </li>
        <li><a href="IRF1/">IRF1</a> </li>
        <li><a href="JAK1/">JAK1</a> </li>
        <li><a href="JNK1/">JNK1</a> </li>
        <li><a href="KCNJ10/">KCNJ10</a> </li>
        <li><a href="MAPK/">MAPK</a> </li>
        <li><a href="MEIS2/">MEIS2</a> </li>
        <li><a href="MEK/">MEK</a></li>
        <li><a href="Na_K_ATPase/">NA+K+ATPase</a> </li>
        <li><a href="NCadherin/">NCadherin</a> </li>
        <li><a href="NeuN/">NeuN</a> </li>
        <li><a href="NEUROD1/">NEUROD1</a> </li>
        <li><a href="NFIB/">NFIB</a> </li>
        <li><a href="NRL/">NRL</a> </li>
        <li><a href="OCT4/">OCT4</a> </li>
        <li><a href="ONECUT2/">ONECUT2</a> </li>
        <li><a href="OTX2/">OTX2</a> </li>
        <li><a href="p65_nFKb/">p65_nFKb</a> </li>
        <li><a href="pAMPK/">pAMPK</a> </li>
        <li><a href="Pax6/">Pax6</a> </li>
        <li><a href="pBCatenin/">pBCatenin</a> </li>
        <li><a href="PCNA/">PCNA</a> </li>
        <li><a href="pERK/">pERK</a> </li>
        <li><a href="pFOXO1/">pFOXO1</a> </li>
        <li><a href="pGSK3B/">pGSK3B</a> </li>
        <li><a href="PI3K/">PI3K</a> </li>
        <li><a href="pJAK1/">pJAK1</a> </li>
        <li><a href="pJNK1/">pJNK1</a> </li>
        <li><a href="PKCa/">PKCa</a> </li>
        <li><a href="PKCb1/">PKCb1</a> </li>
        <li><a href="PLCy/">PLCy</a> </li>
        <li><a href="pMAPK/">pMAPK</a> </li>
        <li><a href="pMEK/">pMEK</a> </li>
        <li><a href="pPI3K/">pPI3K</a> </li>
        <li><a href="pPKCa/">pPKCa</a> </li>
        <li><a href="pPKCb/">pPKCb</a> </li>
        <li><a href="pPLCy/">pPLCy</a> </li>
        <li><a href="pRPS6/">pRPS6</a> </li>
        <li><a href="pSMAD1/">pSMAD1</a> </li>
        <li><a href="pSMAD2/">pSMAD2</a> </li>
        <li><a href="pSTAT1/">pSTAT1</a> </li>
        <li><a href="pSTAT3/">pSTAT3</a> </li>
        <li><a href="pTSC2/">pTSC2</a> </li>
        <li><a href="pVIM/">pVIM</a> </li>
        <li><a href="Recoverin/">Recoverin</a> </li>
        <li><a href="RHO/">RHO</a> </li>
        <li><a href="Ribeye/">Ribeye</a> </li>
        <li><a href="RPS6/">RPS6</a> </li>
        <li><a href="S100B/">S100B</a> </li>
        <li><a href="SMAD2/">SMAD2</a> </li>
        <li><a href="SMAD5/">SMAD5</a> </li>
        <li><a href="sox2/">SOX2</a></li>
        <li><a href="SOX9/">SOX9</a> </li>
        <li><a href="STAT1/">STAT1</a> </li>
        <li><a href="STAT3/">STAT3</a> </li>
        <li><a href="SV2/">SV2</a> </li>
        <li><a href="TBR1/">TBR1</a> </li>
        <li><a href="TBR2/">TBR2</a> </li>
        <li><a href="TSC2/">TSC2</a> </li>
        <li><a href="ULK1/">ULK1</a> </li>
        <li><a href="VGLUT1/">VGLUT1</a> </li>
        <li><a href="Vim/">Vim</a> </li>
        <li><a href="YAPTAZ/">YAP1</a> </li>
    </ul>
    </div>
</body> 
</html> 
