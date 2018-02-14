#give me folder
#source("build.R")
library(brainvr.R)
library(restimoter)
library(ggplot2)
library(googlesheets)
source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
source("TwoWorlds/twoworld-loading.R")
source("TwoWorlds/twoworld-preparing.R")
source("TwoWorlds/twoworld-results.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/"

settings <- load_google_sheets()

ls <- load_participant('tw25', settings, dir)

plot_trial.learn(ls$phase2$learn, 10)
get_trial_start_goal(ls$phase1$learn, 1)
get_trial_start_goal(ls$phase1$sop, 1)

sop_results(ls$phase1$sop)
plot_sop_point.sop(ls$phase1$sop, 8)
plot_all(ls$phase1$sop, 1:12, plot_sop_point.sop)
plot_all(ls$phase1$learn, 1:18, plot_trial.learn)

### RESTIOMOTE
restimote_sop_results(ls$phase1)
ls$phase1 <- calibrate_compass(ls$phase1, 344)
restimote_sop_results(ls$phase1)
plot_trial_path(ls$phase2, 10)
plot_true_trial_path(ls$phase1, 14)
plot_all(ls$phase2, 1:18, plot_true_trial_path)

plot_sop_point.restimote(ls$phase2, 4)
plot_all(ls$phase2, 1:12, plot_sop_point.restimote)

