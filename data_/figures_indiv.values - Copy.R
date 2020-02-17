rm(list = ls())
library(ggplot2);library(tidyverse);library(dplyr);library(ggpubr);library(Hmisc)
theme_set(
  theme_bw()
)

mydf<-read_csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\cases.275_figures.csv")


#mydf<-read_csv("C:\\Users\\rmoge\\Box Sync\\JTL_Lab\\Lab.Notebook\\20170903_DR_Evolution\\data\\mean.SE_275_relative.to.VMA1.csv")
#mye0df<-mydf
mydf$Evolution<-factor(mydf$Evolution, levels=c("NR-evolved","DR-evolved"))
mydf$Assay<-factor(mydf$Assay, levels=c("Non-restricted (NR)","Dietary restriction (DR)"))
mydf$History<-factor(mydf$History, levels=c("Home","Away"))
mycols<-c("black","black")

erel.summary <- mydf %>%
  group_by(Assay) %>%
  summarise(
    sd = sd(e0.rel, na.rm = TRUE),
    len = mean(e0.rel)
  )
erel.summary

W.summary <- mydf %>%
  group_by(Assay) %>%
  summarise(
    sd = sd(W, na.rm = TRUE),
    len = mean(W)
  )
W.summary

erel <- ggplot(mydf, aes(x=Assay, y=e0.rel))
erel + geom_jitter(
  aes(shape = Evolution, color = Evolution), #I cut out the "shape = Evolution, " part of the aes so that all shapes would be the same shape
  position = position_jitterdodge(jitter.width = 0.275, dodge.width = 0.3),
  size = 5.5, stroke =2
  ) +
  scale_shape_manual(values = c(15,0)) +#12 is a square with a vertical cross inside it
  stat_summary(
    aes(color = Evolution),
    fun.data = "mean_se", fun.args = list(mult = (1)), #mean_sdl add +/- standard deviation; mult=1 means that it is SD*1 that is drawn.  Mean_se draws the standard error of the mean
    geom = "pointrange", size = 1.5, shape=95,
    position = position_dodge(0.2)
    ) +
  scale_color_manual(values = mycols) +
  labs(x="\nAssay",y="Life expectancy (relative)\n") +
  geom_hline(yintercept = 1, linetype=117, size = 1.25) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text=element_text(size=34),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_line(color="black", size = 1.5), axis.line.y = element_line(color="black", size = 1.5), axis.ticks.y = element_line(color = "black", size = 1.5), axis.ticks.x = element_blank())

#hline<-data.frame(xa=c("Non-restricted (NR)","Dietary restriction (DR)"),v=c(13,7))
#hline$xa<-factor(hline$xa, levels=c("Non-restricted (NR)","Dietary restriction (DR)"))
#myhline <- data.frame(xa=c("Non-restricted (NR)","Dietary restriction (DR)"),v = c(13,7))








myydf<-as.data.frame(mydf)

enaught <- ggplot(myydf, aes(x=Assay, y=e0))
enaught +
  geom_errorbar(aes(ymax=c(14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075),ymin=c(14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,14.66143438,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075,8.384658075)), color=c("darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey","darkgrey"),lwd = 2.2,linetype=117) +
  geom_jitter(aes(shape = Evolution, color = Evolution), #I cut out the "shape = Evolution, " part of the aes so that all shapes would be the same shape
              position = position_jitterdodge(jitter.width = 0.4, dodge.width = 0.4),
              size = 8, stroke = 2.3
  ) +
  stat_summary(
    aes(color = Evolution),
    fun.data = "mean_se", fun.args = list(mult = (2)), #mean_sdl add +/- standard deviation; mult=1 means that it is SD*1 that is drawn.  Mean_se draws the standard error of the mean
    geom = "pointrange", size = 1.8, shape=95,
    position = position_dodge(0.4),
    show.legend=FALSE
  ) +
  scale_color_manual(values = c("black","black"), labels = c("NR-evolved","DR-evolved")) +
  scale_shape_manual(values = c(15,0), labels = c("NR-evolved", "DR-evolved")) +#12 is a square with a vertical cross inside it
  labs(x="\nAssay diet",y="Life expectancy (days)\n") +
  scale_y_continuous(limits = c(0.95,23.05),breaks=c(5,10,15,20), expand = c(0,0)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(),panel.border = element_rect(color = "black", fill = NA, size = 3.5), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text=element_text(size=34),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_blank(), axis.line.y = element_blank(), axis.ticks.y = element_line(color = "black", size = 3.5), axis.ticks.length = unit(.3, "cm"), axis.ticks.x = element_blank())




W <- ggplot(mydf, aes(x=Assay, y=W))
W +   geom_hline(yintercept = 1, linetype=117, size = 1.75, color = "darkgrey") + #(linetype=117 for dashed)
  geom_jitter(
  aes(shape = Evolution, color = Evolution), #I cut out the "shape = Evolution, " part of the aes so that all shapes would be the same shape
  position = position_jitterdodge(jitter.width = 0.5, dodge.width = 0.4),
  size = 8, stroke = 2.3
) +
  scale_shape_manual(values = c(15,0)) +
  stat_summary(
    aes(color = Evolution),
    fun.data = "mean_se", fun.args = list(mult = (2)), #mean_sdl add +/- standard deviation; mult=1 means that it is SD*1 that is drawn.  Mean_se draws the standard error of the mean
    geom = "pointrange", size = 1.8, shape = 95,
    position = position_dodge(0.4),
    show.legend = FALSE) +
  scale_color_manual(values = mycols) +
  labs(x="\nAssay diet",y= ~ atop(paste("Reproductive fitness (",italic("W'"),")"),###this adds the text that I want
                             paste(scriptstyle(" ")))) +                           ###however, trying to paste \n messes everything up. Therefore, to gain space between the title and th axis line, I pasted another argument---this starts pn a new line, and, since it was blank, it just functions like \n in thise case
  scale_y_continuous(limits = c(0.95,1.8175), expand = c(0,0)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),panel.background = element_blank(), panel.border = element_rect(color = "black", fill = NA, size = 3.5), axis.line = element_line(colour = "black")) +
  theme(legend.key=element_blank(),axis.text=element_text(size=34),axis.title=element_text(size=36),legend.text=element_text(size=22),legend.title = element_text(size=34), axis.line.x = element_blank(), axis.line.y = element_blank(), axis.ticks.y = element_line(color = "black", size = 3.5), axis.ticks.length = unit (.3, "cm"), axis.ticks.x = element_blank())