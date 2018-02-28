# GENERIC ----
sop_results <- function(obj){
  UseMethod("sop_results")
}
sop_trial_results <- function(obj, trialId){
  UseMethod("sop_trial_results")
}
walk_results <- function(obj){
  UseMethod("walk_results")
}
walk_trial_results <- function(obj, trialId){
  UseMethod("walk_trial_results")
}
## UNITY ----
walk_results.twunity <- function(obj){
  df_results <- create_walk_df(obj$walk$participant_id)
  return(walk_results.general(obj, df_results))
}
walk_trial_results.twunity <- function(obj, trialId){
  ls <- list()
  log <- get_trial_log(obj$walk, trialId)
  ls$time <- diff(range(log$Time))
  ls$distance <- diff(range(log$cumulative_distance))
  ls$start <- get_trial_start_name.twunity(obj, trialId)
  ls$goal <- get_trial_goal_name.twunity(obj, trialId)
  return(ls)
}
sop_results.twunity <- function(obj){
  df_results <- create_sop_df(obj$sop$participant_id)
  return(sop_results.general(obj, df_results))
}
sop_trial_results.twunity <- function(obj, trialId){
  UNITY_SHIFT <- -90 # WEIRD thing that the controller actually was transformed by this amout, so we need to input it back
  ls_pos <- get_point_start_goal(obj, trialId)
  point_line <- get_trial_point(obj, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$pointed_angle <- navr::angle_to_360(point_line$Rotation.Controller.x) + UNITY_SHIFT
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  ls$error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  times <- get_trial_times(obj$sop, trialId)
  ls$time <- times$finish - times$start
  ls$start <- get_point_start_name(obj, trialId)
  ls$goal <- get_point_goal_name(obj, trialId)
  return(ls)
}
## RESTIMOTE ----
walk_results.restimote <- function(obj){
  df_results <- create_walk_df(obj$participant_id)
  return(walk_results.general(obj, df_results))
}
walk_trial_results.restimote <- function(obj, trialId){
  log <- get_trial_log(obj, trialId)
  log_true <- true_trial_log(obj, trialId, 30, radius = 3)
  ls <- list()
  ls$time <- diff(range(log$Time)) 
  ls$distance <- sum(log_true$distance)
  ls$start <- get_trial_start_name.restimote(obj, trialId)
  ls$goal <- get_trial_goal_name.restimote(obj, trialId)
  ls$errors <- get_trial_n_actions(obj, trialId, "Wrong door")
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
# GENERAL ----
sop_results.general <- function (obj, df_results){
  for (trialId in 1:12){
    ls <- sop_trial_results(obj, trialId)
    df_results <- list_to_row(df_results, ls, trialId)
  }
  return(df_results)
}
walk_results.general <- function(obj, df_results){
  for (trialId in 1:18){
    ls <- walk_trial_results(obj, trialId)
    df_results <- list_to_row(df_results, ls, trialId)
  }
  df_results$distance[df_results$distance == 0] <- NA
  return(df_results)
}