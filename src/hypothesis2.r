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

coeffs <- function(dataset) {
  lm.out=lm(log(dataset$runtime) ~ dataset$size)
  return(summary(lm.out)$coefficients[2])
}

coefficcients1 <- c(coeffs(code1_prob_05))
coefficcients1 <- c(coefficcients1, coeffs(code1_prob_1))
coefficcients1 <- c(coefficcients1, coeffs(code1_prob_2))
coefficcients1 <- c(coefficcients1, coeffs(code1_prob_25))
coefficcients1 <- c(coefficcients1, coeffs(code1_prob_33))


coefficcients2 <- c(coeffs(code2_prob_05))
coefficcients2 <- c(coefficcients2, coeffs(code2_prob_1))
coefficcients2 <- c(coefficcients2, coeffs(code2_prob_2))
coefficcients2 <- c(coefficcients2, coeffs(code2_prob_25))
coefficcients2 <- c(coefficcients2, coeffs(code2_prob_33))


shapiro.test(coefficcients1)
shapiro.test(coefficcients2)


t.test(coefficcients1,coefficcients2,conf.level = 0.95, alternative = "less")


