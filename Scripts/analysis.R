library(ggplot2)
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

ggplot(walk_all, aes(x = type, y = distance, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = type, y = time, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = condition, y = distance, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = condition, y = min_norm_distance, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = condition, y = time, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = condition, y = errors, fill=factor(phase))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

### PER BLOCK ----
ggplot(walk_all, aes(x = condition, y = min_norm_distance, fill=factor(exp_block_id))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")

ggplot(walk_all, aes(x = condition, y = errors, fill=factor(exp_block_id))) +
  stat_summary(fun.data=mean_cl_normal,position=position_dodge(0.95),geom="errorbar") + 
  stat_summary(fun.y=mean,position=position_dodge(width=0.95),geom="bar")
