create_learn_df <- function(obj){
  N_TRIALS <- 18
  df <- data.frame(id = rep(obj$participant_id, N_TRIALS), 
                   time = rep(NA, N_TRIALS), 
                   distance = rep(NA, N_TRIALS),
                   optimal_distance = rep(NA, N_TRIALS),
                   errors = rep(NA, N_TRIALS),
                   start = rep(NA, N_TRIALS),
                   goal = rep(NA, N_TRIALS))
  return(df)
}

create_sop_df <- function(obj){
  N_POINTING <- 12
  df <- data.frame(id = rep(obj$participant_id, N_POINTING), 
                   time = rep(NA, N_POINTING), 
                   error = rep(NA, N_POINTING),
                   start = rep(NA, N_POINTING),
                   goal = rep(NA, N_POINTING))
}
