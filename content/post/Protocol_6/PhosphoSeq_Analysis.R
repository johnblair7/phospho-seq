#Load all the packages necessary 
library(Signac)
library(Seurat)
library(GenomeInfoDb)
library(EnsDb.Hsapiens.v86)
library(BSgenome.Hsapiens.UCSC.hg38)
library(ggplot2)
library(patchwork)
library(dplyr)
library(fishpond)
library(tximport)
library(devtools)
library(stringi)
library(cowplot)
library(JASPAR2022)
library(TFBSTools)
library(RColorBrewer)
library(motifmatchr)
library(chromVAR)
library(Matrix)
library(tidyr)
library(tibble)
library(biovizBase)
set.seed(1234)

#Create a function for importing the Alevin Data
load_fry <- function(frydir, which_counts = c('S', 'A'), verbose = FALSE) {
  suppressPackageStartupMessages({
    library(rjson)
    library(Matrix)
    library(SingleCellExperiment)
  })
  
  # read in metadata
  qfile <- file.path(frydir, "quant.json")
  if (!file.exists(qfile)) {
    qfile <- file.path(frydir, "meta_info.json")
  }
  meta_info <- fromJSON(file = qfile)
  ng <- meta_info$num_genes
  usa_mode <- meta_info$usa_mode
  
  if (usa_mode) {
    if (length(which_counts) == 0) {
      stop("Please at least provide one status in 'U' 'S' 'A' ")
    }
    if (verbose) {
      message("processing input in USA mode, will return ", paste(which_counts, collapse = '+'))
    }
  } else if (verbose) {
    message("processing input in standard mode, will return spliced count")
  }
  
  # read in count matrix
  af_raw <- readMM(file = file.path(frydir, "alevin", "quants_mat.mtx"))
  # if usa mode, each gene gets 3 rows, so the actual number of genes is ng/3
  if (usa_mode) {
    if (ng %% 3 != 0) {
      stop("The number of quantified targets is not a multiple of 3")
    }
    ng <- as.integer(ng/3)
  }
  
  # read in gene name file and cell barcode file
  afg <- read.csv(file.path(frydir, "alevin", "quants_mat_cols.txt"), 
                  strip.white = TRUE, header = FALSE, nrows = ng, 
                  col.names = c("gene_ids"), row.names = 1)
  afc <- read.csv(file.path(frydir, "alevin", "quants_mat_rows.txt"), 
                  strip.white = TRUE, header = FALSE,
                  col.names = c("barcodes"), row.names = 1)
  
  # if in usa_mode, sum up counts in different status according to which_counts
  if (usa_mode) {
    rd <- list("S" = seq(1, ng), "U" =  seq(ng + 1, 2 * ng),
               "A" =  seq(2 * ng + 1, 3 * ng))
    o <- af_raw[, rd[[which_counts[1]]], drop = FALSE]
    for (wc in which_counts[-1]) {
      o <- o + af_raw[, rd[[wc]], drop = FALSE]
    }
  } else {
    o <- af_raw
  }
  
  # create SingleCellExperiment object
  sce <- SingleCellExperiment(list(counts = t(o)),
                              colData = afc,
                              rowData = afg
  )
  sce
}

#Reading in the 10X data as exported by CellRanger
counts <- Read10X_h5(filename = "filtered_peak_bc_matrix.h5")
metadata <- read.csv(
  file = "singlecell.csv",
  header = TRUE,
  row.names = 1
)

grange.counts <- StringToGRanges(rownames(counts), sep = c(":", "-"))
grange.use <- seqnames(grange.counts) %in% standardChromosomes(grange.counts)
counts <- counts[as.vector(grange.use), ]
annotations <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v86)
seqlevelsStyle(annotations) <- 'UCSC'
genome(annotations) <- "hg38"

frag.file <- "fragments.tsv.gz"
chrom_assay <- CreateChromatinAssay(
  counts = counts,
  sep = c(":", "-"),
  genome = 'hg38',
  fragments = frag.file,
  min.cells = 10,
  annotation = annotations
)

obj <- CreateSeuratObject(
  counts = chrom_assay,
  assay = "ATAC",
  meta.data = metadata
)

DefaultAssay(obj) <- "ATAC"

#Save the object in its unfiltered form so you don't have to load and process things again
saveRDS(obj,"obj_nofilter.RDS")


#I always recall the peaks using MACS rather than using the 10X called peaks, but this options
peaks <- CallPeaks(
  object = obj,
  macs2.path = "/path/to/MACS/program/macs3"
)

peaks <- keepStandardChromosomes(peaks, pruning.mode = "coarse")

fpath <- "fragments.tsv.gz"
fragments <- CreateFragmentObject(
  path = fpath,
  cells = colnames(counts),
  validate.fragments = TRUE,
  verbose = TRUE,
)

MACS <- FeatureMatrix(
  fragments = fragments,
  features = peaks,
  cells = colnames(counts)
)

chrom_assay <- CreateChromatinAssay(
  counts = MACS[, colnames(obj@assays$ATAC@counts)],
  sep = c(":", "-"),
  genome = 'hg38',
  fragments = 'fragments.tsv.gz',
  min.cells = 0,
  min.features = 0
)

obj[["MACS"]] <- chrom_assay

DefaultAssay(obj) <- "MACS" 
annotations <- GetGRangesFromEnsDb(ensdb = EnsDb.Hsapiens.v86)

seqlevelsStyle(annotations) <- 'UCSC'
genome(annotations) <- "hg38"
Annotation(obj) <- annotations

#Dimensionality Reduction
obj <- RunTFIDF(obj)
obj <- FindTopFeatures(obj, min.cutoff = 'q0')
obj <- RunSVD(obj)

obj <- RunUMAP(object = obj, reduction = 'lsi', dims = 2:30)
obj <- FindNeighbors(object = obj, reduction = 'lsi', dims = 2:30)
obj <- FindClusters(object = obj, verbose = FALSE, algorithm = 3)

DimPlot(obj, reduction = "umap", label = T)
DimPlot(obj, reduction = "umap", label = T,group.by = "donor_id")

#Calculating Gene Activity Scores
gene.activities <- GeneActivity(obj)
obj[['GeneAct']] <- CreateAssayObject(counts = gene.activities)
obj <- NormalizeData(
  object = obj,
  assay = 'GeneAct',
  normalization.method = 'LogNormalize',
  scale.factor = median(obj$nCount_RNA)
)   
obj <- ScaleData(obj,assay = "RNA")

#Save the object with the MACS assay_prefiltering
saveRDS(obj,"objMACS_nofilt.RDS")

#Read in the ADT and HTO and if using it, the permeabilization scoring data from including TSA oligos during the blocking step
adt.txi <- load_fry('adt_quant/crlike', verbose=TRUE)
hto.txi <- load_fry('hto_quant/crlike', verbose=TRUE)
multi.txi <- load_fry('ms_quant/crlike', verbose=TRUE)

colnames(adt.txi) <- stri_reverse(chartr("acgtACGT", "tgcaTGCA", colnames(adt.txi)))
colnames(adt.txi) <- paste0(colnames(adt.txi), "-1")

colnames(hto.txi) <- stri_reverse(chartr("acgtACGT", "tgcaTGCA", colnames(hto.txi)))
colnames(hto.txi) <- paste0(colnames(hto.txi), "-1")

colnames(multi.txi) <- stri_reverse(chartr("acgtACGT", "tgcaTGCA", colnames(multi.txi)))
colnames(multi.txi) <- paste0(colnames(multi.txi), "-1")

common.cells <- intersect(colnames(adt.txi), colnames(hto.txi))
common.cells <- intersect(common.cells , colnames(multi.txi) )
common.cells <- intersect(common.cells , colnames(obj@assays$MACS))

obj <- subset(obj, cells = common.cells)

obj[["ADT"]] <- CreateAssayObject(counts = counts(adt.txi)[, which(colnames(adt.txi) %in% common.cells)])
obj[["HTO"]] <- CreateAssayObject(counts = counts(hto.txi)[, which(colnames(hto.txi) %in% common.cells)])
obj[["MS"]] <- CreateAssayObject(counts = counts(multi.txi)[, which(colnames(multi.txi) %in% common.cells)])

#get rid of the original ATAC assay because it just takes up space - now due to needing common cells between each assay, the data might be filtered a bit
obj@assays$ATAC <- NULL
saveRDS(obj,"objMACS.RDS")

#Look at the hashing data and determine doublets and donor identities
DefaultAssay(obj) <- "HTO"
obj <- NormalizeData(obj,   normalization.method = "CLR", margin = 2, verbose = F)
VariableFeatures(obj) <- rownames(obj[["HTO"]]@counts)
obj <- ScaleData(obj, assay = "HTO", verbose = F)
obj <- HTODemux(obj, assay = "HTO", positive.quantile = 0.99, verbose = F,nsamples = 1000)

#subset out doublets
obj <- subset(obj, idents = "Doublet",invert =T)

obj <- RunPCA(obj, reduction.name = "hto.pca", reduction.key = "HPC_", verbose = F)
obj <- RunUMAP(obj, reduction = "hto.pca", dims = 1:2, reduction.name = "hto.umap", reduction.key = "HUMAP_", verbose = F)
obj <- FindNeighbors(object = obj, reduction = 'hto.pca', dims = 1:2)
obj <- FindClusters(object = obj, verbose = FALSE, algorithm = 3)

#Usually I look at the dimensional reduction of the HTO dataset before filtering out any negatives, often those are just cells with low hashing reads
#due to low hashing antibody concentration - the dimensionality reduction is more clear than HTOdemux for this and you can avoid unnecessary filtering
DimPlot(obj)

obj <- subset(obj, nCount_ADT < 10000)

DefaultAssay(obj) <- "MS"
obj <- NormalizeData(obj,   normalization.method = "CLR", margin = 2, verbose = F)

# ADT Normalization

#subset cells that are clear outliers for ADT counts and then normalize the ADT data, first by CLR and then by SCT regressed against the TSA blocking oligo quantification
obj <- subset(obj, nCount_ADT < 10000)
DefaultAssay(obj) <- "ADT"
obj <- NormalizeData(obj, normalization.method = "CLR", margin = 2, verbose = F)
VariableFeatures(obj) <- rownames(obj[["ADT"]]@counts)
obj <- ScaleData(obj, assay = "ADT", verbose = F, do.scale = F)

DefaultAssay(obj) <- 'ADT'
obj <- SCTransform(obj,assay = "ADT",vars.to.regress = "nCount_MS",vst.flavor="v2")
obj <- RunPCA(f3,reduction.name = "sctapca", reduction.key = "sctapca_", verbose = F)
obj <- RunUMAP(f3, reduction.name = "sctaumap", reduction.key = "sctaumap_", dims = 1:20, reduction = "apca", verbose = F)

# Perform PCA
obj <- RunPCA(obj, reduction.name = "apca", reduction.key = "apca_", verbose = F)

# generate UMAP
obj <- RunUMAP(obj, reduction.name = "aumap", reduction.key = "aumap_", dims = 1:20, reduction = "apca", verbose = F)

#look at the ADT expression for both counts and CLR normalized data to get an idea of which ADTs worked well
ADT_list <- rownames(obj@assays$ADT@counts)

VlnPlot(obj,ADT_list,pt.size = 0,ncol=10,slot = "counts")
VlnPlot(obj,ADT_list,pt.size = 0,ncol=10)

#rerun the dimensionality reduction post all the filtering
DefaultAssay(obj) <- "MACS"
obj <- RunTFIDF(obj)
obj <- FindTopFeatures(obj, min.cutoff = 'q0')
obj <- RunSVD(obj)

obj <- RunUMAP(object = obj, reduction = 'lsi', dims = 2:30)
obj <- FindNeighbors(object = obj, reduction = 'lsi', dims = 2:30)
obj <- FindClusters(object = obj, verbose = FALSE, algorithm = 3)

DefaultAssay(obj) <- "MACS"   

CoveragePlot(
  object = obj,
  region = "Gene",
  extend.upstream = 5000,
  extend.downstream = 5000,
  peaks = T
)

#Run ChromVAR to add in motif accessibility
DefaultAssay(obj) <- "MACS"
pwm_set <- getMatrixSet(x = JASPAR2022, opts = list(species = 9606, all_versions = FALSE))
motif.matrix <- CreateMotifMatrix(features = granges(obj), pwm = pwm_set, genome = 'hg38', use.counts = FALSE)
motif.object <- CreateMotifObject(data = motif.matrix, pwm = pwm_set)
obj <- SetAssayData(obj, assay = 'MACS', slot = 'motifs', new.data = motif.object)

# Note that this step can take 5-10 minutes 
obj <- RunChromVAR(
  object = obj,
  genome = BSgenome.Hsapiens.UCSC.hg38
)

saveRDS(obj,"objMACS_filt.rds")

####### Bridge Integration

library(Seurat)
options(Seurat.object.assay.version = "v5")
remotes::install_github("stuart-lab/signac", "seurat5")
library(Signac)
library(EnsDb.Hsapiens.v86)
library(dplyr)
library(ggplot2)

options(future.globals.maxSize = 50 * 1024^3) # for 50 Gb RAM

obj.rna <- readRDS("path/to/obj_rna.rds")
obj.atac <- obj
obj.multi <- rreadRDS("path/to/obj_multiome.rds")

DefaultAssay(obj.atac) <- "MACS"
DefaultAssay(obj.multi) <- "MACS"

# count fragments per cell overlapping the set of peaks in the 10x data
multi.peaks <- FeatureMatrix(
  fragments = Fragments(obj.atac),
  features = StringToGRanges(row.names(obj.multi)),
  cells = colnames(obj.atac)
)

# create a new assay and add it to the 10x dataset
obj.atac[['multi.peaks']] <- CreateChromatinAssay(
  counts = multi.peaks,
  min.cells = 1,
  ranges = StringToGRanges(row.names(obj.multi)),
  genome = 'hg38'
)

DefaultAssay(obj.atac) <-  "multi.peaks"
obj.atac <- FindTopFeatures(obj.atac, min.cutoff = 'q0')
obj.atac <- RunTFIDF(obj.atac)
obj.atac <- RunSVD(obj.atac,reduction.key="lsi_",reduction.name="lsi")
obj.atac <- RunUMAP(obj.atac, reduction = "lsi", dims = 2:50,reduction.name = "umap.atac")


# normalize multiome RNA
obj.rna <- NormalizeData(obj.rna,assay = "RNA")
DefaultAssay(obj.multi) <- "RNA"
obj.multi <- SCTransform(obj.multi, verbose = FALSE)
# normalize multiome ATAC
DefaultAssay(obj.multi) <- "MACS"
obj.multi <- RunTFIDF(obj.multi)
obj.multi <- FindTopFeatures(obj.multi, min.cutoff = "q0")
# normalize query
DefaultAssay(obj.atac) <- "multi.peaks"
obj.atac <- RunTFIDF(obj.atac)

obj.rna = SCTransform(object = obj.rna) %>%
  RunPCA() %>%
  RunUMAP(dims = 1:50, return.model = TRUE)

# Drop first dimension for ATAC reduction
dims.atac <- 2:50
dims.rna <- 1:50
DefaultAssay(obj.multi) <-  "RNA"
DefaultAssay(obj.rna) <- "SCT"

obj.rna.ext <- PrepareBridgeReference(
  reference = obj.rna, bridge = obj.multi,
  reference.reduction = "pca", reference.dims = dims.rna,
  bridge.query.assay = "MACS",
  normalization.method = "SCT")

bridge.anchor <- FindBridgeTransferAnchors(
  extended.reference = obj.rna.ext, query = obj.atac,
  reduction = "lsiproject", dims = dims.atac)

obj.atac <- MapQuery(anchorset = bridge.anchor,
                     reference = obj.rna.ext,
                     query = obj.atac,
                     refdata = list(L1 = "celltype",impRNA = "RNA"),
                     reduction.model = "umap")

saveRDS(obj.atac,"obj_bridged.rds")

obj <- obj.atac
#find all the linked peaks
# first compute the GC content for each peak
obj <- RegionStats(obj, genome = BSgenome.Hsapiens.UCSC.hg38)


library(future.apply)
plan("multisession", workers=16)
options(future.globals.maxSize = 50 * 1024^3) # for 50 Gb RAM


# link peaks to genes - this takes forever, do this overnight
obj_linked <- LinkPeaks(
  object = obj,
  peak.assay = "MACS",
  expression.assay = "impRNA",
  pvalue_cutoff = 0.10,
  score_cutoff = 0.01
)

saveRDS(obj_linked,"obj_linked.rds")
