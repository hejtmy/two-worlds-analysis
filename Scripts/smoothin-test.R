library(brainvr.R)
library(restimoter)
library(ggplot2)
library(dplyr)
library(reshape2)
library(googlesheets)
source("Scripts/loading.R")

load(file = "multi.data")

tw <- ls$tw42
real <- tw$phase1
vr <- tw$phase2

get_trial_distance(real, 1)
plot_trial_path(real, 1)
get_trial_distance(vr$walk, 1)
get_trial_log(vr$walk, 1)
