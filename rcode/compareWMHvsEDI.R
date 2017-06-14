ind <-grep("ACR-L",df$tract)
ind_tract <- ind[1]

setwd("/mnt/home/jpowen/Julia_WMH/meanJHU_WMH")
WMH_tract <- read.table(txts_use[ind_tract])

setwd("/mnt/home/jpowen/Julia_WMH/meanJHU_EDI")
EDI_tract <- read.table(txts_use[ind_tract])

