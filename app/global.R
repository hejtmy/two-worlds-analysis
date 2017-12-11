library(brainvr.R)
library(ggplot2)

source("../TwoWorlds/twoworld-getters.R")
source("../TwoWorlds/twoworld-visualisation.R")
source("../TwoWorlds/visualisation-helpers.R")
source("../TwoWorlds/twoworld-results.R")
dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"


learn <- load_experiment(dir, exp_timestamp = '17-41-52-03-12-2017')
sop <- load_experiment(dir, exp_timestamp = '18-07-09-03-12-2017')

learn$map_limits <- list(x = c(-5, 105), y = c(0, 100))
learn <- mirror_axes(learn)
learn <- translate_positions(learn, c(33.5, 0, 47.75))

sop <- mirror_axes(sop)
sop <- translate_positions(sop, c(33.5, 0, 47.75))
sop$map_limits <- list(x = c(-5, 105), y = c(0, 100))

n_learn_trials <- length(unique(learn$data$experiment_log$data$Index))
n_sop_trials <- length(unique(sop$data$experiment_log$data$Index))