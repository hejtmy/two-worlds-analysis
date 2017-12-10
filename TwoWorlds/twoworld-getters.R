get_trial_start_goal_pos <- function(obj, trialId){
  start <- get_trial_start_pos(obj, trialId)
  goal <- get_trial_goal_pos(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}

get_trial_start_pos <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal_pos(obj, trialId - 1))
}

get_trial_goal_pos <- function(obj, trialId){
  id <- get_trial_goal_id(obj, trialId)
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}

get_trial_goal_name <- function(obj, trialId){
  id <- get_trial_goal_id(obj, trialId)
  return(obj$data$experiment_log$settings$GoalNames[id])
}

get_trial_goal_id <- function(obj, trialId){
  # C# indexes from 0
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId]
  return(goal_id + 1)
}