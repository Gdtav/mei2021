rm(list = ls())
setwd("/Users/guilherme/repos/mei2021/data")
require(MASS)
library(scales)

#criar tabelas a partir dos ficheiros com os resultados
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

#agregar valores pela média
#aggregate(df$col_to_aggregate, list(df$col_to_group_by), FUN=mean)
# c1_s10=aggregate(code1_size_10$runtime, list(code1_size_10$prob), FUN=mean)
# c1_s20=aggregate(code1_size_20$runtime, list(code1_size_20$prob), FUN=mean)
# c1_s30=aggregate(code1_size_30$runtime, list(code1_size_30$prob), FUN=mean)
# c1_s40=aggregate(code1_size_40$runtime, list(code1_size_40$prob), FUN=mean)
# c1_s50=aggregate(code1_size_50$runtime, list(code1_size_50$prob), FUN=mean)
# c2_s10=aggregate(code2_size_10$runtime, list(code2_size_10$prob), FUN=mean)
# c2_s20=aggregate(code2_size_20$runtime, list(code2_size_20$prob), FUN=mean)
# c2_s30=aggregate(code2_size_30$runtime, list(code2_size_30$prob), FUN=mean)
# c2_s40=aggregate(code2_size_40$runtime, list(code2_size_40$prob), FUN=mean)
# c2_s50=aggregate(code2_size_50$runtime, list(code2_size_50$prob), FUN=mean)

#como acabamos de agregar os runtime(, também podia ser pela solução otima)
#pelos conjuntos das variáveis independentes (probabilidades-size-code),
#podemos agora comparar o runtime 
plotOverlappingHist <- function(a, b, xlabel, colors=c("white","gray20","gray50"),
                                breaks=2, xlim=NULL, ylim=NULL){
  
  ahist=NULL
  bhist=NULL
  
  if(!(is.null(breaks))){
    ahist=hist(a,breaks=breaks,plot=F)
    bhist=hist(b,breaks=breaks,plot=F)
  } else {
    ahist=hist(a,plot=F)
    bhist=hist(b,plot=F)
    
    dist = ahist$breaks[2]-ahist$breaks[1]
    breaks = seq(min(ahist$breaks,bhist$breaks),max(ahist$breaks,bhist$breaks),dist)
    
    ahist=hist(a,breaks=breaks,plot=F)
    bhist=hist(b,breaks=breaks,plot=F)
  }
  
  if(is.null(xlim)){
    xlim = c(min(ahist$breaks,bhist$breaks),max(ahist$breaks,bhist$breaks))
  }
  
  if(is.null(ylim)){
    ylim = c(0,max(ahist$counts,bhist$counts))
  }
  
  overlap = ahist
  for(i in 1:length(overlap$counts)){
    if(ahist$counts[i] > 0 & bhist$counts[i] > 0){
      overlap$counts[i] = min(ahist$counts[i],bhist$counts[i])
    } else {
      overlap$counts[i] = 0
    }
  }
  
  plot(ahist, xlim=xlim, ylim=ylim, col=colors[1], xlab = xlabel, main = "")
  plot(bhist, xlim=xlim, ylim=ylim, col=colors[2], add=T)
  plot(overlap, xlim=xlim, ylim=ylim, col=colors[3], add=T)
}


plotOverlappingHist(code2_size_50$runtime, code1_size_50$runtime, "relation between code1 and code2 in n=50")


#Scatter plot w/ regression lines
lm1.out=lm(code1_size_10$runtime ~ code1_size_10$prob)
plot(lm1.out) #aqui vemos uns gráficos que não sei bem o quanto nos podem ajudar
summary(lm1.out)
lm1.out #aqui conseguimos perceber os valores da relação linear
plot(code1_size_10$prob, code1_size_10$runtime)
abline(lm1.out)

lm2.out=lm(get('code1_prob_033')$runtime ~ get('code1_prob_033')$size)
#plot(lm2.out)
#summary(lm2.out)
lm2.out
plot(get('code1_prob_033')$size, get('code1_prob_033')$runtime)
abline(lm2.out)

#Boxplot 
#para retornar os valores dos ficheiros de probabilidades tem que se usar o get('') dont ask me why
#1- Comparar codes, com prob constante e size variado
boxplot(get('code1_prob_005')$runtime, get('code2_prob_005')$runtime)
#2- Comparar codes, com size constante e prob variado
boxplot(code1_size_10$runtime, code2_size_10$runtime)


#Histogramas

#Error bar plot

#QQ plot

