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

	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/gencode.vM36.annotation.gtf.gz
	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/GRCm39.primary_assembly.genome.fa.gz

	gunzip gencode.vM36.annotation.gtf.gz

	gunzip GRCm39.primary_assembly.genome.fa.gz

	wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M36/gencode.vM36.transcripts.fa.gz

	gunzip gencode.vM36.transcripts.fa.gz
	"""
}

	
