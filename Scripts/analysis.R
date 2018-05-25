library(ggplot2)
source('Scripts/analysis-helpers.R')
sop_all <- read.table("sop.csv", sep=";", header = T, stringsAsFactors = F)
walk_all <- read.table("walk.csv", sep=";", header = T, stringsAsFactors = F)

t.test(abs(sop_all$error)~sop_all$phase)
t.test(abs(sop_all$time)~sop_all$phase)

t.test(abs(sop_all$error)~sop_all$type)

aov_point_condition <- aov(abs(error)~condition*phase, data = sop_all)
summary(aov_point_condition)

aov_distance_condition <- aov(min_norm_distance~condition*phase, data = walk_all)
summary(aov_distance_condition)

aov_time_condition <- aov(time~condition*phase, data = walk_all)
summary(aov_time_condition)

ggplot(sop_all, aes(x = condition, y = abs(error), fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

make_graph(sop_all[sop_all$time < 12, ], "condition", "time", "phase")

make_graph(sop_all[sop_all$time < 12, ], "condition", "time", "exp_block_id")
ggplot(sop_all, aes(time))+ geom_histogram()
ggplot(sop_all[sop_all$time < 12, ], aes(time))+ geom_histogram()

make_graph(walk_all, "condition", "distance", "phase")
make_graph(walk_all, "condition", "min_norm_distance", "phase")
make_graph(walk_all, "condition", "time", "phase")
make_graph(walk_all, "condition", "errors", "phase")

### PER BLOCK ----
make_graph(walk_all, "condition", "min_norm_distance", "exp_block_id")
make_graph(walk_all, "condition", "min_norm_time", "exp_block_id")
make_graph(walk_all, "condition", "errors", "exp_block_id")
