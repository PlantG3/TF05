setwd("/bulk/liu3zhen/research/projects/mini2020/main_ms/04_chrcomp")

# synteny
chrs <- c(paste0("chr", 1:7), "mini1", "mini2abbc")
qry_chrlen <- read.delim("/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7v1m/TF05-1MC7v1_2abbc.length", header=F)
colnames(qry_chrlen) <- c("chr", "size")
qry <- "MC7"

ref_chrlen <- read.delim("~/references/fungi/magnaporthe/B71Ref2/genome/B71Ref2.length", header=F)
colnames(ref_chrlen) <- c("chr", "size")
ref <- "B71"

is_out <- FALSE
sout_file <- "2o_sryi.syn.txt"

for (chr in chrs) {
  
  if (grepl("mini", chr)) {
    syriout <- paste0("syriout/03_", chr, "_minisyri.out")
  } else {
    syriout <- paste0("syriout/03_", chr, "_", chr, "syri.out")
  }

  syri <- read.delim(syriout, header=F, comment.char="#", stringsAsFactors=F)
  colnames(syri) <- c("ref", "refS", "refE", "rtype", "qtype", "qry", "qryS", "qryE", "ID", "ParentID", "Type", "Copy")
  syri <- syri[syri$refS != "-" & syri$qryS != "-", ]
  syri$refS <- as.numeric(as.character(syri$refS))
  syri$refE <- as.numeric(as.character(syri$refE))
  syri$qryS <- as.numeric(as.character(syri$qryS))
  syri$qryE <- as.numeric(as.character(syri$qryE))
  
  # chr10	9655	559026	-	-	chr10	1	580968	SYN1	-	SYN	-
  sout_SYN <- syri[syri$Type=="SYN", c(1:3, 6:8, 9, 11)]
  sout_SYN$Ref <- ref
  sout_SYN$Qry <- qry
  syn_ids <- sout_SYN$ID
  
  # SYN SNP, DEL, INS
  if (sum(syri$Type=="SYN")>0) {
    ref_aln_bp <- NULL
    qry_aln_bp <- NULL
    nsnp <- NULL
    ndel <- NULL
    nins <- NULL
    for (eid in syn_ids) {
      # aligned Ref and Qry
      is_synaln <- (syri$ParentID == eid & syri$Type == "SYNAL")
      ref_aln <- sum(abs(syri$refE - syri$refS + 1)[is_synaln])
      qry_aln <- sum(abs(syri$qryE - syri$qryS + 1)[is_synaln])
      ref_aln_bp <- c(ref_aln_bp, ref_aln)
      qry_aln_bp <- c(qry_aln_bp, qry_aln)
      # SNP
      nsnp_syn <- sum(syri$ParentID == eid & syri$Type == "SNP")
      nsnp <- c(nsnp, nsnp_syn)
      # DEL
      ndel_syn <- sum(syri$ParentID == eid & syri$Type == "DEL")
      ndel <- c(ndel, ndel_syn)
      # INS
      nins_syn <- sum(syri$ParentID == eid & syri$Type == "INS")
      nins <- c(nins, nins_syn)
    }
    names(ref_aln_bp) <- syn_ids
    names(qry_aln_bp) <- syn_ids
    names(nsnp) <- syn_ids
    names(ndel) <- syn_ids
    names(nins) <- syn_ids
    sout_SYN$ref_aln <- as.numeric(as.character(ref_aln_bp[sout_SYN$ID]))
    sout_SYN$qry_aln <- as.numeric(as.character(qry_aln_bp[sout_SYN$ID]))
    sout_SYN$SNP <- as.numeric(as.character(nsnp[sout_SYN$ID]))
    sout_SYN$DEL <- as.numeric(as.character(ndel[sout_SYN$ID]))
    sout_SYN$INS <- as.numeric(as.character(nins[sout_SYN$ID]))
    # merge data
    if (! is_out) {
      write.table(sout_SYN, sout_file, row.names=F, quote=F, sep="\t")
      is_out <- TRUE
    } else {
      write.table(sout_SYN, sout_file, col.names=F, append=T, row.names=F, quote=F, sep="\t")
    }
  }
}


