1. #download fastq data and produce paired reads
wget wget https://sra-pub-run-odp.s3.amazonaws.com/sra/ERR522959/ERR522959

fastq-dump --split-3 --gzip ERR522959 -O ./
#fastq-dump --split-3 --defline-qual '+' --defline-seq '@$ac-$si/$ri length=$rl' --gzip SRR921318.sra -O bwd

less Share/ERR522959_1.fastq
less Share/ERR522959_1.fastq
 2. #Solution and Downloading the Report
mkdir fastqc_results
fastqc -o fastqc_results/ Share/ERR522959_1.fastq Share/ERR522959_2.fastq

3. #cellranger单细胞转录组
#Cell Ranger - 6.1.2 (October 25, 2021)
wget -O cellranger-6.1.2.tar.gz "https://cf.10xgenomics.com/releases/cell-exp/cellranger-6.1.2.tar.gz?Expires=1647039606&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1leHAvY2VsbHJhbmdlci02LjEuMi50YXIuZ3oiLCJDb25kaXRpb24iOnsiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2NDcwMzk2MDZ9fX1dfQ__&Signature=MD5RAdJIdMWlW9~nX8sTCDvEbxFDd0F0Kcm4iwDG~4pILtZqjpk6n0VjkgLa14wuXZMQFPt2K2Hvqsks~~y-c1dd~mKYaxtVWfdTo0177jzGKBnNwATmsVyALIh33sPV3qsjEJGrFVDi-xBcaFGRY6e89MxJSYEYPhGlvp13IB-i~t2GlGaAHtVdOTPEm-G4KlkWhdZKa~Ck5rQthUZrqQ-3lBay1DgqFLDHthLqx~P83sU-lIgCB~~ltP0rusP1EYWZKfmiBgmJV8l35UwiErB6P-VREYM0ckb0rRzcFGwz-NCKlPitMwjmpuAv9rKmZpqrybXrZYofuDHGNZZpJw__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"

tar zxvf cellranger-6.1.2.tar.gz 

#下载GTF注释文件后，构建注释信息
#不能直接使用网站下载的基因组与注释文件，需要过滤一下
#参考序列只能有很少的 overlapping gene annotations，因为reads比对到多个基因会导致流程检测的分子数更少(它只要uniquely mapped的结果)
#FASTA与GTF比对和STAR兼容，GTF文件的第三列（feature type）必须有exon，过滤后的GTF只包含有注释的基因类型
cellranger mkgtf input.gtf output.gtf --attribute=key:allowable_value
# 其中键值对可以指定多个，比如
$ cellranger mkgtf Homo_sapiens.GRCh38.ensembl.gtf Homo_sapiens.GRCh38.ensembl.filtered.gtf \
                   --attribute=gene_biotype:protein_coding \
                   --attribute=gene_biotype:lincRNA \
                   --attribute=gene_biotype:antisense \
                   --attribute=gene_biotype:IG_LV_gene \
                   --attribute=gene_biotype:IG_V_gene \
                   --attribute=gene_biotype:IG_V_pseudogene \
                   --attribute=gene_biotype:IG_D_gene \
                   --attribute=gene_biotype:IG_J_gene \
                   --attribute=gene_biotype:IG_J_pseudogene \
                   --attribute=gene_biotype:IG_C_gene \
                   --attribute=gene_biotype:IG_C_pseudogene \
                   --attribute=gene_biotype:TR_V_gene \
                   --attribute=gene_biotype:TR_V_pseudogene \
                   --attribute=gene_biotype:TR_D_gene \
                   --attribute=gene_biotype:TR_J_gene \
                   --attribute=gene_biotype:TR_J_pseudogene \
                   --attribute=gene_biotype:TR_C_gene
# 这样得到的Homo_sapiens.GRCh38.ensembl.filtered.gtf结果中就不包含gene_biotype:pseudogene这部分

#然后利用mkref构建参考索引
# 基本使用(单个物种)
cellranger mkref --genome=hg19 --fasta=hg19.fa --genes=hg19-filtered-ensembl.gtf
# 可以使用--nthreads使用多线程加速
# 得到的输出结果(保存在--genome名称的目录中)
ls hg19
fasta/  genes/  pickle/  reference.json  star/

# 如果对于多个物种组合(本文的数据其实就应该这样组合起来)
cellranger mkref --genome=hg19 --fasta=hg19.fa --genes=hg19-filtered-ensembl.gtf \
                   --genome=mm10 --fasta=mm10.fa --genes=mm10-filtered-ensembl.gtf
# 得到的结果
 ls hg19_and_mm10
 fasta/  genes/  pickle/  reference.json  star/
 
 
