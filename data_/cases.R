library(tidyverse)

rm(list = ls())
myt <- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\cases.275.csv",header=T)
#myt <- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\cases.275_relative.to.VMA1.csv",header=T)
#
myd<-as_tibble(myt)
attach(myd)
myd<-add_column(myd, mu=(1/e0))
#names(myd)
#levels(trts)
#model14<- aov(W~Evolution+History+Evolution*History)
#model1<-aov(W~trts)
#model10<-aov(W~Evolution);summary(model10)
#summary(model1)
#summary.lm(model1)
#it is taking DEDA as the "control", or effectively the intercept, simply because that comes first alphabetically
contrasts(trts) <- cbind(c(0,0,0,0),c(0,1,-1,0),c(-1,0,0,1))
#contrasts(trts) <- cbind(c(0,1,0,-1),c(1,0,-1,0),c(0,0,0,0))
trts
model2 <- aov(W~trts)
summary.lm(model2)
mean(W)
tapply(W,trts,mean)

W2way<-aov(myd$W ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(W2way)
TukeyHSD((W2way))
plot(TukeyHSD(W2way))
#Interaction term is significant---YE does a lot better on its selected environment than on its alternate environment. DE does NOT do better on its selected env than its alternate env.

myW<- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\case.275_W.csv",header=T)
DE.f<-var.test(myW$DEDA,myW$DEYA,ratio=1,alternative = 'two.sided')
YE.f<-var.test(myW$YEDA,myW$YEYA,ratio=1,alternative = 'two.sided')
print(DE.f)
print(YE.f)
DE.t<-t.test(myW$DEDA,myW$DEYA,paired=TRUE,var.equal=TRUE,alternative="two.sided")
YE.t<-t.test(myW$YEDA,myW$YEYA,paired=TRUE,var.equal=TRUE,alternative="two.sided")
print(DE.t)
print(YE.t)

e00c2way<-aov(myd$e0_0c ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(e00c2way)
TukeyHSD(e00c2way)



e02way<-aov(myd$e0 ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(e02way)
TukeyHSD(e02way)

myt_outlier.removal <- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\cases.275_outlier.removal.csv",header=T)
myd_outlier.removal<-as_tibble(myt_outlier.removal)

e0_outlier.removal_2way <- aov(myd_outlier.removal$e0 ~ myd_outlier.removal$Evolution + myd_outlier.removal$Assay + myd_outlier.removal$Evolution*myd_outlier.removal$Assay)
summary(e0_outlier.removal_2way)
TukeyHSD(e0_outlier.removal_2way)


e0.rel2way<-aov(myd$e0.rel ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(e0.rel2way)
TukeyHSD(e0.rel2way)
#########################
#ESM
myESM <- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\case.275_ESM.csv",header=T)
V1<-var.test(myESM$CFU_DR_LY1,myESM$CFU_NR_LY1)
V1
t1<-t.test(myESM$CFU_DR_LY1,myESM$CFU_NR_LY1,alternative='l',paired=F,var.equal=T,mu=0)
t1

V2<-var.test(myESM$FC_DR_LY1,myESM$FC_NR_LY1)
V2
t2<-t.test(myESM$FC_DR_LY1,myESM$FC_NR_LY1,alternative='l',paired=F,var.equal=F,mu=0)
t2

V3<-var.test(myESM$umax_DR_LY1,myESM$umax_NR_LY1)
V3
t3<-t.test(myESM$umax_DR_LY1,myESM$umax_NR_LY1,alternative='l',paired=F,var.equal=T,mu=0)
t3





########################################
mu2way<-aov(myd$mubar ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(mu2way)
TukeyHSD(mu2way)

yield2way<-aov(myd$yield ~ myd$Evolution + myd$Assay + myd$Evolution*myd$Assay)
summary(yield2way)
TukeyHSD(yield2way)

yield2way_np<-kruskal.test(myd$yield ~ myd$Assay)
summary(yield2way_np)

#+ myd$Assay + myd$Evolution*myd$Assay)
#summary(yield2way)
#TukeyHSD(yield2way)


mye0<- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\case.275_e0.csv",header=T)
DA.f_e0<-var.test(mye0$DEDA,mye0$YEDA,ratio=1,alternative = 'two.sided')
print(DA.f_e0)
DA.t_e0<-t.test(mye0$DEDA,mye0$YEDA,paired=FALSE,var.equal=TRUE,alternative="two.sided")
print(DA.t_e0)

YA.f_e0<-var.test(mye0$DEYA,mye0$YEYA,ratio=1,alternative = 'two.sided')
print(YA.f_e0)
YA.t_e0<-t.test(mye0$DEYA,mye0$YEYA,paired=FALSE,var.equal=TRUE,alternative="two.sided")
print(YA.t_e0)

anc.f_e0<-var.test(mye0$anc_DA,mye0$anc_YA,ratio=1,alternative = 'two.sided')
print(anc.f_e0)
anc.t_e0<-t.test(mye0$anc_DA,mye0$anc_YA,paired=FALSE, var.equal = TRUE,alternative = 'g')
print(anc.t_e0)

DEDA_anc<-t.test(mye0$DEDA,mu=14.66143438,alternative = 'l')
print(DEDA_anc)
YEDA_anc<-t.test(mye0$YEDA,mu=14.66143438,alternative = 't')
print(YEDA_anc)
DEYA_anc<-t.test(mye0$DEYA,mu=8.384658075,alternative = 't')
print(DEYA_anc)
YEYA_anc<-t.test(mye0$YEYA,mu=8.384658075,alternative = 't')
print(YEYA_anc)

mye0.rel<- read.csv("C:\\Users\\RZM\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\case.275_e0.rel.csv",header=T)
DA.f_e0.rel<-var.test(mye0.rel$DEDA,mye0.rel$YEDA,ratio=1,alternative = 'two.sided')
YA.f_e0.rel<-var.test(mye0.rel$DEYA,mye0.rel$YEYA,ratio=1,alternative = 'two.sided')
print(DA.f_e0.rel)
print(YA.f_e0.rel)
DA.t_e0.rel<-t.test(mye0.rel$DEDA,mye0.rel$YEDA,paired=FALSE,var.equal=FALSE,alternative="two.sided")
YA.t_e0.rel<-t.test(mye0.rel$DEYA,mye0.rel$YEYA,paired=FALSE,var.equal=TRUE,alternative="two.sided")
print(DA.t_e0.rel)
print(YA.t_e0.rel)




#testing yield
myyield<- read.csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\case.275_yield.csv",header=T)
DE.f<-var.test(myyield$DEDA,myyield$DEYA,ratio=1,alternative = 'two.sided')
YE.f<-var.test(myyield$YEDA,myyield$YEYA,ratio=1,alternative = 'two.sided')
print(DE.f)
print(YE.f)
DE.t<-t.test(myyield$DEDA,myyield$DEYA,paired=TRUE,var.equal=TRUE,alternative="two.sided")
YE.t<-t.test(myyield$YEDA,myyield$YEYA,paired=TRUE,var.equal=TRUE,alternative="two.sided")
print(DE.t)
print(YE.t)