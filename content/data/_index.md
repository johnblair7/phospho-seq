---
title: Data
type: landing

view: 3
columns: '2'

---

All data is available in preprocessed Seurat Objects from [Zenodo](https://zenodo.org/record/7754315). Below are plots from these processed datasets emphasizing ADT expression for each ADT as well as ATAC coverage, RNA expression, and chromVAR scores if applicable.

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
        <li><a href="sox2/">SOX2</a></li>
        <li><a href="gli3/">GLI3</a> </li>
        <li><a href="tbr1/">TBR1</a> </li>
        <li><a href="OTX2/">OTX2</a> </li>
        <li><a href="PAX6/">PAX6</a> </li>
        <li><a href="NEUROD1/">NEUROD1</a> </li>
        <li><a href="NFIB/">NFIB</a> </li>
        <li><a href="FOXG1/">FOXG1</a> </li>
        <li><a href="AIPL1/">AIPL1</a> </li>
        <li><a href="AMPK/">AMPK</a> </li>
        <li><a href="Bactin/">BACTIN</a> </li>
        <li><a href="Bassoon/">BASSOON</a> </li>
    </ul>
    </div>
</body> 
</html> 
