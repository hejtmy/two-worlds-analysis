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

ls <- load_participant('tw41', settings, dir)

plot_walk_trial(ls$phase1, 8)

sop_results(ls$phase1)
walk_results(ls$phase1)
plot_sop_point(ls$phase2, 8)
plot_all(ls$phase1, 1:12, plot_sop_point)
plot_all(ls$phase1$walk, 1:18, plot_trial.walk)

### RESTIOMOTE
walk_results(ls$phase2)
sop_results(ls$phase1)
ls$phase2 <- calibrate_compass(ls$phase2, 333)
sop_results(ls$phase1)
plot_trial(ls$phase2, 10)
plot_true_trial_path(ls$phase1, 14)
plot_all(ls$phase2, 1:18, plot_true_trial_path)

plot_sop_point(ls$phase2, 4)
plot_all(ls$phase1, 1:12, plot_sop_point)

