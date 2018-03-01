# GENERICS ----
sop_results <- function(obj){
  UseMethod("sop_results")
}
sop_trial_results <- function(obj, trialId){
  UseMethod("sop_trial_results")
}
walk_results <- function(obj){
  UseMethod("walk_results")
}
walk_trial_results <- function(obj, trialId){
  UseMethod("walk_trial_results")
}
# GENERAL ----
sop_results.general <- function (obj, df_results){
  for (trialId in 1:12){
    ls <- sop_trial_results(obj, trialId)
    df_results <- list_to_row(df_results, ls, trialId)
    df_results <- add_trial_block_id(df_results, trialId)
  }
  return(df_results)
}
walk_results.general <- function(obj, df_results){
  for (trialId in 1:18){
    ls <- walk_trial_results(obj, trialId)
    df_results <- list_to_row(df_results, ls, trialId)
    df_results <- add_trial_block_id(df_results, trialId)
  }
  df_results$distance[df_results$distance == 0] <- NA
  return(df_results)
}
create_walk_df <- function(participant_id){
  N_TRIALS <- 18
  df <- data.frame(id = rep(participant_id, N_TRIALS),
                   trial_id = rep(NA, N_TRIALS),
                   block_id = rep(NA, N_TRIALS),
                   time = rep(NA, N_TRIALS), 
                   distance = rep(NA, N_TRIALS),
                   optimal_distance = rep(NA, N_TRIALS),
                   errors = rep(NA, N_TRIALS),
                   start = rep(NA, N_TRIALS),
                   goal = rep(NA, N_TRIALS))
  return(df)
}
create_sop_df <- function(participant_id){
  N_POINTING <- 12
  df <- data.frame(id = rep(participant_id, N_POINTING), 
                   trial_id = rep(NA, N_POINTING),
                   block_id = rep(NA, N_POINTING),
                   time = rep(NA, N_POINTING), 
                   error = rep(NA, N_POINTING),
                   start = rep(NA, N_POINTING),
                   goal = rep(NA, N_POINTING))
}
list_to_row <- function(df, ls, iRow){
  df_cols <- colnames(df)
  ls_names <- names(ls)
  for(name in ls_names){
    if(name %in% df_cols) df[iRow, name] <- ls[[name]]
  }
  return(df)
}
add_trial_block_id <- function(df_results, trialId){
  df_results$trial_id[trialId] <- trialId
  df_results$block_id[trialId] <- floor(trialId/6.01) + 1 #hack that works for up to 100 blocks
  return(df_results)
}