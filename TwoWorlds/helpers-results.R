ez_prepare <- function(filtered_data, by){
  filtered_data <- filtered_data[complete.cases(filtered_data),]
  has_all <- filtered_data %>% group_by(id) %>% select(by) %>% count
  has_all <- has_all %>% filter(n > 4)
  filtered_data <- filtered_data %>% filter(id %in% has_all$id)
  filtered_data$id <- factor(filtered_data$id)
  return(filtered_data)
}

### Removes all cases where there is missing data in blocks
ez_prepare_block <- function(df, blocks, variable=NULL){
  filtered_data <- df[df$exp_block_id %in% blocks, ]
  if(is.null(variable)){
    filtered_data <- filtered_data[complete.cases(filtered_data),]
  } else {
    filtered_data <- filtered_data[!is.na(filtered_data[,variable]),]
  }
  
  has_all <- filtered_data %>% group_by(id) %>% select(id, "exp_block_id") %>% unique() %>% count
  has_all <- has_all %>% filter(n == 2)
  filtered_data <- filtered_data %>% filter(id %in% has_all$id)
  filtered_data$exp_block_id <- factor(filtered_data$exp_block_id)
  return(filtered_data)
}

mean.na <- function(data){return(mean(data, na.rm = T))}

m_sd_report <- function(vec, digits=2){
  m <- round(mean(vec, na.rm=T), digits)
  s <- round(sd(vec, na.rm=T), digits)
  return(paste("M = ", m, ", SD = ", s, collapse=""))
}
