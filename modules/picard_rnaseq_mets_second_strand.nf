process picard_rnaseq {

myDir = file("${params.output}/Picard/rnaseq")
myDir.mkdirs()

publishDir "${params.output}/Picard/rnaseq", mode: 'copy', overwrite: true

input:
path(bam)
val(ref_flat)
// path(ref_flat)
// val(fasta)

output:
path("*"), emit: out

script:
"""
name=`echo "$bam" | sed 's/_mapped.*//g'`

picard CollectRnaSeqMetrics \
I=$bam \
O=\${name}.rnaseq \
REF_FLAT=$ref_flat \
STRAND=SECOND_READ_TRANSCRIPTION_STRAND
"""
/*
fasta in makes no difference
picard -Xmx5g -Xms64m CollectRnaSeqMetrics \
I=$bam \
O=\${name}.rnaseq \
REF_FLAT=$ref_flat \
R=$fasta \
STRAND=FIRST_READ_TRANSCRIPTION_STRAND
*/
}