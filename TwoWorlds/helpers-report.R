apa_p <- function(values){
  output <- c()
  for (value in values){
    if(value < 0.01){ output <- c(output, "p < .001"); next}
    if(value < 0.05) { output <- c(output, "p < .0.05"); next}
    output <- c(output, paste0("p = ", round(value, 2)))
  }
  return(output)
}
block_t_test <- function(df, block1, block2, value, paired = T){
  df <- df %>% filter(exp_block_id %in% c(block1,block2))
  mean.na <- function(data){return(mean(data, na.rm = T))}
  df_wide <- dcast(df, learning.condition + id ~ exp_block_id, value.var = value, fun.aggregate = mean.na)
  colnames(df_wide) <- c("learning.condition","id", "block1","block2")
  df_out <- df_wide %>% group_by(learning.condition) %>% do(tidy(t.test(.$block1, .$block2, paired = paired)))
  df_out$p.value <- apa_p(df_out$p.value)
  return(df_out)
}

tukey_report <- function(tukey){
  df <- as.data.frame(tukey)
  colnames(df) <- c("diff", "p-value")
  df$`p-value` <- apa_p(df$`p-value`)
  return(df)
}