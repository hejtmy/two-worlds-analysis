### sop ----------
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
get_point_start
### RESTIMOTE ----------
get_start.restimote <- function(obj, trialId){
  return(restimoter::get_start_position(obj, trialId))
}
get_goal.restimote <- function(obj, trialId){
  return(restimoter::get_goal_position(obj, trialId))
}
get_trial_goal_name.restimote <- function(obj, trialId){
  
}
get_trial_start_name.restimote <- function(obj, trialId){
  
}
get_trial_point_goal_name.restimote <- function(obj, trialId){
  
}
get_trial_point_start_name.restimote <- function(obj, trialId){
  
}
get_sop_location_target.restimote <- function(obj, trialId){
  ls <- list()
  ls$location <- get_sop_location.restimote(obj, trialId)
  ls$target <- get_sop_target.restimote(obj, trialId)
  return(ls)
}
get_sop_location.restimote <- function(obj, trialId){
  line <- obj$goal_positions[obj$pointing_location[trialId],2:3]
  return(as.numeric(line))
}
get_sop_target.restimote <- function(obj, trialId){
  line <- obj$goal_positions[obj$pointing_target[trialId],2:3]
  return(as.numeric(line))
}
get_trial_point.restimote <- function(obj, trialId){
  get_trial_point_orientation(obj, trialId)
}
get_all_goal_positions.restimote <- function(obj, include_SOP = F){
  if(include_SOP){i <- 1:10} else {i <- 1:6}
  ls_goals <- setNames(split(obj$goal_positions[i, c(2,3)], i), obj$goal_positions$Name[i])
  return(ls_goals)
}