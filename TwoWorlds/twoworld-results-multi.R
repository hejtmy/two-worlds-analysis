multi_results <- function(ls, FUN){
  df_results <- data.frame()
  # PHASE 1
  for(name in names(ls)){
    print(paste0("Calculating results for ", name))
    res1 <- FUN(ls[[name]]$phase1)
    res1$type <- class(ls[[name]]$phase1)[2]
    res1$phase <- 1
    df_results <- rbind(df_results, res1)
    res2 <- FUN(ls[[name]]$phase2)
    res2$type <- class(ls[[name]]$phase2)[2]
    res2$phase <- 2
    df_results <- rbind(df_results, res2)
  }
  return(df_results)
}

multi_sop_results <- function(ls){
  return(multi_results(ls, sop_results))
}

multi_walk_results <- function(ls){
  return(multi_results(ls, walk_results))
}