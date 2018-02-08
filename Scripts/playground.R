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
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/tw16_05-02-2018/"
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/tw15_05-02-2018/"

settings <- load_google_sheets()

## Multiple logs version
train <- load_experiment(dir, exp_timestamp = '18-58-05-28-01-2018')

ls <- load_unity(dir, '19-44-48-05-02-2018', '20-08-25-05-02-2018')
learn <- ls$learn
sop <- ls$sop

plot_trial_path(learn, 5)
get_trial_start_goal(learn, 1)
get_trial_start_goal(sop, 1)

plot_trial_path(learn, 1)

sop_results(sop)
plot_sop_point(sop, 3)
plot_all(sop, 1:12, plot_sop_point)
#see discrepancy between vive and virtualiser
dt_player <- get_log(learn)
plt <- ggplot(dt_player[5000:10000], aes(x = Time))
plt + geom_line(aes(y = Rotation.X), color = "black") + 
  geom_line(aes(y = Rotation.Virtualizer), color = "red")

ggplot(dt_player) + geom_histogram(aes(x = Rotation.X), fill = "black") + 
  geom_histogram(aes(x = Rotation.Virtualizer))

summary(dt_player$Rotation.X - dt_player$Rotation.Virtualizer)
summary(dt_player$Rotation.Virtualizer)
dt_player$Rotation.X <- navr::angle_to_360(dt_player$Rotation.X + 90)

### RESTIOMOTE
goal_pos_restimote <- settings$positions[, 1:3]

restimoteObj <- load_restimote(dir, goal_pos_restimote)
restimoteObj <- add_goal_order(restimoteObj, settings$goal_order$Learning$`Version-4`)
restimoteObj$map_limits <- list(x = c(-2, 30), y = c(-2, 30))

#temporary compass fixing
restimoteObj$log$Orientation <- navr::angle_to_360(restimoteObj$log$Orientation - 7)

restimoteObj$pointing_location <- settings$goal_order$Viewpoint$`Version-4`
restimoteObj$pointing_target <-  settings$goal_order$Pointing$`Version-4`
restimote_sop_results(restimoteObj)
plot_trial_path(restimoteObj, 10)
plot_true_trial_path(restimoteObj, 13)

plot_sop_point.restimote(restimoteObj, 1)
