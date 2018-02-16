create_learn_df <- function(obj){
  N_TRIALS <- 18
  df <- data.frame(id = rep(obj$participant_id, N_TRIALS), 
                   trial_time = rep(NA, N_TRIALS), 
                   trial_distance = rep(NA, N_TRIALS),
                   optimal_distance = rep(NA, N_TRIALS),
                   trial_errors = rep(NA, N_TRIALS))
  return(df)
}

create_sop_df <- function(obj){
  N_POINTING <- 12
  df <- data.frame(id = rep(obj$participant_id, N_POINTING), 
                   pointing_time = rep(NA, N_POINTING), 
                   pointing_error = rep(NA, N_POINTING))
}
