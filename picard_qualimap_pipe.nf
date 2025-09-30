nextflow.enable.dsl=2


     params.data="/home/MRJonathanBrenton/Hardy_ASAP_bulk/Analysis/nextflow_pd/output_2pass_indv/STAR/align/*.bam"
     params.output= "${projectDir}/output_qc" 

     include { picard_mult } from './modules/picard_mult_mets'
     include { picard_rnaseq } from './modules/picard_rnaseq_mets'
     include { picard_gc } from './modules/picard_gcbias_mets'
     include { qualimap } from './modules/qualimap'  

     workflow {

    bams=Channel.fromPath("${params.data}")

     // This is for gencode 41:
    ref_flat="/home/MRJonathanBrenton/picard_test/refFlat_gencode.txt"

    // Change to fasta used
    fasta="/home/MRJonathanBrenton/Hardy_ASAP_bulk/Analysis/nextflow_pd/output_2pass_indv/reference_downloads/redownload/GRCh38.primary_assembly.genome.fa"
    //fasta=Channel.fromPath("/home/MRJonathanBrenton/Hardy_ASAP_bulk/Analysis/nextflow_pd/output_2pass_indv/reference_downloads/redownload/GRCh38.primary_assembly.genome.fa")

    // Change to GTF used
    gtf="/home/MRJonathanBrenton/Hardy_ASAP_bulk/Analysis/nextflow_pd/output_2pass_indv/reference_downloads/redownload/gencode.v41.annotation.gtf"

    picard_mult(bams, fasta)
    picard_gc(bams, fasta)
    picard_rnaseq(bams, ref_flat)
    qualimap(bams, gtf)
     }