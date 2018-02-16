library(brainvr.R)
library(restimoter)
library(ggplot2)
library(googlesheets)
source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
source("TwoWorlds/twoworld-loading.R")
source("TwoWorlds/twoworld-preparing.R")
source("TwoWorlds/twoworld-results.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/tw17_06-02-2018/"
dir_settings <- "D:/OneDrive/Vyzkum/Davis/Transfer/Settings/"

ls <- load_unity(dir, '19-44-48-05-02-2018', '20-08-25-05-02-2018')
learn <- ls$learn
sop <- ls$sop

plot_trial_path(learn, 5)
get_trial_start_goal(learn, 1)
get_trial_start_goal(sop, 1)

plot_trial_path(learn, 1)

sop_results(ls)
plot_sop_point(sop, 3)
plot_all(sop, 1:12, plot_sop_point)
#see discrepancy between vive and virtualiser

### RESTIOMOTE
settings <- load_google_sheets()
goal_pos_path <- paste0(dir_settings, "/goal-positions.csv")
goal_pos <- read.csv(goal_pos_path, dec = ",")

restimoteObj <- load_restimote(dir, goal_pos)
restimoteObj <- add_goal_order(restimoteObj, settings$goal_order$Learning$`Version-3`)

restimoteObj$pointing_location <- settings$goal_order$Viewpoint$`Version-4`
restimoteObj$pointing_target <-  settings$goal_order$Pointing$`Version-4`
sop_results(restimoteObj)

plot_trial_path(restimoteObj, 2)
plot_all(restimoteObj, 1:18, plot_true_trial_path)
plot_true_trial_path(restimoteObj, 1)
