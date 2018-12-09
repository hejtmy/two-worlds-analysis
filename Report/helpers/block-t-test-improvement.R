block_t_test_improvement <- function(df, block1, block2, value){
  df <- df %>% filter(exp_block_id %in% c(block1,block2))
  mean.na <- function(data){return(mean(data, na.rm = T))}
  df_wide <- dcast(df, condition + id ~ exp_block_id, value.var = value, fun.aggregate = mean.na)
  colnames(df_wide) <- c("condition","id", "block1","block2")
  conditions <- unique(df_wide$condition)
  ls <- list()
  for(cond in conditions){
    ls[[cond]] <- t.test(df_wide[df_wide$condition == cond, "block1"], df_wide[df_wide$condition == cond,"block2"], paired=T)
    ls[[cond]]$cohen.d <- effsize::cohen.d(df_wide[df_wide$condition == cond, "block1"], df_wide[df_wide$condition == cond,"block2"], paired=T, na.rm=T)
  }
  return(ls)
}

block_t_test_improvement_report <- function(ls){
  n_conditions <- length(names(ls))
  df <- data.frame(condition=rep(NA_character_,n_conditions), 
                   Mdiff=rep(NA_real_,n_conditions), 
                   df=rep(NA_real_,n_conditions), 
                   t=rep(NA_real_,n_conditions), 
                   p=rep(NA_character_,n_conditions), 
                   d=rep(NA_real_,n_conditions), 
                   CI=rep(NA_character_,n_conditions), 
                   stringsAsFactors = F)
  for(i in 1:n_conditions){
    name <- names(ls)[i]
    cond <- ls[[i]]
    df[i,"condition"] <- name
    df[i, "Mdiff"] <- cond$estimate
    df[i, "df"] <- cond$parameter
    df[i, "t"] <- cond$statistic
    df[i, "p"] <- apa_p(cond$p.value)
    df[i, "d"] <- cond$cohen.d$estimate
    df[i, "CI"] <- paste(round(cond$conf.int[1:2], 2), collapse = ", ")
  }
  return(df)
}