rm(list = ls())
library(ggplot2);library(tidyverse)
mydf<-read_csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\mean.SE_275.csv")
#mydf<-read_csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\mean.SE_275_relative.to.VMA1.csv")
#mye0df<-mydf
mydf$Evolution<-factor(mydf$Evolution, levels=c("Standard-evolved","DR-evolved"))
mydf$Assay<-factor(mydf$Assay, levels=c("Assayed on standard","Assayed on DR"))
mydf$History<-factor(mydf$History, levels=c("Focal","Alternate"))
mycols<-c("grey48","white")

#Note that if you want to make different plots that have different groupings, you should make multiple dataframes, each one having the appropriate "levels" assignment.
mye0df$Evolution<-factor(mydf$Evolution, levels=c("Standard-evolved","DR-evolved"))
mye0df$Assay<-factor(mydf$Assay, levels=c("Assayed on standard","Assayed on DR"))






#The following is a two factor plot.

mye0<-ggplot(mydf, aes(x=Assay, y=e0, ymin=(e0-1*e0_SE), ymax=(e0+1*e0_SE),fill = Evolution)) +#!!!!!!!!!!!!!!!!!!!!!
  #geom_point(position = position_dodge(.6),size=2.6,shape=19,aes(y=e0,color = Evolution)) + 
  #geom_point(aes(x=Assay,y=e0),shape=21,size=1.5) +
  #geom_errorbar(position = position_dodge(.6),width=0.2,size=1) + 
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=e0 - e0_SE, ymax = e0 + e0_SE), width = 0.15, size = 1.5, position = position_dodge(0.5)) +
  scale_fill_manual(values=mycols) +
  scale_color_manual(values = c('black','darkgray')) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10,12), limits=c(0,12.4), expand = c(0,0)) +
  labs(x="Assay",y="Life expectancy (days)") +#!!!!!!!!!!!!!!!!!!!!!!!! ± 1 SE
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text=element_text(size=34),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank())
plot(mye0)

#Now plot the e0 graphs as separate panels.
LDR<-mydf[1:2,]
Lstd<-mydf[3:4,]
myDRe0<-ggplot(LDR, aes(x=Assay, y=e0, ymin=(e0-1*e0_SE), ymax=(e0+1*e0_SE),fill = Evolution)) +
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=e0 - e0_SE, ymax = e0 + e0_SE), width = 0.15, size = 1.5, position = position_dodge(0.5)) +
  geom_hline(yintercept = 9.745583769, linetype=117, size = 1.25) +
  scale_fill_manual(values=mycols) +
  scale_color_manual(values = c('black','darkgray')) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10,12), limits=c(0,12.4), expand = c(0,0)) +
  labs(x="Assayed on DR",y="") +#!!!!!!!!!!!!!!!!!!!!!!!! ± 1 SE
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text.y=element_text(size=34), axis.text.x=element_text(size=0),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank()) +
  coord_fixed(2/16)
plot(myDRe0)

mystde0<-ggplot(Lstd, aes(x=Assay, y=e0, ymin=(e0-1*e0_SE), ymax=(e0+1*e0_SE),fill = Evolution)) +
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=e0 - e0_SE, ymax = e0 + e0_SE), width = 0.15, size = 1.5, position = position_dodge(0.5)) +
  geom_hline(yintercept = 6.273592001, linetype=117, size = 1.25) +
  scale_fill_manual(values=mycols) +
  scale_color_manual(values = c('black','darkgray')) +
  scale_y_continuous(breaks = c(0,2,4,6,8,10,12), limits=c(0,12.4), expand = c(0,0)) +
  labs(x="Assayed on standard",y="Life expectancy (days)") +#!!!!!!!!!!!!!!!!!!!!!!!! ± 1 SE
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text.y=element_text(size=34), axis.text.x=element_text(size=0),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank()) +
  coord_fixed(2/16)
plot(mystde0)

#The following is a two factor plot grouped by assay, rather than by history
mygg<-ggplot(mydf, aes(x=Assay, y=W, ymin=(W-1*W_SE), ymax=(W+1*W_SE),fill = Evolution)) +#!!!!!!!!!!!!!!!!!!!!!
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=W - W_SE, ymax = W + W_SE), width = .15, size = 1.5, position = position_dodge(0.5)) +
  scale_fill_manual(values=mycols) + 
  scale_y_continuous(limits = c(0,2.075), expand = c(0,0)) +
  labs(x="Assay",y="Relative reproductive fitness (W')") +#!!!!!!!!!!!!!!!!!!!!!!!! (± 1 SE)
  geom_hline(yintercept = 1, linetype=117, size = 1.25) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"), legend.key=element_blank(),axis.text=element_text(size=34),axis.title.x=element_text(size=36, colour = "black"), axis.title.y=element_text(size=36, colour = "black") , legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank(), axis.ticks.length = unit(0.2, "cm"))
plot(mygg)

#This is the W plot arranged by history
myW<-ggplot(mydf, aes(x=History, y=W, ymin=(W-1*W_SE), ymax=(W+1*W_SE),fill = Evolution)) +#!!!!!!!!!!!!!!!!!!!!!
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=W - W_SE, ymax = W + W_SE), width = .15, size = 1.5, position = position_dodge(0.5)) +
  scale_fill_manual(values=mycols) + 
  scale_y_continuous(limits = c(0,3.075), expand = c(0,0)) +
  labs(x="Assay environment",y="Relative reproductive fitness (W')") +#!!!!!!!!!!!!!!!!!!!!!!!! (± 1 SE)
  geom_hline(yintercept = 1, linetype=117, size = 1.25) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black"), legend.key=element_blank(),axis.text=element_text(size=34),axis.title.x=element_text(size=36, colour = "black"), axis.title.y=element_text(size=36, colour = "black") , legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank(), axis.ticks.length = unit(0.2, "cm"))
plot(myW)

myyield<-ggplot(mydf, aes(x=Assay, y=yield, ymin=(yield-1*yield_SE), ymax=(yield+1*yield_SE),fill = Evolution)) +#!!!!!!!!!!!!!!!!!!!!!
  #geom_point(position = position_dodge(.6),size=2.6,shape=19,aes(y=e0,color = Evolution)) + 
  #geom_point(aes(x=Assay,y=e0),shape=21,size=1.5) +
  #geom_errorbar(position = position_dodge(.6),width=0.2,size=1) + 
  geom_bar(position=position_dodge(), stat = "identity", colour="black", width = 0.5) +
  geom_errorbar(aes(ymin=yield - yield_SE, ymax = yield + yield_SE), width = 0.15, size = 1.5, position = position_dodge(0.5)) +
  scale_fill_manual(values=mycols) +
  scale_color_manual(values = c('black','darkgray')) +
  scale_y_log10(expand = c(0,0)) +
  scale_x_discrete() +
  labs(x="Assay",y="Yield (cells/mmol glucose)") +#!!!!!!!!!!!!!!!!!!!!!!!! ± 1 SE
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text=element_text(size=26),axis.title.x=element_text(size=36),axis.title.y=element_text(size=30),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank())
plot(myyield)