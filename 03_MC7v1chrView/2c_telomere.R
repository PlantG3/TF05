# R
setwd("/bulk/liu3zhen/research/projects/mini2020/main_ms/03_MC7v1chr/01_gfeatures")

length_scale <- 1000000
#rDNA_color <- "bisque4"
#MoTeR_color <- "darkseagreen4"
telo_color <- "red"
#centro_color <- "orange"

# chr lengths
lengths <- read.delim("/bulk/liu3zhen/research/projects/mini2020/main_ms/00_data/03_asm/TF05-1MC7/TF05-1MC7v1.length", header=F)
lengths[, 2] <- lengths[, 2] / length_scale
xrange <- c(0, max(lengths[, 2]))

# telomere (rough)
telomeres <- read.delim("TF05-1MC7v1.telomeres.hits.bed", header=F)
colnames(telomeres) <- c("chr", "start", "end")

# chrs
seqs <- lengths[, 1]
nseqs <- nrow(lengths)

######################
# plot
######################
pdf("chrEnd.features.TF05-1MC7v1.pdf", width=5, height=4.5)
par(mar = c(4, 4, 3, 0))
plot(NULL, NULL, xlim = xrange, ylim = c(1, nseqs), xaxt = "n",
     yaxt = "n", xlab = "Physical positoin (Mb)", ylab = "", main = "TF05-1MC7v1", bty = "n")
xaxis.label <- seq(from=0, to=8, by=1)
axis(1, at = xaxis.label, labels = xaxis.label)
for (i in 1:nrow(lengths)) {
  es <- seqs[i]
  eslen <- lengths[lengths[, 1] == es, 2]
  ypos <- nseqs - i + 1
  
  # chromosome
  lines(c(0, eslen), c(ypos, ypos), lwd = 5, lend = 1, col = "gray80", xpd = T)
  text(0, ypos, labels = es, xpd = T, pos = 2, cex = 1.2)
  
  # telomeres:
  telo.chr <- telomeres[telomeres$chr == es, ]
  if (nrow(telo.chr) > 0) {
    for (nt in 1:nrow(telo.chr)) {
      telo.start <- telo.chr[nt, "start"] / length_scale
      telo.end <- telo.chr[nt, "end"] / length_scale
      telo.pos <- (telo.start + telo.end) / 2
      lines(c(telo.pos, telo.pos), c(ypos-0.15, ypos+0.15), lwd = 3, lend = 1, col = telo_color)
    }
  }
}

# legends
legend_labels <- c("telomere")
legend_shapes <- c(15)
legend_colors <- c(telo_color)
legend("bottomright", bty = "n", legend = legend_labels, col = legend_colors, pch = legend_shapes)

dev.off()

