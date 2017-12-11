# For unity learning objects only
get_trial_start_goal_pos <- function(obj, trialId){
  start <- get_trial_start_pos(obj, trialId)
  goal <- get_trial_goal_pos(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}

# For SOP objects only
get_trial_start_point_pos <- function(obj, trialId){
  # this is actually more accurate, becaseu player might not have moved yet when the trial have started
  # player moves in monobehavuiour, but trial gets logged before the move happens
  start <- get_trial_goal_pos(obj, trialId)
  point <- get_trial_point_pos(obj, trialId)
  ls <- list(start = start, point = point)
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

get_trial_point_pos <- function(obj, trialId){
  point_id <- obj$data$experiment_log$settings$GoalPointOrder[trialId]
  r_point_id <- point_id + 1
  return(get_goal_pos(obj, r_point_id))
}

#returns 2d vector of goal pos
get_trial_goal_pos <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal_pos(obj, goal_id))
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

get_goal_pos <- function(obj, goal_id){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[goal_id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}

#overrites restimote function
get_sop_trial_point <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end
  player_log <- get_player_log_trial(obj, trialId)
  point_line <- tail(player_log, 1)
}

get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}