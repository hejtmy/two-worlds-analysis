### GENERIC DEFINITIONS ---------
get_trial_start <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}

get_trial_goal <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}
get_trial_goal_id

get_trial_goal_name

get_trial_start_goal <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}

### twunity ---------

get_trial_goal_id.twunity <- function(obj, trialId){
  # C# indexes from 0
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId]
  return(goal_id + 1)
}

get_trial_goal.twunity <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal_pos(obj, goal_id))
}
get_goal.twunity <- function(obj, goal_id){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[goal_id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}
get_trial_goal_name.twunity <- function(obj, trialId){
  id <- get_trial_goal_id(obj, trialId)
  return(obj$data$experiment_log$settings$GoalNames[id])
}

### learn ------
get_trial_start_goal.learn <- function(obj, trialId){
  start <- get_trial_start_pos(obj, trialId)
  goal <- get_trial_goal_pos(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}

### sop ----------
get_trial_start.sop <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal_pos(obj, trialId - 1))
}

get_trial_start_point.sop <- function(obj, trialId){
  # this is actually more accurate, becaseu player might not have moved yet when the trial have started
  # player moves in monobehavuiour, but trial gets logged before the move happens
  start <- get_trial_goal(obj, trialId)
  point <- get_trial_point(obj, trialId)
  ls <- list(start = start, point = point)
  return(ls)
}

get_trial_point.sop <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end
  player_log <- get_player_log_trial(obj, trialId)
  point_line <- tail(player_log, 1)
}

get_trial_goal.sop <- function(obj, trialId){
  point_id <- obj$data$experiment_log$settings$GoalPointOrder[trialId]
  r_point_id <- point_id + 1
  return(get_goal_pos(obj, r_point_id))
}

### RESTIMOTE ----------
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}