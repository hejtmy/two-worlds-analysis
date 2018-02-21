library(brainvr.R)
library(ggplot2)

source("../TwoWorlds/twoworld-getters.R")
source("../TwoWorlds/twoworld-visualisation.R")
source("../TwoWorlds/visualisation-helpers.R")
source("../TwoWorlds/twoworld-results.R")
dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"


walk <- load_experiment(dir, exp_timestamp = '17-41-52-03-12-2017')
sop <- load_experiment(dir, exp_timestamp = '18-07-09-03-12-2017')

walk$map_limits <- list(x = c(-5, 105), y = c(0, 100))
walk <- mirror_axes(walk)
walk <- translate_positions(walk, c(33.5, 0, 47.75))

sop <- mirror_axes(sop)
sop <- translate_positions(sop, c(33.5, 0, 47.75))
sop$map_limits <- list(x = c(-5, 105), y = c(0, 100))

n_walk_trials <- length(unique(walk$data$experiment_log$data$Index))
n_sop_trials <- length(unique(sop$data$experiment_log$data$Index))

restimoteObj <- load_restimote_log(dir)
restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)

restimoteObj <- preprocess_companion_log(restimoteObj)
restimoteObj <- preprocess_restimote_log(restimoteObj)
restimoteObj <- remove_pointing(restimoteObj, c(7:8))
restimoteObj$map_limits <- list(x = c(0, 25), y = c(0, 25))
n_restimote_trials <- restimoteObj$n_trials
ls <- get_n_pointings(restimoteObj)
n_restimote_sop <- ls$companion


dt_log <- get_position_trial(restimoteObj, 1)
restimote_nrow <- nrow(dt_log)