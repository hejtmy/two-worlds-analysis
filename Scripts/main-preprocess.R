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
save(settings, file = "settings.data")
ls <- load_all(settings, dir, only_ok = T)
save(ls, file = "multi_smoothed_2.data")
#load(file = "multi_smoothed.data")

sop_all <- multi_sop_results(ls)
walk_all <- multi_walk_results(ls)


##renames all jesiccas
walk_all <- walk_all %>% mutate(goal = replace(goal, goal=="Jesicca's office", "Jessica's office"),
                                start = replace(start, start=="Jesicca's office", "Jessica's office"))

### Total trial ----
walk_all$exp_trial_id <- walk_all$trial_id + (walk_all$phase-1)*18
walk_all$exp_block_id <- walk_all$block_id + (walk_all$phase-1)*3

sop_all$exp_trial_id <- sop_all$trial_id + (sop_all$phase-1)*12
sop_all$exp_block_id <- sop_all$block_id + (sop_all$phase-1)*2

### Conditions ----
conditions <- data.frame(id = settings$participants$Code,
                         phase1 = settings$participants$First.phase,
                         phase2 = settings$participants$Second.phase,
                         condition = apply(settings$participants[,c("First.phase", "Second.phase")],
                                           1, paste, collapse = "-"),
                         stringsAsFactors = F)
conditions <- melt(conditions, id.vars = c("id", "condition"), variable.name = "phase", value.name = "type")
conditions$phase <- as.numeric(gsub("phase", "", as.character(conditions$phase)))

sop_all <- left_join(sop_all, conditions, by = c("id", "phase"))
walk_all <-  left_join(walk_all, conditions, by = c("id", "phase"))

#Distance normalisations
distance_offices_summary <- walk_all %>% 
  group_by(type, start, goal) %>% 
  summarise(mean.dist = mean(distance, na.rm = T), 
            sd.dist = sd(distance, na.rm = T), 
            min.dist = min(distance, na.rm = T), 
            max.dist = max(distance, na.rm = T)) %>%
  arrange(start, goal)

walk_all <- right_join(walk_all, distance_offices_summary, by = c("type", "start", "goal"))
walk_all$min_norm_distance <- walk_all$distance/walk_all$min.dist
walk_all$norm_distance <- (walk_all$distance-walk_all$mean.dist)/walk_all$sd.dist

# TIme normalisation
time_offices_summary <- walk_all %>% 
  filter(time > 10) %>%
  group_by(type, start, goal) %>% 
  summarise(mean.time = mean(time, na.rm = T), 
            sd.time = sd(time, na.rm = T), 
            min.time = min(time, na.rm = T), 
            max.time = max(time, na.rm = T)) %>%
  arrange(start, goal)

walk_all <- right_join(walk_all, time_offices_summary, by = c("type", "start", "goal"))
walk_all$min_norm_time <- walk_all$time/walk_all$min.time
walk_all$norm_time <- (walk_all$time-walk_all$mean.time)/walk_all$sd.time

drop.cols <- c('sd.dist', 'sd.time', 'mean.dist', "mean.time", 'min.dist', 'min.time', 
               'max.dist', 'max.time', 'optimal_distance')
walk_all_new <- walk_all %>% select(-one_of(drop.cols))

sop_all$abs_error <- abs(sop_all$error)

write.table(sop_all, file = "sop_smoothed.csv", sep=";", row.names = F)
write.table(walk_all_new, file = "walk_smoothed_errors_06.csv", sep=";", row.names = F)

write.table(walk_all, file = "walk.csv", sep=";", row.names = F)
