---
title: Frequently Asked Questions
type: landing

---

### How many antibodies can you include in a single Phospho-seq experiment?
<font size= “3”> Because all of the antibodies are individually conjugated with complex 15 nt indices as part of the larger DNA-oligo, in theory you can use a near unlimited number of antibodies. I have used up to 100 antibodies in a single experiment with no problems in detection.

### How do you choose which antibodies are compatible with Phospho-seq?

<font size= “3”> The primary criteria I use for selecting antibodies for use in Phospho-seq is whether they work in a) Intracellular Flow Cytometry (ICFC) or b) Immunocytochemistry (ICC). Both of these methods use fixed, permeabilized cells as in Phospho-seq, with ICFC being slighter more similar due to the necessary dissociation in both protocols. As with any other antibody based assay, Phospho-seq is affected by antibody sensitivity and/or background staining. Not all antibodies will work well with Phospho-seq, even those used in ICFC or ICC due to differences in fixation or permeabilization between individual protocols.

### Is there a repository about which antibodies work well with Phospho-seq?

<font size= “3”>	On this website, under the data tab, users can look at data from multiple experiments with different antibodies. I hope that these plots can indicate the utility of all antibodies I have used. 

### Are the conjugated antibodies compatible with other single-cell intracellular quantification assays?

<font size= “3”>	Yes! Although I primarily use TSB tags (10X feature barcodes) for my antibodies due to potential RBP binding of TSA tags (Poly A), you can use the same conjugation reaction to add a TSA tag and then capture with any poly-A compatible technology like InCite-seq or NEAT-seq or by using Bridge Oligo A, you can capture with Phospho-seq as well.

### Is Phospho-seq compatible with 10X Multiome (scATAC + scRNA) kits? 

<font size= “3”>	Yes it is, although when using TSB tags, the capture efficiency is lower because the ATAC modality is already being captured by a bridge oligo (the splint probe <a href="https://teichlab.github.io/scg_lib_structs/methods_html/10xChromium_multiome.html" target="_blank"> (10x Multiome Structure) </a>), so therefore you are using two bridges. If using TSA tags, you can directly capture like in NEAT-seq. It should be noted that running the multiome on fixed tissue results in significantly lower RNA data quality and we highly recommend using <a href="https://www.nature.com/articles/s41587-023-01767-y" target="_blank">Bridge Integration (Hao et al., 2023) </a> as an alternative if you have appropriate bridge and reference datasets available.  

### How long will the reagents included with the Phospho-seq kit last if stored properly?

<font size= “3”> In my experience the reagents are good for quite some time - I have tested conjugated antibodies stored at 4C and observed that they are still conjugated and functional after at least a year. The other reagents should be stable for at least that long. The one reagent that may be more limited in stability (closer to 6 months) is the TCO-labeled oligos. However, their instability manifests as the oligo losing its TCO-label very gradually. This means that where you may have added 15 pmol oligo per ug of antibody before, you may want to add 20 pmol if doing it 6 months later and 30 pmol if doing it a year later.

