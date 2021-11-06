setwd("../data")
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

# DRAWING PLOTS

scatterplot <- function(dataset1,dataset2,filepath) {
  #Scatter plot w/ regression lines
  lm1.out=lm(dataset1$runtime ~ dataset1$prob)
  lm2.out=lm(dataset2$runtime ~ dataset2$prob)
  xlim <- range(c(dataset1$prob,dataset2$prob))
  ylim <- range(c(dataset1$runtime,dataset2$runtime))
  pdf(filepath)
  plot(dataset1$prob, dataset1$runtime,xlim=xlim, ylim=ylim,col="green")
  points(dataset2$prob, dataset2$runtime,col="blue")
  abline(lm1.out, col="green")
  abline(lm2.out, col="blue")
  dev.off()
}

boxplot <- function(dataset1,dataset2,filepath) {
  #Scatter plot w/ regression lines
  pdf(filepath)
  boxplot(dataset1$runtime ~ dataset1$prob)
  dev.off()
}

scatterplot(code1_size_10,code2_size_10,"scatterplot10.pdf")
scatterplot(code1_size_20,code2_size_20,"scatterplot20.pdf")
scatterplot(code1_size_30,code2_size_30,"scatterplot30.pdf")
scatterplot(code1_size_40,code2_size_40,"scatterplot40.pdf")
scatterplot(code1_size_50,code2_size_50,"scatterplot50.pdf")