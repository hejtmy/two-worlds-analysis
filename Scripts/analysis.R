library(ggplot2)
library(dplyr)
source('Scripts/analysis-helpers.R')
sop_all <- read.table("sop.csv", sep=";", header = T, stringsAsFactors = F)
walk_all <- read.table("walk.csv", sep=";", header = T, stringsAsFactors = F)

# Descriptives ----
df_missing <- walk_all %>% 
  group_by(id, phase) %>% 
  summarise(condition = first(condition), n_na = sum(is.na(distance))) %>%
  arrange(n_na, id)

# Analysis ----

t.test(abs(sop_all$error)~sop_all$phase)
t.test(abs(sop_all$time)~sop_all$phase)

t.test(abs(sop_all$error)~sop_all$type)

aov_point_condition <- aov(abs(error)~condition*phase, data = sop_all)
summary(aov_point_condition)

aov_distance_condition <- aov(min_norm_distance~condition*phase, data = walk_all)
summary(aov_distance_condition)

aov_time_condition <- aov(time~condition*phase, data = walk_all)
summary(aov_time_condition)

# Plots ----

## Pointing ----
ggplot(sop_all, aes(x = condition, y = abs(error), fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95), geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(sop_all, aes(x = phase, y = abs(error), color = factor(condition))) +
       stat_summary(fun.data=mean_cl_normal,position=position_dodge(width=0.1), width = 0.2, geom="errorbar") + 
       stat_summary(fun.y=mean,position=position_identity(), size = 1, geom="line")

ggplot(sop_all, aes(x = condition, y = abs(error), fill=factor(exp_block_id))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95), geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95), geom="bar")

make_graph(sop_all[sop_all$time < 12,], "condition", "time", "phase")
make_graph(sop_all[sop_all$time < 12, ], "condition", "time", "exp_block_id")

## Walking ----
ggplot(sop_all, aes(time)) + geom_histogram()
ggplot(sop_all[sop_all$time < 12, ], aes(time)) + geom_histogram()

make_graph(walk_all, "condition", "distance", "phase")
make_graph(walk_all, "condition", "min_norm_distance", "phase")
make_graph(walk_all, "condition", "time", "phase")
make_graph(walk_all, "condition", "min_norm_time", "phase")
make_graph(walk_all, "condition", "errors", "phase")

### PER BLOCK ----
make_graph(walk_all, "condition", "min_norm_distance", "exp_block_id")
make_graph(walk_all, "condition", "min_norm_time", "exp_block_id")
make_graph(walk_all, "condition", "errors", "exp_block_id")

make_line_graph(walk_all, "condition", "min_norm_distance", "exp_block_id")

ggplot(walk_all, aes(x = exp_block_id, y = min_norm_distance, color = factor(condition))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(width=0.1), width = 0.2, geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_identity(), size = 1, geom="line")

ggplot(walk_all, aes(x = exp_block_id, y = errors, color = factor(condition))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(width=0.1), width = 0.2, geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_identity(), size = 1, geom="line") + 
  ylab("Number of mistakes in office decision")

