process genome_download {


myDir3 = file("${params.output}/reference_downloads")
myDir3.mkdir()

publishDir "${params.output}/reference_downloads", mode: 'copy', overwrite: true

	output:
	path("*primary_assembly*.fa"), emit: fasta
	path("*.gtf"), emit: gtf
	path("*.transcripts.fa"), emit: transcripts

	script:
	"""
	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.annotation.gtf.gz
	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/GRCh38.primary_assembly.genome.fa.gz

	gunzip GRCh38.primary_assembly.genome.fa.gz
	gunzip gencode.v41.annotation.gtf.gz

	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_41/gencode.v41.transcripts.fa.gz

	gunzip gencode.v41.transcripts.fa.gz
	"""
}
