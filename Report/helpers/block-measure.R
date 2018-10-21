block_measure <- function(df, value){
  df_wide <- dcast(df, learning.condition + id ~ exp_block_id, value.var = value)
  colnames(df_wide) <- c("learning.condition","id","block1", "block2","block3","block4","block5","block6")
  
  df_wide <- df_wide %>% 
    group_by(learning.condition) %>%
    summarise(block1.mean  = mean(block1, na.rm = T),
              block3.mean = mean(block3, na.rm = T),
              block4.mean = mean(block4, na.rm = T),
              block34.diff = mean((block3-block4)/(block4+block3), na.rm = T),
              block34.se  = sqrt(var((block3-block4)/(block4+block3), na.rm = T)/sum(!is.na(block3-block4))),
              block14.diff = mean((block1-block4)/(block1+block4), na.rm = T),
              block14.se = sqrt(var((block1-block4)/(block1+block4), na.rm = T)/sum(!is.na(block1-block4)))
    )
  return(df_wide)
}