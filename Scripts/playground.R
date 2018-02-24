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
write.table(sop_results, file = "sop.csv", sep=";")
write.table(walk_results, file = "walk.csv", sep=";")

ls <- load_participant('tw31', settings, dir)

plot_walk_trial(ls$phase1, 8)

sop_results(ls$phase1)
walk_results(tw15$phase1)

plot_all(ls$phase1, 1:12, plot_sop_point)
plot_all(ls$phase1, 1:18, plot_walk_trial)
### RESTIOMOTE
walk_results(ls$phase1)
sop_results(ls$phase1)
ls$phase2 <- calibrate_compass(ls$phase2, 333)
plot_sop_point(ls$phase2, 12)
sop_results(ls$phase1)
plot_trial(ls$phase2, 10)
plot_true_trial_path(ls$phase1, 14)
plot_all(ls$phase2, 1:18, plot_true_trial_path)

plot_sop_point(ls$phase2, 4)
plot_all(ls$phase1, 1:12, plot_sop_point)

