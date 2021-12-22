rm(list = ls())
library(ggplot2)
library(car)
setwd("C:/Rike/MEI/random seed data")
filenames=c(dir("code1"))
sdRS=c()
varRS=c()
for (filename in filenames) {
  varName=paste('RScode1',strsplit(filename,"\\.")[[1]][1], sep = "_")
  if(grepl("size",varName)){
    assign(varName, read.table(paste('code1/', filename, sep = ""), header=TRUE))
    sdRS=c(sdRS, (sd(get(varName)$runtime)))
    varRS=c(varRS, (var(get(varName)$runtime)))
  }
}
filenames=c(dir("code2"))
for (filename in filenames) {
  varName=paste('RScode2',strsplit(filename,"\\.")[[1]][1], sep = "_")
  if(grepl("size",varName)){
    assign(varName, read.table(paste('code2/', filename, sep = ""), header=TRUE))
    sdRS=c(sdRS, (sd(get(varName)$runtime)))
    varRS=c(varRS, (var(get(varName)$runtime)))
  }
}
rm(filename, filenames, varName)

setwd("C:/Rike/MEI/assignment/data")
filenames=c(dir("code1"))
sd1S = c()
var1S = c()
for (filename in filenames) {
  varName=paste('code1',strsplit(filename,"\\.")[[1]][1], sep = "_")
  if(grepl("size",varName)){
    assign(varName, read.table(paste('code1/', filename, sep = ""), header=TRUE))
    sd1S=c(sd1S, (sd(get(varName)$runtime)))
    var1S=c(var1S, (var(get(varName)$runtime)))
  }
}
filenames=c(dir("code2"))
for (filename in filenames) {
  varName=paste('code2',strsplit(filename,"\\.")[[1]][1], sep = "_")
  if(grepl("size",varName)){
    assign(varName, read.table(paste('code2/', filename, sep = ""), header=TRUE))
    sd1S=c(sd1S, (sd(get(varName)$runtime)))
    var1S=c(var1S, (var(get(varName)$runtime)))
  }
}
rm(filename, filenames, varName)


View(sdRS)
View(sd1S)

shapiro.test(sdRS)
shapiro.test(sd1S)
res <- wilcox.test(sdRS, sd1S)
res$p.value
pdf("sd.pdf")
boxplot(sdRS, sd1S)
dev.off()

# shapiro.test(varRS)
# shapiro.test(var1S)
# 
# 
# res <- wilcox.test(sdRS,sd1S, paired = FALSE)
# res$p.value
# 
# res1 <- wilcox.test(sdRS,rev(sd1S))
# res1$p.value

# res2 <- wilcox.test(varRS,var1S)
# res2$p.value
# 
# 
# t.test(varRS,var1S, alternative = "two.sided", var.equal = FALSE)
# t.test(sdRS,sd1S, alternative = "one.sided", var.equal = TRUE)
# t.test(sd1S,rev(sd1S), alternative = "two.sided", var.equal = TRUE)
# t.test(sd1S,rev(sd1S), alternative = "two.sided", var.equal = FALSE)
# 
# 
# t.test(sd1S,sdRS, paired=FALSE, conf.level = 0.95)
# tcv = qt(p=0.05/2, df=99, lower.tail=FALSE)
# tcv
# qqnorm(sd1S,sdRS)
# qqline(sd1S,sdRS)
