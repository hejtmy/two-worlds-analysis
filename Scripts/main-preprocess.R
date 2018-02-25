#give me folder
#source("build.R")
library(brainvr.R)
library(restimoter)
library(ggplot2)
library(dplyr)
library(reshape2)
library(googlesheets)
source("Scripts/loading.R")
dir <- "D:/OneDrive/Vyzkum/Davis/Transfer/Data/"
dir <- "C:/Users/hejtm/OneDrive/Vyzkum/Davis/Transfer/Data/"

settings <- load_google_sheets()
ls <- load_all(settings, dir)
sop_all <- multi_sop_results(ls)
walk_all <- multi_walk_results(ls)

conditions <- sop_all %>% select(id, type, phase) %>% unique() %>% group_by(id) %>% summarise(condition = paste(type, collapse = "-"))
conditions$condition <- gsub('twunity', 'vr', conditions$condition)
conditions$condition <- gsub('restimote', 'real', conditions$condition)
sop_all <- right_join(sop_all, conditions, by = "id")
walk_all <-  right_join(walk_all, conditions, by = "id")

#Distance normalisations
distance_offices_summary <- walk_all %>% 
  group_by(type, start, goal) %>% 
  summarise(mean.dist = mean(distance, na.rm = T), 
           sd.dist = sd(distance, na.rm = T), 
           min.dist = min(distance, na.rm = T), 
           max.dist = max(distance, na.rm = T)) %>%
  arrange(start, goal)
 
 
wide_distance_offices_summary <- distance_offices_summary %>% melt(id.vars=c("type", "start", "goal")) %>% dcast(start + goal ~ type + variable)
office_distance_type_diff_min <- distance_offices_summary %>% group_by(start, goal) %>% summarise(min_diff = diff(min.dist))
qplot(data = office_distance_type_diff_min, x = 1:nrow(office_distance_type_diff_min), y = min_diff, geom = "line")

walk_all <- right_join(walk_all, distance_offices_summary[, c(1:3, 6)], by = c("type", "start", "goal"))
walk_all$min_norm_distance <- walk_all$distance/walk_all$min.dist

# TIme normalisation
time_offices_summary <- walk_all %>% 
  filter(time > 10) %>%
  group_by(type, start, goal) %>% 
  summarise(mean.time = mean(time, na.rm = T), 
            sd.time = sd(time, na.rm = T), 
            min.time = min(time, na.rm = T), 
            max.time = max(time, na.rm = T)) %>%
  arrange(start, goal)
wide_time_offices_summary <- time_offices_summary %>% melt(id.vars=c("type", "start", "goal")) %>% dcast(start + goal ~ type + variable)
office_time_type_diff_min <- time_offices_summary %>% group_by(start, goal) %>% summarise(min_diff = diff(min.time))
qplot(data = office_time_type_diff_min, x = 1:nrow(office_time_type_diff_min), y = min_diff, geom = "line")
walk_all <- right_join(walk_all, time_offices_summary[, c(1:3, 6)], by = c("type", "start", "goal"))
walk_all$min_norm_time <- walk_all$time/walk_all$min.time

write.table(sop_all, file = "sop.csv", sep=";")
write.table(walk_all, file = "walk.csv", sep=";")
