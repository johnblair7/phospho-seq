---
title: "ProbeMaker Tool"
subtitle: "Generate mRNA Complementary Probes"
summary: "A web-based tool for designing DNA probes complementary to mRNA sequences"
date: 2024-01-01
draft: false
---

## Generate Probes for Your Genes

Use the tool below to generate complementary DNA sequences to mRNA. Simply enter your gene names (one per line) and click generate!

<iframe 
    src="/files/probe_maker_standalone.html" 
    width="100%" 
    height="800px" 
    frameborder="0"
    allowfullscreen
    style="border: 1px solid #ddd; border-radius: 8px; min-height: 800px;">
</iframe>

## How to Use

1. **Enter Gene Names**: Type or paste gene names, one per line
2. **Click Generate**: The tool will fetch sequences from NCBI
3. **Download Results**: Get your probe sequences as a text file

## Example Gene Names

BRCA1
TP53
EGFR
KRAS
BRAF

---

*Note: This tool automatically handles NCBI rate limiting and generates non-overlapping probe pairs.*
