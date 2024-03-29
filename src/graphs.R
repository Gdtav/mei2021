library(ggplot2)
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

# DRAWING PLOTS

scatterplot <- function(dataset1,dataset2,filepath,filepath2) {
  lm1.out=lm(log(dataset1$runtime) ~ dataset1$prob)
  lm2.out=lm(log(dataset2$runtime) ~ dataset2$prob)
  xlim <- range(c(dataset1$prob,dataset2$prob))
  ylim <- range(c(dataset1$runtime,dataset2$runtime))
  pdf(filepath)
  lm1_coef <- coef(lm1.out)
  lm2_coef <- coef(lm2.out)
  plot(dataset1$prob, log(dataset1$runtime),xlim=xlim, ylim=ylim,col="blue", log = 'y')
  points(dataset2$prob, log(dataset2$runtime),col="green")
  lines(dataset1$prob, exp(lm1_coef[1])*exp(lm1_coef[2]*dataset1$prob), col = "blue", lwd = 2)
  lines(dataset2$prob, exp(lm2_coef[1])*exp(lm2_coef[2]*dataset2$prob), col = "green", lwd = 2)
  sink(filepath2)
  print(summary(lm1.out))
  print(summary(lm2.out))
  sink()

  #abline(exp(lm1_coef[1]),lm1_coef[2], col="green")
  #abline(exp(lm2_coef[1]),lm2_coef[2], col="blue")
  dev.off()
}

boxplot <- function(dataset1,dataset2,filepath) {
  probs <- dataset1$prob
  algorithms <- rep(c("code1","code2"),each=100)
  runtime <- c(dataset1$runtime, dataset2$runtime)
  data <- data.frame(probs, runtime, algorithms,stringsAsFactors = FALSE)
  pdf(filepath)
  p <- ggplot(data, aes(y=runtime, x=factor(probs), fill=algorithms)) + 
    geom_boxplot()
  print(p)
  dev.off()
}

scatterplot(code1_size_10,code2_size_10,"scatterplot10.pdf","scatterplot10.txt")
scatterplot(code1_size_20,code2_size_20,"scatterplot20.pdf","scatterplot20.txt")
scatterplot(code1_size_30,code2_size_30,"scatterplot30.pdf","scatterplot30.txt")
scatterplot(code1_size_40,code2_size_40,"scatterplot40.pdf","scatterplot40.txt")
scatterplot(code1_size_50,code2_size_50,"scatterplot50.pdf","scatterplot50.txt")

boxplot(code1_size_10,code2_size_10,"boxplot10.pdf")
boxplot(code1_size_20,code2_size_20,"boxplot20.pdf")
boxplot(code1_size_30,code2_size_30,"boxplot30.pdf")
boxplot(code1_size_40,code2_size_40,"boxplot40.pdf")
boxplot(code1_size_50,code2_size_50,"boxplot50.pdf")



scatterplot_sizes <- function(dataset1,dataset2,filepath,filepath2) {
  lm1.out=lm(log(dataset1$runtime) ~ dataset1$size)
  lm2.out=lm(log(dataset2$runtime) ~ dataset2$size)
  xlim <- range(c(dataset1$prob,dataset2$size))
  ylim <- range(c(dataset1$runtime,dataset2$runtime))
  pdf(filepath)
  lm1_coef <- coef(lm1.out)
  lm2_coef <- coef(lm2.out)
  plot(dataset1$size, log(dataset1$runtime),xlim=xlim, ylim=ylim,col="blue",log = 'y')
  points(dataset2$size, log(dataset2$runtime),col="green")
  lines(dataset1$size, exp(lm1_coef[1])*exp(lm1_coef[2]*dataset1$size), col = "blue", lwd = 2)
  lines(dataset2$size, exp(lm2_coef[1])*exp(lm2_coef[2]*dataset2$size), col = "green", lwd = 2)
  sink(filepath2)
  print(summary(lm1.out))
  print(summary(lm2.out))
  sink()
  
  #abline(exp(lm1_coef[1]),lm1_coef[2], col="green")
  #abline(exp(lm2_coef[1]),lm2_coef[2], col="blue")
  dev.off()
}

boxplot_sizes <- function(dataset1,dataset2,filepath) {
  sizes <- dataset1$size
  algorithms <- rep(c("code1","code2"),each=100)
  runtime <- c(dataset1$runtime, dataset2$runtime)
  data <- data.frame(sizes, runtime, algorithms,stringsAsFactors = FALSE)
  pdf(filepath)
  p <- ggplot(data, aes(y=runtime, x=factor(sizes), fill=algorithms)) + 
    geom_boxplot()
  print(p)
  dev.off()
}

scatterplot_sizes(code1_prob_05,code2_prob_05,"scatterplot05.pdf","scatterplot05.txt")
scatterplot_sizes(code1_prob_1,code2_prob_1,"scatterplot1.pdf","scatterplot1.txt")
scatterplot_sizes(code1_prob_2,code2_prob_2,"scatterplot2.pdf","scatterplot2.txt")
scatterplot_sizes(code1_prob_25,code2_prob_25,"scatterplot25.pdf","scatterplot25.txt")
scatterplot_sizes(code1_prob_33,code2_prob_33,"scatterplot33.pdf","scatterplot33.txt")

boxplot_sizes(code1_prob_05,code2_prob_05,"boxplot05.pdf")
boxplot_sizes(code1_prob_1,code2_prob_1,"boxplot1.pdf")
boxplot_sizes(code1_prob_2,code2_prob_2,"boxplot2.pdf")
boxplot_sizes(code1_prob_25,code2_prob_25,"boxplot25.pdf")
boxplot_sizes(code1_prob_33,code2_prob_33,"boxplot33.pdf")

