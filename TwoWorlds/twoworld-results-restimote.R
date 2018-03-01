## RESTIMOTE ----
walk_results.restimote <- function(obj){
  df_results <- create_walk_df(obj$participant_id)
  return(walk_results.general(obj, df_results))
}
walk_trial_results.restimote <- function(obj, trialId){
  log <- get_trial_log(obj, trialId)
  log_true <- true_trial_log(obj, trialId, 30, radius = 3)
  ls <- list()
  ls$time <- restimoter::get_trial_duration(obj, trialId, without_pauses = T)
  ls$distance <- sum(log_true$distance)
  ls$start <- get_trial_start_name.restimote(obj, trialId)
  ls$goal <- get_trial_goal_name.restimote(obj, trialId)
  ls$errors <- get_trial_errors.restimote(obj, trialId)
  return(ls)
}
sop_results.restimote <- function(obj){
  df_results <- create_sop_df(obj$participant_id)
  return(sop_results.general(obj, df_results))
}
sop_trial_results.restimote <- function(obj, trialId){
  ls <- list()
  ls_pos <- get_point_start_goal.restimote(obj, trialId)
  ls$pointed_angle <- get_trial_point.restimote(obj, trialId)
  ls$correct_angle <- navr::angle_from_positions(unlist(ls_pos$start), unlist(ls_pos$goal))
  ls$error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  ls$time <- restimoter::get_trial_duration(obj, trialId, without_pauses = F)
  ls$start <- get_point_start_name.restimote(obj, trialId)
  ls$goal <- get_point_goal_name.restimote(obj, trialId)
  return(ls)
}