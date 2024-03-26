#!/bin/bash
#SBATCH --job-name=data_download
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 4
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

#################################################################
# Download fastq files from SRA 
#################################################################

# load parallel module
module load parallel/20180122
module load sratoolkit/3.0.1

# bioproject PRJDB4176

DATA=../../data
mkdir -p $DATA

ACCLIST=accessionlist.txt

cat $ACCLIST | parallel -j 4 fasterq-dump {} --outdir $DATA

# compress the files 
ls $DATA/*fastq | parallel -j 4 gzip

