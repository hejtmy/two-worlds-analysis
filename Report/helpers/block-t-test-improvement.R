block_t_test_improvement <- function(df, block1, block2, value){
  df <- df %>% filter(exp_block_id %in% c(block1,block2))
  mean.na <- function(data){return(mean(data, na.rm = T))}
  df_wide <- dcast(df, condition + id ~ exp_block_id, value.var = value, fun.aggregate = mean.na)
  colnames(df_wide) <- c("condition","id", "block1","block2")
  conditions <- unique(df_wide$condition)
  ls <- list()
  for(cond in conditions){
    ls[[cond]] <- t.test(df_wide[df_wide$condition == cond,"block1"], df_wide[df_wide$condition == cond,"block2"], paired=T)
  }
  return(ls)
}