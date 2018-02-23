### Walk ----------
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

## SOP ----

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