setwd("/bulk/liu3zhen/research/projects/mini2020/main_ms/09_methylation/01_LTR")

library(ggplot2)

methy_compare <- function(methy_file, label, ymax=0.6) {
  methyl <- read.delim(methy_file)
  methyl$group <- sub("[0-9].*", "", methyl$chr)
  methyl$group[methyl$group == "chr"] <- "core"
  methyl_ttest <- t.test(methyl$methyl_perc ~ methyl$group)
  methyl_pval <- format(methyl_ttest$p.value, digits=2, scientific=T)
  methyl_note <- paste0("p=", methyl_pval)
  methyl_plot <- ggplot(methyl, aes(x=group, y=methyl_perc)) +
    geom_boxplot(outlier.shape = NA) +
    coord_cartesian(ylim =  c(0, ymax)) +
    theme_bw() +
    xlab("") +
    ylab(paste0(label, "%"))
#geom_text(x=1.6, y=ymax*0.95, label=methyl_note, color="dodgerblue3")
  
  print(methyl_plot)

  cat(methyl_note, "\n")
}

pdf(paste0("3o_CG.methyl.boxplot.pdf"), width=2, height=2.5)
methy_compare(methy_file="2o_CG.LTR.cov", label="CG", ymax=0.6)
dev.off()

pdf(paste0("3o_CHG.methyl.boxplot.pdf"), width=2, height=2.5)
methy_compare(methy_file="2o_CHG.LTR.cov", label="CHG", ymax=0.1)
dev.off()

pdf(paste0("3o_CHH.methyl.boxplot.pdf"), width=2, height=2.5)
methy_compare(methy_file="2o_CHH.LTR.cov", label="CHH", ymax=0.2)
dev.off()
