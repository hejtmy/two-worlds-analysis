ez_prepare <- function(filtered_data, by){
  filtered_data <- filtered_data[complete.cases(filtered_data),]
  has_all <- filtered_data %>% group_by(id) %>% select(by) %>% count
  has_all <- has_all %>% filter(n > 4)
  filtered_data <- filtered_data %>% filter(id %in% has_all$id)
  filtered_data$id <- factor(filtered_data$id)
  return(filtered_data)
}


ez_prepare_block <- function(df, blocks){
  filtered_data <- df[df$exp_block_id %in% blocks, ]
  filtered_data <- filtered_data[complete.cases(filtered_data),]
  has_all <- filtered_data %>% group_by(id) %>% select(id, "exp_block_id") %>% unique() %>% count
  has_all <- has_all %>% filter(n == 2)
  filtered_data <- filtered_data %>% filter(id %in% has_all$id)
  filtered_data$exp_block_id <- factor(filtered_data$exp_block_id)
  return(filtered_data)
}

mean.na <- function(data){return(mean(data, na.rm = T))}