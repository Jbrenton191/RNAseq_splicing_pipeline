process qualimap {

myDir = file("${params.output}/Qualimap")
myDir.mkdirs()


publishDir "${params.output}/Qualimap", mode: 'copy', overwrite: true

input:
path(bam)
val(gtf)

output:
path("*"), emit: out

script:
"""

qualimap rnaseq \
-outdir . \
-bam $bam \
-gtf $gtf \
--java-mem-size=72G
"""
// -a proportional \
// -p strand-specific-reverse \
}