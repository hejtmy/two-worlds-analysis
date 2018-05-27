library(brainvr.R)
library(restimoter)
library(ggplot2)
library(dplyr)
library(reshape2)
library(googlesheets)
source("Scripts/loading.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/"
#dir <- "C:/Users/hejtm/OneDrive/Vyzkum/Davis/Transfer/Data/"

settings <- load_google_sheets()

code <- "tw103"
ls <- load_participant(code, settings, dir)
sop_results(ls$phase1)
sop_results(ls$phase2)
walk_results(ls$phase1) #takes long time and is correct if sop is correct
walk_results(ls$phase2)

plot_walk_trial(ls$phase1, 5)

plot_all(ls$phase2, 1:12, plot_sop_point)

plot_all(ls$phase2, 1:18, plot_walk_trial)

diff(get_action_times.restimote(ls$phase1, "New trial"))
ls$phase2$log[ls$phase2$log$Action == "pointed","Time"]
