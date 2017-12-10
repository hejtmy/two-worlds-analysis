#give me folder
install.packages("../brainvr-reader/",  type = "source", repos = NULL)
install.packages("../restimoter/", type = "source", repos = NULL )
library(brainvr.R)
library(restimoter)

detach("package:brainvr.R", unload = TRUE)
detach("package:restimoter", unload = TRUE)

source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"

## Single log version
unityObj <- load_experiment(dir, UnityObject)
changed <- preprocess_player_log(unityObj$data$player_log)
if(changed) save_preprocessed_player(dir, unityObj$data$player_log, unityObj$timestamp)

unityObj$map_limits <- list(x = c(-5, 105), y = c(0, 100))
unityObj <- mirror_axes(unityObj)
unityObj <- translate_positions(unityObj, c(33.5, 0, 47.75))

plot_learning_trial(unityObj, 17)

## Restimote
restimoteObj <- load_restimote_log(dir)
restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)



## Multiple logs version
experiments <- load_experiments(dir, UnityObject)
for(experiment in experiments){
  changed <- preprocess_player_log(experiment$data$player_log)
  if(changed) save_preprocessed_player(dir, experiment$data$player_log, experiment$timestamp)
}