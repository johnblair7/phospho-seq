---
title: Data
type: landing

sections:
  - block: markdown
    id: protcol_2
    content:
      title: Section 1
      subtitle: A subtitle
---
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
    position: absolute; 
    background-color: #f1f1f1; 
    min-width: 160px; 
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); 
    z-index: 1; 
} 
/* Links inside the dropdown */ 
.dropdown-list a { 
    color: black; 
    padding: 12px 16px; 
    text-decoration: none; 
    display: block; 
    font-family: verdana; 
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
</style> 
</head> 
<body> 
	<div class="dropdown"> 
		<button class="dropdown-button">Dropdown</button> 
		<div class="dropdown-list"> 
			<a href="protcol_2/">SOX2</a> 
			<a href="#">This is Link 2</a> 
			<a href="#">This is Link 3</a> 
		</div> 
	</div> 
</body> 
</html> 

All data is available in preprocessed Seurat Objects from [Zenodo](https://zenodo.org/record/7754315).

Below are plots from these processed datasets emphasizing ADT expression for each ADT as well as ATAC coverage, RNA expression, and chromVAR scores if applicable.
