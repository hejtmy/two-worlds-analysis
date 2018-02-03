#give me folder
source("build.R")
library(brainvr.R)
library(restimoter)
library(ggplot2)
source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
source("TwoWorlds/twoworld-loading.R")
source("TwoWorlds/twoworld-preparing.R")
source("TwoWorlds/twoworld-results.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/tw5_28-01-2018/"
dir_settings <- "D:/OneDrive/Vyzkum/Davis/Transfer/Settings/"

## Multiple logs version
train <- load_experiment(dir, exp_timestamp = '18-58-05-28-01-2018')

ls <- load_unity(dir, '19-31-25-28-01-2018', '19-43-09-28-01-2018')
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
goal_pos_path <- paste0(dir_settings, "/goal-positions.csv")
goal_pos <- read.csv(goal_pos_path, dec = ",")

restimoteObj <- load_restimote(dir, goal_pos)
restimoteObj <- add_goal_order(restimoteObj, c(3,5,2,1,4,6,2,5,1,4,3,6,3,2,5,6,1,4))

restimoteObj$pointing_location <- c(7,7,7,7,7,7,8,8,8,8,8,8)
restimoteObj$pointing_target <- c(1,4,2,3,6,5,6,4,2,5,3,1)
restimote_sop_results(restimoteObj)
