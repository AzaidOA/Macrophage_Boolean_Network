library('BoolNet')
library('BoolNetPerturb')
library("pheatmap")
net <- loadNetwork("../CSV/reduced_boolean_network_proof.csv")
toSBML(net, "./MODEL/reduced_model.sbml")
net

attr <- getAttractors(net, type="synchronous", method = "sat.restricted", maxAttractorLength = 1,
                      returnTable  = TRUE)
attr



labels <- read.csv("../CSV/macrophage_label_rules_proof.csv")
cell_types <- labelAttractors(attr, labels, sep="#")
unique(cell_types)

write(cell_types, './MODEL/labeled_attractors.txt')


# Obteniendo atractores sin estado celular

attr_df <- attractorToDataframe(attr, Boolean = T)[,-1:-2]
attr_df <- cbind(attr_df, cell_types)
onlyNoLabel <- attr_df[which("NoLabel" == cell_types),]

genes_on <- c("IL12_out","IL6_out","STAT1","STAT5","IRF3","STAT6",
              "IRF4","ERK","STAT3_IL6",
              "VEGF_out","HIF1a","FCGR","IL1R","TLR4","NFKB",
              "KLF4","SOCS1","PPARG","STAT3_IL10","IL10_out","IL10_e")
genes_on <- c("STAT6","ERK","FCGR","IL1R","TLR4",
              "KLF4","SOCS1","PPARG","IL10_out","IL10_e","IL10R",
              "STAT3_IL10","SOCS3","IL6_e","IL6R","NFKB","STAT3_IL6","IL6_out")
onlyNoLabel <- onlyNoLabel[, genes_on]
onlyNoLabel <- unique(onlyNoLabel)
pheatmap(t(onlyNoLabel), scale = "row", color = c("red", "green"),
         cluster_rows = F, cluster_cols = F)
dev.off()
attr_df <- attractorToDataframe(attr, Boolean = T)[,-1:-2]
all <- attr_df
g <- c("IL6_e","IL6R","STAT3_IL10","SOCS3","NFKB","STAT3_IL6","IL6_out")
all <- all[, genes_on]
all <- unique(all)
pheatmap(t(all), scale = "row", color = c("red", "green"),
         cluster_rows = F, cluster_cols = F)
dev.off()

# pruebas
?rep
NFkB <- as.numeric(rep("0", times = 8))
mat <- matrix(NFkB, ncol = 32, nrow = 8)
IL1R <- as.numeric(rep(c("0", "1"), times =4))
FcgR <- as.numeric(rep(c("0","0","1","1"),times=2))
TLR4 <- as.numeric(rep(c("0", "1"), each =4))
attraFin <- data.frame(matrix(NA, nrow = 16, ncol = 32))
mat[,1:3] <- c(IL1R, FcgR, TLR4)
for (i in 1:8) {
      print(i)
      tempAttr <- getPathToAttractor(net,
                                     mat[i,],
                                     includeAttractorStates = c("all"))
      print(tempAttr[,1:4])
      if (i == 1)
            dfFinalNFkB <- bind_rows(tempAttr[1,], tempAttr[nrow(tempAttr),])
      else
            dfFinalNFkB <- bind_rows(dfFinalNFkB,
                             tempAttr[1,],tempAttr[nrow(tempAttr),])
}



IL6e <- c(0,1,0,1)
IL10e <- c(0,0,1,1)
IL6o <- c(0,0,0,0)
mat <- matrix(IL6o, ncol = 32, nrow = 4)
mat[,c(32)] <- c(IL6e, IL10e)
for (i in 1:4) {
      tempAttr <- getPathToAttractor(net,
                                     mat[i,],
                                     includeAttractorStates = c("all"))
      if (i == 1)
            dfFinalIL6o <- bind_rows(tempAttr[1,], tempAttr[nrow(tempAttr),])
      else
            dfFinalIL6o <- bind_rows(dfFinalIL6o,
                                     tempAttr[1,],tempAttr[nrow(tempAttr),])
}
