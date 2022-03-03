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

