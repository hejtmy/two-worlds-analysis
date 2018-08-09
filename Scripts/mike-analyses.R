#################################################
#################################################
##### VR-RW transfer (Lukas) ####################
##### Mixed Effects Modeling ####################
##### Author: Mike Starrett  ####################
#################################################
#################################################

#################################################
# Set path and load data
#################################################

# load ; delimited csv files
walk <- read.csv('walk.csv', header = TRUE, sep = ";")
sop <- read.csv('sop.csv', header = TRUE, sep = ";")

#################################################
# SOP Analyses
#################################################

sop$phase <- as.factor(sop$phase)
sop <- sop[!is.na(sop$error),]

#---------------------------------
# ANOVAs
#---------------------------------
# aov()
m1 <- aov(abs_error ~ phase*condition + Error(id/phase), data = sop)
summary(m1)
  # phase:  p < .001; condition: p = .166; Interaction: p = .022

# ezANOVA
library(ez)
m2 <- ezANOVA(data = sop, dv = abs_error, wid = id, within = phase, between = condition, type = 3)
m2
# phase:  p < .001; condition: p = .160; Interaction: p = .021

# lme4
# Mixed effects  models
library(lme4)
m3 <- lmer(abs_error ~ phase*condition + (1 | id/phase), data = sop)
  # returns error warning about maodel being nearly unidentifiable
summary(m3)

library(car)
Anova(m3, type = "III")
  # phase:  p < .567; condition: p = .005; Interaction: p = .017
    #NOTE: Using type II vs III flips the Main Effect significance, but doesn't change Interaction p-value

# how about nlm 
library(nlme)
m4 <- lme(abs_error ~ phase*condition, random = ~1 | id/phase, data = sop)
summary(m4)
Anova(m4, type = "III")
  # phase:  p < .567; condition: p = .005; Interaction: p = .017
    #NOTE: Same as lme4 wrt significance of effects and Type II vs III sum of square

