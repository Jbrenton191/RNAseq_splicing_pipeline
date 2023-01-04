Steps and options to run pipeline:

1. Create the conda environment using:

conda env create --name NAME --file FILE

This can take around 5-15 min to build.

To activate the environment:

conda activate NAME

2. Change the genome or transcripts build or gtf in the gencode_genome_download.nf file in the modules folder. New ftp links can be added and then the gunzip lines need to be updated to match those names.

3. The config file also needs to be changed depending on your system/server. It currently runs 6 processes/tasks (an individual file or module being run = 1 task) at a time and uses 6 CPUs and 36 GB of RAM per task (as currently being used on a large server). 

These can be changed depending on the resources of your server/system (remember to not remove the . before GB! It is needed). A commented version using slurm to distribute tasks is listed below for reference.

4. Metadata: 
-For key for metadata file: Enter comma seaparated column/variable names from your metadata file. Then change the name in 2pass_indv_pipe.nf from:

params.metadata_csv= "${projectDir}/ASAP_samples_master_spreadsheet_25.8.21.csv" 
to
params.metadata_csv= "${projectDir}/NEW_METADATA_FILE"

- The key for the metadata file is currently: key_for_metadata.txt

This is used to select the columns needed for sample name identification and in later analysis using DESeq and Leafcutter analysis. 

ALWAYS put sample ID/names column present in your metadata file first, then group or condition variable name to include in DESeq and Leafcutter analysis later as part of equation to account for these variables.

Currently this pipeline implements a basic analysis using group to test (If you have more than two groups for DEseq then this should be run re-run manually as only one group-group comparison will be output). If a more complex analysis is needed then Leafcutter and DESeq sections should be run manually with the addition of covariates to equation etc, but up until this point the pipeline should still be ok. For this see: https://rhreynolds.github.io/LBD-seq-bulk-analyses/overviews/RNAseq_workflow_tissue.html which has the details on how to run manually. The current pipeline is a basic implementation of this workflow.

5. R scripts are used as part of the pipeline - a quick check to see if they can be downloaded on your system prior to running the whole pipeline is to load your conda environment specified above and run (from main folder, RNAseq_splicing_pipeline folder):

Rscript ./R_scripts/Rpackage_download.R

If this runs without error then it is good to go - otherwise it check the R_scripts/Rpackage_download.R file and check which package is causing the problem. Devtools can be problematic on some servers. One way around this is use the conda version of the R package ie:
https://anaconda.org/conda-forge/r-devtools

6. The easiest way to run the pipeline is to make a screen, and run:

./nextflow_time_date_wrapper.sh 2pass_indv_pipe.nf

The pipeline can also be run in the background without using a screen using:

./nextflow_time_date_wrapper_bg.sh 2pass_indv_pipe.nf

However, the use of the screen allows for progress to be more easily checked.

The output of the pipeline will be in a folder called:

output will be in folder: output_2pass_indv

a work folder can be deleted after the run completes as this is a folder containing duplicate data but used for symlinking during pipeline run.

7. When rerunning the pipeline rename the previous output folder to something new to avoid overwrites or confusion.