### twunity ----
get_trial_start_id.twunity <- function(obj, trialId){
  if(trialId == 1) return(NULL)
  return(get_trial_goal_id.twunity(obj, trialId - 1))
}
get_trial_start.twunity <- function(obj, trialId){
  #First trial is started in a center hall
  iStart <- get_trial_start_id.twunity(obj, trialId)
  if(is.null(iStart)){
    df_firs_pos <- obj$walk$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_goal.brainvr(obj$walk, iStart))
}
get_trial_start_name.twunity <- function(obj, trialId){
  iStart <- get_trial_start_id.twunity(obj, trialId)
  if(is.null(iStart)) return("Starting location")
  return(get_goal_name.brainvr(obj$walk, iStart))
}
get_trial_goal_id.twunity <- function(obj, trialId){
  iGoal <- obj$walk$data$experiment_log$settings$GoalOrder[trialId]
  return(iGoal + 1) #C# indexes from 0
}
get_trial_goal.twunity <- function(obj, trialId){
  iGoal <- get_trial_goal_id.twunity(obj, trialId)
  return(get_goal.brainvr(obj$walk, iGoal))
}
get_trial_goal_name.twunity <- function(obj, trialId){
  iGoal <- get_trial_goal_id.twunity(obj, trialId)
  return(get_goal_name.brainvr(obj$walk, iGoal))
}
get_trial_start_goal.twunity <- function(obj, trialId){
  start <- get_trial_start.twunity(obj, trialId)
  goal <- get_trial_goal.twunity(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}
get_trial_errors.twunity <- function(obj, trialId){
  #gets_log
  DIAMETER <- 0.52
  ALL_DOORS_POSITIONS <- settings$door_positions #a bit problmatic, fethces stuff from the global env
  n_errors <- -2 # we will get one correct hit at the goal start and end
  df_log <- get_trial_log(obj$walk, trialId)
  df_positions <- df_log[,c('Position.x', 'Position.z')]
  for(i in 1:nrow(ALL_DOORS_POSITIONS)){
    position <- c(ALL_DOORS_POSITIONS$Estimote.x[i], ALL_DOORS_POSITIONS$Estimote.y[i])
    diffs <- sweep(df_positions, 2, position)
    distances <- apply(diffs, 1, function(x){sqrt(sum(x ^ 2))})
    if(any(distances < DIAMETER)) n_errors <- n_errors + 1
  }
  return(n_errors)
}
## SOP ----
get_point_start_id.twunity <- function(obj, trialId){
  iStart <- obj$sop$data$experiment_log$settings$GoalOrder[trialId]
  return(iStart + 1)
}
get_point_start_name.twunity <- function(obj, trialId){
  iStart <- get_point_start_id.twunity(obj, trialId)
  return(paste0("Viewpoint ", iStart - 6))
}
get_point_start.twunity <- function(obj, trialId){
  iStart <- get_point_start_id.twunity(obj, trialId)
  return(get_goal.brainvr(obj$sop, iStart))
}
get_point_goal_id.twunity <- function(obj, trialId){
  iGoal <- obj$sop$data$experiment_log$settings$GoalPointOrder[trialId]
  return(iGoal + 1)
}
get_point_goal_name.twunity <- function(obj, trialId){
  iGoal <- get_point_goal_id.twunity(obj, trialId)
  return(get_goal_name.brainvr(obj$sop, iGoal))
}
get_point_goal.twunity <- function(obj, trialId){
  iGoal <- get_point_goal_id.twunity(obj, trialId)
  return(get_goal.brainvr(obj$sop, iGoal))
}
get_point_start_goal.twunity <- function(obj, trialId){
  start <- get_point_start.twunity(obj, trialId)
  goal <- get_point_goal.twunity(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}
get_trial_point.twunity <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end, but because of unity timing
  #sometimes logged after trial finishes
  log <- get_trial_log(obj$sop, trialId)
  point_line <- tail(log, 1)
  return(point_line)
}
get_all_goal_positions.twunity <- function(obj, include_SOP){
  return(get_all_goal_positions.brainvr(obj$sop, include_SOP))
}
### BrainVR ----
get_goal.brainvr <- function(obj, iGoal){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[iGoal, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}
get_goal_name.brainvr <- function(obj, iGoal){
  return(obj$data$experiment_log$settings$GoalNames[iGoal])
}
get_all_goal_positions.brainvr <- function(obj, include_SOP = FALSE){
  if(include_SOP){i <- 1:10}else{i <- 1:6}
  ls_goals <- setNames(split(obj$data$experiment_log$positions$GoalPositions[i, c(1,3)], i), obj$data$experiment_log$settings$GoalNames[i])
  return(ls_goals)
}
get_point_start.sop <- function(obj, trialId){
  
}