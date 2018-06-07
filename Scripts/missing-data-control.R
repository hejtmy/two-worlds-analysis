### CHECKINIG MISSING DATA
walk_all <- walk_all %>% group_by(id, phase) %>% mutate(na_values_phase = sum(is.na(distance)))
walk_all <- walk_all %>% group_by(id) %>% mutate(na_values = sum(is.na(distance)))

qplot(walk_all$na_values_phase[seq(1, nrow(walk_all), 18)] , bins=18)
plot(walk_all %>% group_by(na_values) %>% summarise(mean = mean(time)))
summary(lm(walk_all$time~walk_all$na_values))
summary(lm(walk_all$time~walk_all$na_values_phase))

summary(lm(walk_all$errors~walk_all$na_values))
summary(lm(walk_all$errors~walk_all$na_values_phase))

lm_walk_distance <- walk_all %>% filter(!is.na(distance))
summary(lm(lm_walk_distance$time~lm_walk_distance$na_values))
summary(lm(lm_walk_distance$time~lm_walk_distance$na_values_phase))


        