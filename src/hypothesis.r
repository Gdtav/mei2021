library(ggplot2)
library(car)
setwd("/Users/edgar/Desktop/Uc/mestrado/MEI/meta1/mei2021/mei2021/data")
filenames=c(dir("code1"))
for (filename in filenames) {
  varName=paste('code1',strsplit(filename,"\\.")[[1]][1], sep = "_")
  assign(varName, read.table(paste('code1/', filename, sep = ""), header=TRUE))
}
filenames=c(dir("code2"))
for (filename in filenames) {
  varName=paste('code2',strsplit(filename,"\\.")[[1]][1], sep = "_")
  assign(varName, read.table(paste('code2/', filename, sep = ""), header=TRUE))
}
rm(filename, filenames, varName)



shapiro.test(code1_size_50$runtime)
shapiro.test(code2_size_50$runtime)


res <- wilcox.test(code1_size_50$runtime,code2_size_50$runtime)
res$p.value





