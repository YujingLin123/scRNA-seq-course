# scRNA-seq-course
## Introduction
##### Once gene expression has been quantified it is summarized as an expression matrix where each row corresponds to a gene (or transcript) and each column corresponds to a single cell. In the next step, the matrix should be examined to remove poor quality cells. Failure to remove low quality cells at this stage may add technical noise which has the potential to obscure the biological signals of interest in the downstream analysis.

##### Since there is currently no standard method for performing scRNA-seq, the expected values for the various QC measures that will be presented here can vary substantially from experiment to experiment. Thus, to perform QC we will be looking for cells which are outliers with respect to the rest of the dataset rather than comparing to independent quality standards. Consequently, care should be taken when comparing quality metrics across datasets sequenced using different protocols.

### Arabidopsis
##### https://bioit3.irc.ugent.be/plant-sc-atlas/

### Difference between Bulk RNA-seq and Single-cell RNA-seq
##### bulk RNA-seq we can only estimate the average expression level for each gene across a population of cells, without regard for the heterogeneity in gene expression across individual cells of that sample.
#####  Unlike with the bulk approach, with scRNA-seq we can estimate a distribution of expression levels for each gene across a population of cells. This allows us to answer new biological questions where cell-specific changes in the transcriptome are important.
![image](https://user-images.githubusercontent.com/67212190/156484396-7efc1be4-f1ec-4764-b0c6-619f0ed8c8e2.png)

### Sample Preparation Protocols
##### Broadly speaking, a typical scRNA-seq protocol consists of the following steps (illustrated in the figure below):

 * Tissue dissection and cell dissociating to obtain a suspension of cells.
 * Optionally cells may be selected (e.g. based on membrane markers, fluorescent transgenes or staining dyes).
 * Capture single cells into individual reaction containers (e.g. wells or oil droplets).
 * Extracting the RNA from each cell.
 * Reverse-transcribing the RNA to more stable cDNA.
 * Amplifying the cDNA (either by in vitro transcription or by PCR).
 * Preparing the sequencing library with adequate molecular adapters.
 * Sequencing, usually with paired-end Illumina protocols.
 * Processing the raw data to obtain a count matrix of genes-by-cells
 * Carrying several downstream analysis (the focus of this course).
##### The last step of workflow will be considered
### Cell capture
##### The three most widely used options are microtitre-plate-based, microfluidic-array-based and microfluidic-droplet-based methods.
<img src="https://user-images.githubusercontent.com/67212190/156486457-df744489-7bc9-495a-aa39-16527d4b5b2f.png" width="500" height="400"/><br/>

### Transcript Quantification
##### There are two types of transcript quantification: full-length and tag-based.The main advantage of tag-based protocols is that they can be combined with unique molecular identifiers (UMIs), which can help improve the accuracy of transcript quantification.One disadvantage of tag-based protocols is that, being restricted to one end of the transcript only, it reduces our ability to unambiguously align reads to a transcript, as well as making it difficult to distinguish different isoforms.
<img src="https://user-images.githubusercontent.com/67212190/157645626-f2e4538f-dd53-4abe-8ed9-bb96b5df9082.png" width="450" height="350"/><br/>

<img src="https://user-images.githubusercontent.com/67212190/157646058-d8a0a07a-ce78-426a-a3eb-c3aca4362cb6.png" width="450" heigth="350"/><br/>

<img src="https://user-images.githubusercontent.com/67212190/157646299-ee4ca23d-1358-4bfc-aaef-d122600bb310.png" width="700" height="450"/><br/>

### What Protocol Should I Choose
##### Clearly, full-length transcript quantification will be more appropriate if one is interested in studying different isoforms, since tagged protocols are much more limited in this regard. By contrast, UMIs can only be used with tagged protocols and they can improve gene-level quantification.

### Processing raw data
#### General Considerations
##### Human gene names are regularly updated and defined by HGNC (https://www.genenames.org/). Mouse gene names are decided by a similar consortium, MGI (http://www.informatics.jax.org/mgihome/nomen/).

### Read Alignment and Quantification in Droplet-based scRNA-seq Data
##### Single cell RNA-seq data differ from bulk RNA seq in a number of ways (see Introduction to single cell RNA-Seq chapter above). Most modern scRNA-seq technologies generate read sequences containing three key pieces of information:

cDNA fragment that identifies the RNA transcript;
Cell barcode (CB) that identifies the cell where the RNA was expressed;
Unique Molecular Identifier (UMI) that allows to collapse reads that are PCR duplicates.
In contrast to bulk RNA-seq, scRNA-seq deals with a much smaller amount of RNA, and more PCR cycles are performed. Thus, UMI barcodes become very useful and are now widely accepted in scRNAseq. Library sequencing is often done with paired-end reads, with one read containing CB + UMI (read 1 in 10x Chromium), and the other containing actual transcript sequence (read 2 in 10x Chromium).

A classical scRNA-seq workflow contains four main steps:

Mapping the cDNA fragments to a reference;
Assigning reads to genes;
Assigning reads to cells (cell barcode demultiplexing);
Counting the number of unique RNA molecules (UMI deduplication).
The outcome of this procedure is a gene/cell count matrix, which is used as an estimate of the number of RNA molecules in each cell for each gene.
