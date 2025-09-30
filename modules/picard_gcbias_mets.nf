process picard_gc {

myDir = file("${params.output}/Picard/gcbias")
myDir.mkdirs()

publishDir "${params.output}/Picard/gcbias", mode: 'copy', overwrite: true

input:
path(bam)
val(fasta)
// path(fasta)

output:
path("*"), emit: out

script:
"""
name=`echo "$bam" | sed 's/_mapped.*//g'`

picard CollectGcBiasMetrics \
I=$bam \
O=\${name}.gc_bias_metrics.txt \
CHART=\${name}.gc_bias_metrics.pdf \
R=$fasta \
S=\${name}.summary_metrics.txt
"""
/*
REF_FLAT=$ref_flat   \
PROGRAM=RnaSeqMetrics \
EXTRA_ARGUMENT=RnaSeqMetrics::STRAND=FIRST_READ_TRANSCRIPTION_STRAND
*/
// PROGRAM=CollectGcBiasMetrics \
}