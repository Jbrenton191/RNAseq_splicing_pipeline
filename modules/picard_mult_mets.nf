process picard_mult {

myDir = file("${params.output}/Picard/multiple_mets")
myDir.mkdirs()

publishDir "${params.output}/Picard/multiple_mets", mode: 'copy', overwrite: true

input:
path(bam)
val(fasta)
// path(fasta)

output:
path("*"), emit: out

script:
"""
name=`echo "$bam" | sed 's/_mapped.*//g'`

picard CollectMultipleMetrics \
I=$bam \
O=\${name}.multiple_metrics  \
R=$fasta
"""
/*
REF_FLAT=$ref_flat   \
PROGRAM=RnaSeqMetrics \
EXTRA_ARGUMENT=RnaSeqMetrics::STRAND=FIRST_READ_TRANSCRIPTION_STRAND
*/
// PROGRAM=CollectGcBiasMetrics \
}