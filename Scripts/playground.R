#give me folder
source("build.R")
library(ggplot2)
source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/tw5_28-01-2018/"
dir_settings <- "D:/OneDrive/Vyzkum/Davis/Transfer/Settings/"

## Multiple logs version
train <- load_experiment(dir, exp_timestamp = '18-58-05-28-01-2018')
learn <- load_experiment(dir, exp_timestamp = '19-31-25-28-01-2018')
sop <- load_experiment(dir, exp_timestamp = '19-43-09-28-01-2018')

if(!is_player_preprocessed(learn$data$player_log)){
  preprocess_player_log(learn$data$player_log, "virtualizer")
  #save_preprocessed_player(dir, learn$data$player_log, learn$timestamp)
}

learn <- mirror_axes(learn)
learn <- translate_positions(learn, c(33.5, 0, 47.75))
learn$map_limits <- list(x = c(-5, 105), y = c(-5, 105))
brainvr.R::make_trial_image(learn, 5)

ls <- list()
for(i in 1:17){
  ls[[i]] <- brainvr.R::make_trial_image(learn, i)
  ls[[i]] <- ls[[i]] + theme_bw()
}
navr::multiplot(ls, cols = 5)

#see discrepancy between vive and virtualiser
dt_player <- learn$data$player_log

plt <- ggplot(dt_player, aes(x = Time))
plt + geom_line(aes(y = Rotation.X), color = "black") + 
  geom_line(aes(y = Rotation.Virtualizer), color = "red")

ggplot(dt_player) + geom_histogram(aes(x = Rotation.X), fill = "black") + 
  geom_histogram(aes(x = Rotation.Virtualizer))

summary(dt_player$Rotation.X - dt_player$Rotation.Virtualizer)
summary(dt_player$Rotation.Virtualizer)

dt_player$Rotation.X <- navr::angle_to_360(dt_player$Rotation.X + 76)

### RESTIOMOTE
goal_pos_path <- paste0(dir_settings, "/goal-positions.csv")
goal_pos <- read.csv(goal_pos_path, dec = ",")

restimoteObj <- load_restimote_log(dir)
restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)

restimoteObj <- add_goal_positions(restimoteObj, goal_pos)

restimoteObj <- preprocess_companion_log(restimoteObj)
restimoteObj <- preprocess_restimote_log(restimoteObj)
restimoteObj$map_limits <- list(x = c(-2, 25), y = c(-2, 25))
restimoteObj <- add_goal_order(restimoteObj, c(3,5,2,1,4,6,2,5,1,4,3,6,3,2,5,6,1,4))

plot_restimote_path(restimoteObj, 3)
plot_true_trial_path(restimoteObj, 2)
ls <- list()
for(i in 1:17){
  ls[[i]] <- plot_restimote_path(restimoteObj, i)
}
navr::multiplot(ls, cols = 5)
