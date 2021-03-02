library('BoolNet')
library('BoolNetPerturb')

net <- loadNetwork("./CSV/reduced_boolean_network.csv")
toSBML(net, "./MODEL/reduced_model.sbml")
net

attr <- getAttractors(net, method = "sat.restricted", maxAttractorLength = 1,
                      returnTable  = TRUE)
attr



labels <- read.csv("./CSV/macrophage_label_rules.csv")
cell_types <- labelAttractors(attr, labels, sep="#")
unique(cell_types)

write(cell_types, './MODEL/labeled_attractors.txt')


# Obteniendo atractores sin estado celular

attr_df <- attractorToDataframe(attr, Boolean = T)[,-1:-2]
attr_df <- cbind(attr_df, cell_types)
onlyNoLabel <- attr_df[which("NoLabel" == cell_types),]

genes_on <- c("IL12_out","IL6_out","STAT1","STAT5","NFKB","IRF3","STAT6",
              "IRF4","ERK","STAT3_IL10","IL10_out","PPARG","STAT3_IL6",
              "VEGF_out","HIF1a")
onlyNoLabel <- onlyNoLabel[, genes_on]
onlyNoLabel <- unique(onlyNoLabel)
pheatmap(t(onlyNoLabel), scale = "none", color = c("red", "green"),
         cluster_rows = F, cluster_cols = F)
dev.off()
