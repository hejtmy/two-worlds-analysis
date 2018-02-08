create_learn_df <- function(){
  N_TRIALS <- 18
  df <- data.frame(id = rep(obj$participant_id, N_TRIALS), 
                   TrialTime = rep(NA, N_TRIALS), 
                   TrialLength = rep(NA, N_TRIALS),
                   OptimalLength = rep(NA, N_TRIALS),
                   TrialErrors = rep(NA, N_TRIALS))
  return(df)
}

create_sop_df <- function(){
  N_POINTING <- 12
  df <- data.frame(id = rep(obj$participant_id, N_POINTING), 
                   PointingTime = rep(NA, N_POINTING), 
                   PointingError = rep(NA, N_POINTING))
}
