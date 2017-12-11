#give me folder
source("build.R")

source("TwoWorlds/twoworld-getters.R")
source("TwoWorlds/twoworld-visualisation.R")
dir <- "D:/GoogleDrive/Davis/Data/pilot/neo1/"

## Multiple logs version

learn <- load_experiment(dir, exp_timestamp = '17-41-52-03-12-2017')
sop <- load_experiment(dir, exp_timestamp = '18-07-09-03-12-2017')

learn$map_limits <- list(x = c(-5, 105), y = c(0, 100))
learn <- mirror_axes(learn)
learn <- translate_positions(learn, c(33.5, 0, 47.75))

sop <- mirror_axes(sop)
sop <- translate_positions(sop, c(33.5, 0, 47.75))

plot_learning_trial(learn, 17)

## calculating pointing
trialId <- 1
sop_trial_pointing_error(sop, trialId)
plot_sop_point(sop, 1)

plot_sop_points(sop, 1:6)

## Restimote
restimoteObj <- load_restimote_log(dir)
restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)

restimoteObj <- preprocess_companion_log(restimoteObj)
restimoteObj <- preprocess_restimote_log(restimoteObj)
restimoteObj <- remove_pointing(restimoteObj, c(7:8))
restimoteObj$map_limits <- list(x = c(0, 25), y = c(0, 25))

plot_restimote_path(restimoteObj, 1)