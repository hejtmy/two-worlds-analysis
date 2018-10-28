apa_p <- function(values){
  output <- c()
  for (value in values){
    if(value < 0.01){ output <- c(output, "p < .001"); next}
    if(value < 0.05) { output <- c(output, "p < .0.05"); next}
    output <- c(output, paste0("p = ", round(value, 2)))
  }
  return(output)
}

tukey_report_table <- function(tukey, predictor=NULL){
  if(is.null(predictor)){
    df <-  tukey[[1]]
  } else {
    df <- tukey[[predictor]]
  }
  df <- as.data.frame(df)
  colnames(df) <- c("diff", "lwr", "upr", "p-value")
  df$`p-value` <- apa_p(df$`p-value`)
  return(df[, c(1,4)])
}

tukey_report <- function(tukey, condition,delta_name = "difference", predictor = NULL){
  df <- tukey_report_table(tukey, predictor)
  line <- df[condition,]
  report <- paste0('$\\Delta$', delta_name,' = ', round(line$diff, 2), ', ', line$`p-value`)
  return(report)
}

# NEeds fitted lme model
mixed_table_report <- function(fit_lme){
  aov_result <- as.data.frame(car::Anova(fit_lme, type = "III"))
  aov_result[,3] <- apa_p(aov_result[,3])
  aov_result$names <- rownames(aov_result)
  rownames(aov_result) <- NULL
  return(aov_result)
} 

only_blocks <- function(df, ...){
  return(df[df$exp_block_id %in% c(...),])
}