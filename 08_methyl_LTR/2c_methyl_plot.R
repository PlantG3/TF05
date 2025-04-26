setwd("/bulk/liu3zhen/research/projects/mini2020/main_ms/09_methylation/01_LTR")

ltr <- read.delim("1i_MC7.LTR.bed", stringsAsFactors=F, header=F)
ltr <- ltr[order(ltr[,5], decreasing=T), ]

cg_cov_file <- c("MC1.CG.LTR.bismark.cov", "MC7.CG.LTR.bismark.cov")
chg_cov_file <- c("MC1.CHG.LTR.bismark.cov", "MC7.CHG.LTR.bismark.cov")
chh_cov_file <- c("MC1.CHH.LTR.bismark.cov", "MC7.CHH.LTR.bismark.cov")

# funciton to average data from two replications
methy_read <- function(cov_f1, cov_f2, minc=10) {
  methy1 <- read.delim(cov_f1, header=F)
  colnames(methy1) <- c("chr", "start", "end", "methyl_perc1", "methyl_c1", "total_c1")
  methy2 <- read.delim(cov_f2, header=F)
  colnames(methy2) <- c("chr", "start", "end", "methyl_perc2", "methyl_c2", "total_c2")
  methy <- merge(methy1, methy2, by=c("chr", "start", "end"), all=T)
  methy$methyl_c1[is.na(methy$methyl_c1)] <- 0
  methy$methyl_c2[is.na(methy$methyl_c2)] <- 0
  methy$total_c1[is.na(methy$total_c1)] <- 0
  methy$total_c2[is.na(methy$total_c2)] <- 0
  methy$methyl_c <- methy$methyl_c1 + methy$methyl_c2
  methy$total_c <- methy$total_c1 + methy$total_c2
  methy <- methy[methy$total_c >= minc, ]
  methy$methyl_perc <- methy$methyl_c / methy$total_c
  methy_out <- methy[, c("chr", "start", "end", "methyl_perc", "total_c")]
  methy_out
}

### methylation values per site
cg <- methy_read(cg_cov_file[1], cg_cov_file[2])
chg <- methy_read(chg_cov_file[1], chg_cov_file[2])
chh <- methy_read(chh_cov_file[1], chh_cov_file[2])

### output
write.table(cg, "2o_CG.LTR.cov", quote=F, row.names=F, sep="\t")
write.table(chg, "2o_CHG.LTR.cov", quote=F, row.names=F, sep="\t")
write.table(chh, "2o_CHH.LTR.cov", quote=F, row.names=F, sep="\t")

### plot CG
pdf("2o_CG.LTR.pdf", width=6, height=8)
par(mar=c(1.5, 1.5, 0.5, 0.5), mfrow=c(9,5), mgp=c(1, 0.5, 0))
methyl_ceil <- 10
for (i in 1:45) {
  ltr_chr <- ltr[i, 1]
  ltr_start0 <- ltr[i, 2]
  ltr_end <- ltr[i, 3]
  cg_cov <- cg[cg[, 1] == ltr_chr &
               cg[, 2] > ltr_start0 &
               cg[, 3] <= ltr_end, ]
  if (nrow(cg_cov) > 1) {
    plot(NULL, NULL, xlim=range(cg_cov[, 3]/1000), ylim=range(0, methyl_ceil),
         xlab="", ylab="", main="")
    lines(cg_cov[, 3]/1000, cg_cov[, 4], lwd=1, lty=1, col="dodgerblue2")
    note <- paste(ltr[i, 4], " ", ltr_chr, "\n", ltr[i, 5])
    text(mean(range(cg_cov[, 3]/1000)), methyl_ceil * 0.45, note, pos=3, cex=0.9)
  }
}
dev.off()

### CHG
pdf("2o_CHG.LTR.pdf", width=6, height=8)
par(mar=c(1.5, 1.5, 0.5, 0.5), mfrow=c(9,5), mgp=c(1, 0.5, 0))
chg_methyl_ceil <- 4
for (i in 1:45) {
  ltr_chr <- ltr[i, 1]
  ltr_start0 <- ltr[i, 2]
  ltr_end <- ltr[i, 3]
  chg_cov <- chg[chg[, 1] == ltr_chr &
                 chg[, 2] > ltr_start0 &
                 chg[, 3] <= ltr_end, ]
  if (nrow(chg_cov) > 1) {
    plot(NULL, NULL, xlim=range(chg_cov[, 3]/1000), ylim=range(0, chg_methyl_ceil),
         xlab="", ylab="", main="")
    lines(chg_cov[, 3]/1000, chg_cov[, 4], lwd=1, lty=1, col="seagreen")
    note <- paste(ltr[i, 4], " ", ltr_chr, "\n", ltr[i, 5])
    text(mean(range(chg_cov[, 3]/1000)), methyl_ceil * 0.2, note, pos=3, cex=0.9)
  }
}
dev.off()

### CHH
pdf("2o_CHH.LTR.pdf", width=6, height=8)
par(mar=c(1.5, 1.5, 0.5, 0.5), mfrow=c(9,5), mgp=c(1, 0.5, 0))
chh_methyl_ceil <- 8
for (i in 1:45) {
  ltr_chr <- ltr[i, 1]
  ltr_start0 <- ltr[i, 2]
  ltr_end <- ltr[i, 3]
  chh_cov <- chh[chh[, 1] == ltr_chr &
                 chh[, 2] > ltr_start0 &
                 chh[, 3] <= ltr_end, ]
  if (nrow(chh_cov) > 1) {
    plot(NULL, NULL, xlim=range(chh_cov[, 3]/1000), ylim=range(0, chh_methyl_ceil),
         xlab="", ylab="", main="")
    lines(chh_cov[, 3]/1000, chh_cov[, 4], lwd=1, lty=1, col="orchid4")
    note <- paste(ltr[i, 4], " ", ltr_chr, "\n", ltr[i, 5])
    text(mean(range(chh_cov[, 3]/1000)), methyl_ceil * 0.4, note, pos=3, cex=0.9)
  }
}
dev.off()