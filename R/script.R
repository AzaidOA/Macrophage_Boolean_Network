M1M1 <- which(cell_types == "M1__#M1__")
for (state in M1M1) {
      print(df[which(df$attractor == state),])
}

print(getAttractorSequence(attr, 1362))
print(getBasinOfAttraction(attr, 1362))
