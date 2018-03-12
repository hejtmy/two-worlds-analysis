#X --get_trial_start_id
#X --get_trial_start
#X --get_trial_start_name
#X --get_trial_goal_id
#X --get_trial_goal
#X --get_trial_goal_name
#X --get_trial_start_goal
#X --get_point_start_id
#X --get_point_start_name
#X --get_point_start
#X --get_point_goal_id
#X --get_point_goal_name
#X --get_point_goal
#X --get_trial_point
#X --get_all_goal_positions

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
get_point_start_goal <- function(obj, trialId){
  UseMethod("get_point_start_goal")
}
get_all_goal_positions <- function(obj, include_SOP){
  UseMethod("get_all_goal_positions")
}
# Returns line when player pointed for unity, something else for REstimote
get_trial_point <- function(obj, trialId){
  UseMethod("get_trial_point")
}
get_trial_errors <- function(obj, trialId){
  UseMethod("get_trial_errors")
}
###Universal ----
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}

get_all_doors <- function(settings){
  i <- 1:nrow(settings$door_positions)
  ls_doors <- setNames(split(settings$door_positions[i, c(2,3)], i), as.character(settings$door_positions[i, 1][[1]]))
  return(ls_doors)
}
