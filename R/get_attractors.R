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
all <- all[, g]
all <- unique(all)
pheatmap(t(all), scale = "row", color = c("red", "green"),
         cluster_rows = F, cluster_cols = F)
dev.off()

