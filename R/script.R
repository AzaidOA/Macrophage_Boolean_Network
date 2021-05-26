M1M1 <-  which(cell_types == "M1__#M1__")
SOCS3_M1M1 <- c()
IL12_M1M1 <- c()
for (state in M1M1) {
      print(df[which(df$attractor == state),])
      SOCS3_M1M1 <- c(SOCS3_M1M1, df[which(df$attractor == state),"SOCS3"])
      IL12_M1M1 <- c(IL12_M1M1, df[which(df$attractor == state),"IL12_out"])
}

M1NoLabel <-  which(cell_types == "M1__#NoLabel")
#SOCS3_M1M1 <- c()
#IL12_M1M1 <- c()
for (state in M1NoLabel) {
      print(df[which(df$attractor == state),])
      #SOCS3_M1M1 <- c(SOCS3_M1M1, df[which(df$attractor == state),"SOCS3"])
      #IL12_M1M1 <- c(IL12_M1M1, df[which(df$attractor == state),"IL12_out"])
}

NoLabelM1 <-  which(cell_types == "NoLabel#M1__")
#SOCS3_M1M1 <- c()
#IL12_M1M1 <- c()
for (state in NoLabelM1) {
      print(df[which(df$attractor == state),])
      #SOCS3_M1M1 <- c(SOCS3_M1M1, df[which(df$attractor == state),"SOCS3"])
      #IL12_M1M1 <- c(IL12_M1M1, df[which(df$attractor == state),"IL12_out"])
}

NoLabel <-  which(cell_types == "NoLabel")
#SOCS3_M1M1 <- c()
#IL12_M1M1 <- c()
for (state in NoLabel) {
      print(df[which(df$attractor == state),c("IL10_out","IL12_out", "FCGR",
                                              "IL6_out","ERK","VEGF_out","HIF1a",
                                              "STAT6")])
      #SOCS3_M1M1 <- c(SOCS3_M1M1, df[which(df$attractor == state),"SOCS3"])
      #IL12_M1M1 <- c(IL12_M1M1, df[which(df$attractor == state),"IL12_out"])
}

NoLabelNoLabel <-  which(cell_types == "NoLabel#NoLabel")
#SOCS3_M1M1 <- c()
#IL12_M1M1 <- c()
for (state in NoLabelNoLabel) {
      print(df[which(df$attractor == state),c("IL10_out","IL12_out", "FCGR",
                                              "IL6_out","ERK","VEGF_out","HIF1a",
                                              "STAT6","SOCS3", "IL6R")])
      #SOCS3_M1M1 <- c(SOCS3_M1M1, df[which(df$attractor == state),"SOCS3"])
      #IL12_M1M1 <- c(IL12_M1M1, df[which(df$attractor == state),"IL12_out"])
}
