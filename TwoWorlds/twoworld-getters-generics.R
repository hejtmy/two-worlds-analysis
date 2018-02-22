### GENERIC DEFINITIONS ---------
get_goal <- function(obj, goal_id){
  UseMethod("get_goal")
}
get_trial_start_id <- function(obj, trialId){
  UseMethod("get_trial_start_id")
}
get_trial_start <- function(obj, trialId){
  UseMethod("get_trial_start")
}
get_trial_start_name <- function(obj, trialId){
  UseMethod("get_trial_start_name")
}
get_trial_goal_id <- function(obj, trialId){
  UseMethod("get_trial_goal_id")
}
get_trial_goal <- function(obj, trialId){
  UseMethod("get_trial_goal")
}
get_trial_goal_name <- function(obj, trialId){
  UseMethod("get_trial_goal_name")
}
get_trial_start_goal <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}
get_point_start_id <- function(obj, trialId){
  UseMethod("get_point_start_id")
}
get_point_start_name <- function(obj, trialId){
  UseMethod("get_point_start_name")
}
get_point_start <- function(obj, trialId){
  UseMethod("get_point_start")
}
get_point_goal_id <- function(obj, trialId){
  UseMethod("get_point_goal_id")
}
get_point_goal_name <- function(obj, trialId){
  UseMethod("get_point_goal_name")
}
get_point_goal <- function(obj, trialId){
  UseMethod("get_point_goal")
}
get_all_goal_positions <- function(obj, include_SOP){
  UseMethod("get_all_goal_positions")
}
# Returns line when player pointed for unity, something else for REstimote
get_trial_point <- function(obj, trialId){
  UseMethod("get_trial_point")
}