1. #download fastq data and produce paired reads
wget wget https://sra-pub-run-odp.s3.amazonaws.com/sra/ERR522959/ERR522959

fastq-dump --split-3 --gzip ERR522959 -O ./
#fastq-dump --split-3 --defline-qual '+' --defline-seq '@$ac-$si/$ri length=$rl' --gzip SRR921318.sra -O bwd

less Share/ERR522959_1.fastq
less Share/ERR522959_1.fastq
 2. #Solution and Downloading the Report
mkdir fastqc_results
fastqc -o fastqc_results/ Share/ERR522959_1.fastq Share/ERR522959_2.fastq
