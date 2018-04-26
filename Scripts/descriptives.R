library(brainvr.R)
library(restimoter)
library(ggplot2)
library(googlesheets)
source("Scripts/loading.R")
ls <- load_google_sheets()
df_participants <- ls$participants
colnames(df_participants)
ncol(df_participants)
colnames(df_participants[21:43])
colnames(df_participants)[21:43] <- c("last_eaten", "video_game_experience", 
                                      "vr_experience", "motion_sickness", 
                                      "dizzy_history", "stress_level", "stressors", 
                                      "general_discomfort", "fatigue", "headache", 
                                      "eye_strain", "focus_difficulty", "salivation", 
                                      "sweating", "nausea", "concentrate_difficulty", 
                                      "full_head", "blurred_vision", "dizzy_eyes_open", 
                                      "dizzy_eyes_closed", "vertigo", 
                                      "stomach_awareness", "burping")

phases <- colnames(df_participants)[2:3]
phases
head(df_participants)

ggplot(df_participants, aes(x = sex, fill=finished)) + 
  geom_bar(aes(x = sex), position="dodge", stat="count") + 
  facet_wrap(phases)

condition <- paste0(df_participants$First.phase, "-", df_participants$Second.phase)
df_participants$condition <- condition

# Finished per condition
plt_condition_finished <- ggplot(df_participants, aes(x = condition, fill = finished)) + 
  geom_bar(position="dodge", stat="count")

# Finished per ethnicity
plt_ethnicity_finished <- ggplot(df_participants, aes(fill=ethnicity, x=finished)) + 
  geom_bar(position="dodge", stat="count") + 
  facet_wrap(phases)

# Finished per gender
table(df_participants$finished)

#Make Plots and Tables for all above and video game experience. Also, change the
#colnames. Also make plot/table for reason to dropping out.

