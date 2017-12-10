#give me folder
install.packages("../brainvr-reader/",  type = "source", repos=NULL)
library(brainvr.R)

detach("package:brainvr.R", unload = TRUE)
library(restimoter)

source("TwoWorlds/twoworld-getters.R")

dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"

## Single log version
obj <- load_experiment(dir, UnityObject)
changed <- preprocess_player_log(obj$data$player_log)
if(changed) save_preprocessed_player(dir, obj$data$player_log, obj$timestamp)

obj$map_limits <- list(x = c(-2, 105), y = c(0, 100))
obj <- mirror_axes(obj)
obj <- translate_positions(obj, c(33.5, 0, 47.75))

plt <- create_plot(obj)
dt <- get_player_log_trial(obj, 2)
plt <- plot_add_player_path(plt, dt)

start_end <- get_trial_start_goal_pos(obj, 2)
plt <- plot_add_points(plt, start_end)
plt

## Multiple logs version
experiments <- load_experiments(dir, UnityObject)
for(experiment in experiments){
  changed <- preprocess_player_log(experiment$data$player_log)
  if(changed) save_preprocessed_player(dir, experiment$data$player_log, experiment$timestamp)
}