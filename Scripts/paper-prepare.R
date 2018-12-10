library(dplyr)
source("../Scripts/loading.R")
source_folder("../TwoWorlds")
source('../Scripts/analysis-helpers.R')
sop_all <- read.table("../sop.csv", sep=";", header = T, stringsAsFactors = F)
walk_all <- read.table("../walk.csv", sep=";", header = T, stringsAsFactors = F)
walk_all$learning.condition <- walk_all$condition
walk_all$learning.condition <- dplyr::recode(walk_all$learning.condition, "real-real" = "Real", "ve-real" = "Desktop", "vr-real" = "Treadmill VR", "real-vr" = "Real", "vr-vr" = "Treadmill VR")
sop_all$learning.condition <- sop_all$condition
sop_all$testing.condition <- sop_all$condition
sop_all$learning.condition <- dplyr::recode(sop_all$learning.condition, "real-real" = "Real", "ve-real" = "Desktop", "vr-real" = "Treadmill VR", "real-vr" = "Real", "vr-vr" = "Treadmill VR")
sop_all$testing.condition <- dplyr::recode(sop_all$testing.condition, "real-real" = "Real", "ve-real" = "Real", "vr-real" = "Real", "real-vr" = "Treadmill VR", "vr-vr" = "Treadmill VR")

sub_walk_all <- walk_all %>% filter(condition %in% c("vr-real", "real-real", "ve-real"))
sub_sop_all <- sop_all %>% filter(condition %in% c("vr-real", "real-real", "ve-real"))

sub_walk_all_2 <- walk_all %>% filter(condition %in% c("vr-vr", "real-vr"))
sub_sop_all_2 <- sop_all %>% filter(condition %in% c("vr-vr", "real-vr"))