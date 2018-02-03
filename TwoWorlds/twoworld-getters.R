### GENERIC DEFINITIONS ---------
get_goal <- function(obj, goal_id){
  UseMethod("get_goal")
}
get_trial_start <- function(obj, trialId){
  UseMethod("get_trial_start")
}

get_trial_goal <- function(obj, trialId){
  UseMethod("get_trial_goal")
}

get_trial_goal_id <- function(obj, trialId){
  UseMethod("get_trial_goal_id")
}

get_trial_goal_name <- function(obj, trialId){
  UseMethod("get_trial_goal_name")
}

get_trial_start_goal <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}
get_all_goal_positions <- function(obj, include_SOP){
  UseMethod("get_all_goal_positions")
}
# Returns line when player pointed for unity, something else for REstimote
get_trial_point <- function(obj, trialId){
  UseMethod("get_trial_point")
}
### twunity ---------
get_goal.twunity <- function(obj, goal_id){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[goal_id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}
get_trial_goal.twunity <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal(obj, goal_id))
}
get_trial_goal_name.twunity <- function(obj, trialId){
  id <- get_trial_goal_id(obj, trialId)
  return(obj$data$experiment_log$settings$GoalNames[id])
}
get_trial_start_goal.twunity <- function(obj, trialId){
  start <- get_trial_start(obj, trialId)
  goal <- get_trial_goal(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}
get_all_goal_positions.twunity <- function(obj, include_SOP = FALSE){
  if(include_SOP){i <- 1:10}else{i <- 1:6}
  ls_goals <- setNames(split(obj$data$experiment_log$positions$GoalPositions[i, c(1,3)], i), i)
  return(ls_goals)
}
### learn ------
get_trial_goal_id.learn <- function(obj, trialId){
  # C# indexes from 0
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId]
  return(goal_id + 1)
}
get_trial_start.learn <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal(obj, trialId - 1))
}
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
get_trial_point.sop <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end, but because of unity timing
  #sometimes logged after trial finishes
  log <- get_trial_log(obj, trialId)
  point_line <- tail(log, 1)
  return(point_line)
}
### RESTIMOTE ----------
get_start.restimote <- function(obj, trialId){
  return(restimoter::get_start_position(obj, trialId))
}
get_goal.restimote <- function(obj, trialId){
  return(restimoter::get_goal_position(obj, trialId))
}
get_trial_point.restimote <- function(obj, trialId){
  
}
###Universal ----
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}