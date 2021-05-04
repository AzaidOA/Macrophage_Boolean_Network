library('BoolNet')
library('BoolNetPerturb')
library("pheatmap")
library(ggplot2)
net <- loadNetwork("../CSV/reduced_boolean_network_proof.csv")
net
attr <- getAttractors(net, type="synchronous", method = "sat.restricted", maxAttractorLength = 1,
                      returnTable  = TRUE)
attr
labels <- read.csv("../CSV/macrophage_label_rules_proof.csv")
cell_types <- labelAttractors(attr, labels, sep="#")
unique(cell_types)
df <- attractorToDataframe(attr, Boolean = T)
df <- cbind(cell_types,df)
not <- which(cell_types == "NoLabel")
df_cell <- df[-not,]
#attr[][[2]] <- attr[][[2]][-not]
# Tabla de atractores
head(df_cell)
genes <- c("IL12_out", "IL10_out", "IL6_out", "STAT1", "STAT5", "NFKB",
                "VEGF_out", "STAT6", "ERK", "HIF1a", "STAT3_IL10")

hm_data <- df_cell[,c("cell_types",genes)]
colnames(hm_data[,"cell_types"]) <- "hola"
hm_data <- unique(hm_data)
hm_data <- hm_data[order(hm_data$cell_types),]
heatmap(t(unique(hm_data[,2:12])), Colv = NA,
        Rowv = NA, col = c("red", "green"), scale="column",
        labCol = hm_data$cell_types)
dev.off()
