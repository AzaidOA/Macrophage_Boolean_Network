M1M1 <- which(cell_types == "M1__#M1__")
for (state in M1M1) {
      print(df[which(df$attractor == state),])
}

print(getAttractorSequence(attr, 1362))
net <- loadNetwork("../CSV/reduced_boolean_network_proof.csv")

basin <- getBasinOfAttraction(attr, 4)
getTransitionTable(attr)
df <- attractorToDataframe(attr, Boolean = T)
df
