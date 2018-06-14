ez_prepare <- function(filtered_data, by){

  filtered_data <- filtered_data[complete.cases(filtered_data),]
  has_all <- filtered_data %>% group_by(id) %>% select(by) %>% count
  has_all <- has_all %>% filter(n > 4)
  filtered_data <- filtered_data %>% filter(id %in% has_all$id)
  filtered_data$id <- factor(filtered_data$id)
  return(filtered_data)
}