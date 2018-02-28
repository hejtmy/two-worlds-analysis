# Walk ----
get_trial_start_id.restimote <- function(obj, trialId){
  if(trialId == 1) return(NULL)
  return(obj$goal_order[trialId-1])
}
get_trial_start.restimote <- function(obj, trialId){
  return(restimoter::get_start_position(obj, trialId))
}
get_trial_start_name.restimote <- function(obj, trialId){
  iStart <- get_trial_start_id.restimote(obj, trialId)
  if(is.null(iStart)) return('Starting location')
  return(get_goal_name.restimote(obj, iStart))
}
get_trial_goal_id.restimote <- function(obj, trialId){
  return(obj$goal_order[trialId])
}
get_trial_goal.restimote <- function(obj, trialId){
  return(restimoter::get_goal_position(obj, trialId))
}
get_trial_goal_name.restimote <- function(obj, trialId){
  iGoal <- get_trial_goal_id.restimote(obj, trialId)
  return(get_goal_name.restimote(obj, iGoal))
}
get_trial_errors.restimote <- function(obj, trialId){
  return(get_trial_n_actions(obj, trialId, "Wrong door"))
}
# SOP ----
get_point_start_id.restimote <- function(obj, trialId){
  return(obj$pointing_location[trialId])
}
get_point_start.restimote<- function(obj, trialId){
  iStart <- get_point_start_id.restimote(obj, trialId)
  line <- obj$goal_positions[iStart, 2:3]
  return(as.numeric(line))
}
get_point_start_name.restimote<- function(obj, trialId){
  iStart <- get_point_start_id.restimote(obj, trialId)
  return(get_goal_name.restimote(obj, iStart))
}
get_point_goal_id.restimote<- function(obj, trialId){
  return(obj$pointing_target[trialId])
}
get_point_goal.restimote<- function(obj, trialId){
  iGoal <- get_point_goal_id.restimote(obj, trialId)
  line <- obj$goal_positions[iGoal,2:3]
  return(as.numeric(line))
}
get_point_goal_name.restimote<- function(obj, trialId){
  iGoal <- get_point_goal_id.restimote(obj, trialId)
  return(get_goal_name.restimote(obj, iGoal))
}
get_trial_point.restimote <- function(obj, trialId){
  get_trial_point_orientation.restimote(obj, trialId)
}
get_point_start_goal.restimote <- function(obj, trialId){
  ls <- list()
  ls$start <- get_point_start.restimote(obj, trialId)
  ls$goal <- get_point_goal.restimote(obj, trialId)
  return(ls)
}
# OTHER ----
get_goal_name.restimote <- function(obj, iGoal){
  line <- obj$goal_positions[iGoal, 1]
  return(as.character(line))
}
get_all_goal_positions.restimote <- function(obj, include_SOP = F){
  if(include_SOP){i <- 1:10} else {i <- 1:6}
  ls_goals <- setNames(split(obj$goal_positions[i, c(2,3)], i), obj$goal_positions$Name[i])
  return(ls_goals)
}