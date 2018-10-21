block_correlation <- function(df, block1, block2, value, formula=learning.condition + id ~ exp_block_id, columns=c("learning.condition","id")){
  df <- df %>% filter(exp_block_id %in% c(block1,block2))
  mean.na <- function(data){return(mean(data, na.rm = T))}
  df_wide <- dcast(df, formula, value.var = value, fun.aggregate = mean.na)
  colnames(df_wide) <- c(columns, "block1", "block2")
  df_out <- df_wide %>% group_by(learning.condition) %>% do(tidy(cor(.$block1, .$block2, use = "complete.obs")))
  df_out$x <- round(df_out$x, 2)
  return(df_out)
}
