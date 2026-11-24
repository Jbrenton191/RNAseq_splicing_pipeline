DOI:
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.13379191.svg)](https://doi.org/10.5281/zenodo.13379191)

This pipeline is now to ready to run from a dependency complete docker image hosted here:

https://hub.docker.com/repository/docker/jbrenton191/rnaseq_splicing_pipeline/general

## 0. Pull the docker image
docker pull jbrenton191/rnaseq_splicing_pipeline:rnaseq_qc_align

## 1. Run a container from the image with a mounted link to your home to access files for the pipeline:

docker run -it --name analysis_pipeline -v $HOME:/home/host_home jbrenton191/rnaseq_splicing_pipeline:rnaseq_qc_align /bin/bash

## 1.5 If running from Apptainer:

1.5.1 Pull docker:
apptainer pull rnaseq_splicing_pipeline.sif docker://jbrenton191/rnaseq_splicing_pipeline:rnaseq_qc_align

1.5.2 Run it in a shell:
apptainer shell --bind $HOME:$HOME rnaseq_splicing_pipeline.sif

1.5.3 Copy over the (or reclone this repo it in your home folder):
cp -r /root/RNAseq_splicing_pipeline ~

To activate the correct conda:

source /opt/miniconda3/etc/profile.d/conda.sh
conda activate nf_env

## 2. Check and change the genome
  Change the genome or transcripts build or gtf in the gencode_genome_download.nf file in the modules folder. New ftp links can be added and then the gunzip lines need to be updated to match those names.

The current pipeline is set to download gencode v41 gtf and transcript references and use the GRCh38 genome.

## 3. Check memory and core limits

  The config file also needs to be changed depending on your system/server. It currently runs 6 processes/tasks (an individual file or module being run = 1 task) at a time and uses 6 CPUs and 36 GB of RAM per task (as currently being used on a large server). 

  Update your docker memory allocations also to avoid any crashes. If needed the RNAseq_splicing_pipeline at /home can be copied into your /home/host_home or recloned into that location.

  These can be changed depending on the resources of your server/system (remember to not remove the . before GB! It is needed). A commented version using slurm to distribute tasks is listed below for reference.

## 4. Change file directory in 2pass_indv.nf

The pipeline is currently set up to run some small fastqs subsampled from publicly available data. 

For your own data change this (line 3) to where your FASTQ files are located (relative to the docker path). Make sure the paired files have the same R1 or R2 ending. If not adjust this to match your file naming. I.e for X_1_fastq.gz, X_2_fastq.gz it would change to: *_{1,2}_.fastq.gz

## 5. Best way to run the pipeline
  The best way to run the pipeline is to run (tmux is installed but it can be left runnning within the docker):

  ./nextflow_time_date_wrapper.sh 2pass_indv_pipe.nf

  This includes the use of the tower flag to allow for the pipeline run to be checked online.

  The pipeline can also be run in the background without using a screen using:

  ./nextflow_time_date_wrapper_bg.sh 2pass_indv_pipe.nf

  However, the the first option allows for progress to be more easily checked.

  The output of the pipeline will be in a folder called:

  output will be in folder: output_2pass_indv

  The work folder can be deleted after the run completes as this is a folder containing duplicate data but used for symlinking during pipeline run.

## 6. Rerunning the pipeline
  When rerunning the pipeline rename the previous output folder to something new to avoid overwrites or confusion.

# Notes:
The leafcutter and DEseq modules of the pipeline are currently commented out. These are better run manually and with the specific covariates that have been tested for each dataset and have a large impact on the variance of the dataset.

# Running from a conda environment alone

If you want to run from a conda environment alone - check the conda install branch and follow instructions in the readme.

# Mouse branch

There is another branch of this repository is set to work with mouse/mus musculus fastq data.
