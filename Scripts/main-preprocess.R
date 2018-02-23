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
sop_all <- multi_sop_results(ls)
walk_all <- multi_walk_results(ls)

conditions <- sop_all %>% select(id, type, phase) %>% unique() %>% group_by(id) %>% summarise(condition = paste(type, collapse = "-"))
sop_all <- right_join(sop_all, conditions, by = "id")
walk_all <-  right_join(walk_all, conditions, by = "id")

write.table(sop_all, file = "sop.csv", sep=";")
write.table(walk_all, file = "walk.csv", sep=";")
