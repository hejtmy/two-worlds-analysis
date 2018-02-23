#give me folder
#source("build.R")
library(brainvr.R)
library(restimoter)
library(ggplot2)
library(googlesheets)
source("Scripts/loading.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/"
dir <- "C:/Users/hejtm/OneDrive/Vyzkum/Davis/Transfer/Data/"

settings <- load_google_sheets()
ls <- load_all(settings, dir)
sop_results <- multi_sop_results(ls)
walk_results <- multi_walk_results(ls)
write.table(sop_results, file = "sop.csv", sep=";")
write.table(walk_results, file = "walk.csv", sep=";")