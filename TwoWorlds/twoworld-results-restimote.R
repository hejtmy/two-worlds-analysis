## RESTIMOTE ----
walk_results.restimote <- function(obj){
  df_results <- create_walk_df(obj$participant_id)
  return(walk_results.general(obj, df_results))
}
walk_trial_results.restimote <- function(obj, trialId){
  ls <- list()
  ls$time <- get_trial_duration(obj, trialId, without_pauses = T)
  ls$distance <- get_trial_distance(obj, trialId, true_log = T, benevolence = 20, radius = 5)
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
  times <- get_trial_point_times.restimote(obj, trialId)
  ls_pos <- get_point_start_goal.restimote(obj, trialId)
  ls$pointed_angle <- get_trial_point.restimote(obj, trialId)
  ls$correct_angle <- navr::angle_from_positions(unlist(ls_pos$start), unlist(ls_pos$goal))
  ls$error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  ls$time <- times$end - times$start
  ls$start <- get_point_start_name.restimote(obj, trialId)
  ls$goal <- get_point_goal_name.restimote(obj, trialId)
  return(ls)
}