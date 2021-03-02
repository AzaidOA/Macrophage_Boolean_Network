library('BoolNet')
library('BoolNetPerturb')

net <- loadNetwork("RedMacrofagos2_160221.csv")
toSBML(net, "Macrophages_201017.sbml")
net

attr <- getAttractors(net, method = "sat.restricted", maxAttractorLength = 1,
                      returnTable  = TRUE)
attr



labels <- read.csv("Macrophages_LabelRules_120121.csv")
res <- labelAttractors(attr, labels, sep="#")
unique(res)

write(res, 'AtractoresMalEtiquetados.txt')
