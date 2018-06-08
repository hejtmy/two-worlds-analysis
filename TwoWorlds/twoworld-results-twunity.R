## UNITY ----
walk_results.twunity <- function(obj){
  df_results <- create_walk_df(obj$walk$participant_id)
  return(walk_results.general(obj, df_results))
}
walk_trial_results.twunity <- function(obj, trialId){
  ls <- list()
  log <- get_trial_log(obj$walk, trialId)
  ls$time <- get_trial_duration(obj$walk, trialId, without_pauses = F)
  ls$distance <- diff(range(log$cumulative_distance))
  ls$start <- get_trial_start_name.twunity(obj, trialId)
  ls$goal <- get_trial_goal_name.twunity(obj, trialId)
  ls$errors <- get_trial_errors.twunity(obj, trialId)
  return(ls)
}
sop_results.twunity <- function(obj){
  df_results <- create_sop_df(obj$sop$participant_id)
  return(sop_results.general(obj, df_results))
}
sop_trial_results.twunity <- function(obj, trialId){
  ls_pos <- get_point_start_goal(obj, trialId)
  point_line <- get_trial_point(obj, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$pointed_angle <- ifelse("Rotation.Controller.x" %in% colnames(point_line), get_pointed_angle.vr(point_line), get_pointed_angle.ve(point_line))
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  ls$error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  ls$time <- get_trial_duration(obj$sop, trialId, without_pauses = F)
  ls$start <- get_point_start_name(obj, trialId)
  ls$goal <- get_point_goal_name(obj, trialId)
  return(ls)
}
get_pointed_angle.vr <- function(point_line){
  UNITY_SHIFT <- -90 # WEIRD thing that the controller actually was transformed by this amout, so we need to input it back
  pointed_angle <- navr::angle_to_360(point_line$Rotation.Controller.x) + UNITY_SHIFT
  return(pointed_angle)
  
}
get_pointed_angle.ve <- function(point_line){
  navr::angle_to_360(point_line$Rotation.X)
}