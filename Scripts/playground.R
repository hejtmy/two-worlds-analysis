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

ls <- load_participant('tw16', settings, dir)

plot_trial_path(ls$phase1$learn, 10)
get_trial_start_goal(ls$phase1$learn, 1)
get_trial_start_goal(ls$phase1$sop, 1)

sop_results(ls$phase1$sop)
plot_sop_point.sop(ls$phase1$sop, 8)
plot_all(ls$phase1$sop, 1:12, plot_sop_point.sop)

### RESTIOMOTE
restimote_sop_results(ls$phase2)
plot_trial_path(ls$phase2, 10)
plot_true_trial_path(ls$phase2, 17)

plot_sop_point.restimote(ls$phase2, 4)
plot_all(ls$phase2, 1:12, plot_sop_point.restimote)
