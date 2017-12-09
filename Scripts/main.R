#give me folder
install.packages("../brainvr-reader/",  type = "source", repos=NULL)
library(brainvr.R)

detach("package:brainvr.R", unload = TRUE)
library(restimoter)

source_folder("TwoWorlds")

dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"

## Single log version
obj <- load_experiment(dir, UnityObject)
changed <- preprocess_player_log(obj$data$player_log)
if(changed) save_preprocessed_player(dir, obj$data$player_log, obj$timestamp)

## Multiple logs version
experiments <- load_experiments(dir, UnityObject)
for(experiment in experiments){
  changed <- preprocess_player_log(experiment$data$player_log)
  if(changed) save_preprocessed_player(dir, experiment$data$player_log, experiment$timestamp)
}