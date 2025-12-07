process gtf_to_ref_flat {

    input:
        path gtf

    output:
        path("refFlat_gencode.txt"), emit: ref_flat

    script:
    """
    # Convert GTF → genePredExt
    gtfToGenePred -genePredExt -geneNameAsName2 ${gtf} gencode.refflat.tmp

    # Rearrange columns into refFlat format
    paste <(cut -f 12 gencode.refflat.tmp) \
          <(cut -f 1-10 gencode.refflat.tmp) \
          > refFlat_gencode.txt
    """
}