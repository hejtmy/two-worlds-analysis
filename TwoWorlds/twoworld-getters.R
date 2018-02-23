### twunity ---------
get_goal.brainvr <- function(obj, goal_id){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[goal_id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}
get_trial_goal.brainvr <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal(obj, goal_id))
}
get_trial_goal_name.brainvr <- function(obj, trialId){
  if(trialId == 0) return("Starting location")
  id <- get_trial_goal_id(obj, trialId)
  return(obj$data$experiment_log$settings$GoalNames[id])
}
get_trial_start_goal.brainvr <- function(obj, trialId){
  start <- get_trial_start(obj, trialId)
  goal <- get_trial_goal(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}
get_all_goal_positions.brainvr <- function(obj, include_SOP = FALSE){
  if(include_SOP){i <- 1:10}else{i <- 1:6}
  ls_goals <- setNames(split(obj$data$experiment_log$positions$GoalPositions[i, c(1,3)], i), i)
  return(ls_goals)
}
### walk ------
get_trial_goal_id.walk <- function(obj, trialId){
  # C# indexes from 0
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId]
  return(goal_id + 1)
}
get_trial_start.walk <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal(obj, trialId - 1))
}

## SOP ----
get_trial_goal_id.sop <- function(obj, trialId){
  #in SOP trials we actually care about Point order
  goal_id <- obj$data$experiment_log$settings$GoalPointOrder[trialId]
  #c# indexes from 0
  return(goal_id + 1)
}
get_trial_start.sop <- function(obj, trialId){
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId] + 1
  return(get_goal(obj, goal_id))
}
get_trial_start_id.sop <- function(obj, trialId){
  return(get_trial_goal_id.walk(obj, trialId))
}
get_trial_point.sop <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end, but because of unity timing
  #sometimes logged after trial finishes
  log <- get_trial_log(obj, trialId)
  point_line <- tail(log, 1)
  return(point_line)
}
get_point_start.sop <- function(obj, trialId){
  return(get_trial_start_id.sop(obj, trialId))
}