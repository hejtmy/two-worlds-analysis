multi_sop_results <- function(ls, settings){
  df <- data.frame()
  for(name in names(ls)){
    print(paste0("Calculating sop for ", name))
    res <- sop_results(ls[[name]]$phase1)
    df <- rbind(df, res)
  }
  return(df)
}