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

## Multiple logs version
train <- load_experiment(dir, exp_timestamp = '18-58-05-28-01-2018')

ls <- load_participant('tw16', settings, dir)

plot_trial_path(ls$phase2$learn, 5)
get_trial_start_goal(ls$phase2$learn, 1)
get_trial_start_goal(ls$phase2$sop, 1)

plot_trial_path(learn, 1)

sop_results(ls$phase2$sop)
plot_sop_point.sop(ls$phase2$sop, 8)
plot_all(ls$phase2$sop, 1:12, plot_sop_point.sop)
#see discrepancy between vive and virtualiser
dt_player <- get_log(learn)
plt <- ggplot(dt_player[5000:10000], aes(x = Time))
### RESTIOMOTE
goal_pos_restimote <- 

restimoteObj <- load_restimote(dir, goal_pos_restimote)
restimote_learn_goal_order <- get_settings_order('tw15', "Learning", 1, settings)
restimoteObj <- add_goal_order(restimoteObj, restimote_learn_goal_order)
restimoteObj$map_limits <- list(x = c(-2, 30), y = c(-2, 30))

#temporary compass fixing
restimoteObj$log$Orientation <- navr::angle_to_360(restimoteObj$log$Orientation - 7)

restimoteObj$pointing_location <- get_settings_order('tw15', "Viewpoint", 1, settings)
restimoteObj$pointing_target <-  get_settings_order('tw15', "Pointing", 1, settings)
restimote_sop_results(restimoteObj)
plot_trial_path(restimoteObj, 10)
plot_true_trial_path(restimoteObj, 13)

plot_sop_point.restimote(restimoteObj, 1)
plot_all(restimoteObj, 1:12, plot_sop_point.restimote)
