block_t_test <- function(df, block1, block2, value){
  df <- df %>% filter(exp_block_id %in% c(block1,block2))
  mean.na <- function(data){return(mean(data, na.rm = T))}
  df_wide <- dcast(df, condition + id ~ exp_block_id, value.var = value, fun.aggregate = mean.na)
  colnames(df_wide) <- c("condition","id", "block1","block2")
  df_wide %>% group_by(condition) %>% do(tidy(t.test(.$block1, .$block2, paired = T)))
}