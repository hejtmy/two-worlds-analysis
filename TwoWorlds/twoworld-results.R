source("TwoWorlds/helpers-results.R")

# GENERIC ----
sop_results <- function(obj){
  UseMethod("sop_results")
}
sop_trial_results <- function(obj){
  UseMethod("sop_trial_results")
}
learn_results <- function(obj){
  UseMethod("learn_results")
}
learn_trial_results <- function(obj){
  UseMethod("learn_results")
}
## UNITY ----
sop_results.twunity <- function(obj){
  df <- create_sop_df()
  for (iTrial in 1:N_POINTING){
    point <- sop_trial_pointing(obj, iTrial)
    times <- get_trial_times(obj, iTrial)
    df[iTrial, "pointing_time"] <- times$finish - times$start
    df[iTrial, "pointing_error"] <- point$pointing_error
  }
  return(df)
}
sop_trial_results.twunity <- function(obj, trialId){
  sop <- obj$sop
  # WEIRD thing that the controller actually was transformed by this amout, so we need to input it back
  UNITY_SHIFT <- -90
  ls_pos <- get_trial_start_goal(sop, trialId)
  #when player points, trial ends so the point is at the trial end
  point_line <- get_trial_point.sop(sop, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$pointed_angle <- navr::angle_to_360(point_line$Rotation.Controller.x) + UNITY_SHIFT
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  ls$pointing_error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  return(ls)
}
learn_results.twunity <- function(obj){
  df_results <- create_learn_df(obj$learn)
  for (iTrial in 1:18){
    ls <- learn_trial_results.twunity(obj)
    df_results[iTrial, "trial_time"] <- ls$trial_time
    df_results[iTrial, "trial_distance"] <- ls$trial_distance
  }
  return(df_results)
}
learn_trial_results.twunity <- function(obj){
  ls <- list()
  log <- get_trial_log(obj$learn, iTrial)
  ls$trial_time <- diff(range(log$Time))
  ls$trial_distance <- diff(range(log$cumulative_distance))
  return(ls)
}
## RESTIMOTE ----
learn_results.restimote <- function(obj){
  df_results <- create_learn_df()
  for (iTrial in 1:18){
    log <- get_trial_log(obj, iTrial)
    log_true <- true_trial_log(obj, iTrial, 30, radius = 3)
    df_results[iTrial, "trial_time"] <- diff(range(log$Time))
    df_results[iTrial, "trial_distance"] <- sum(log_true$distance)
  }
  df_results$trial_distance[df_results$trial_distance == 0] <- NA
  return(df_results)
}
sop_results.restimote <- function(obj){
  df_results <- create_sop_df(obj)
  for (iTrial in 1:N_POINTING){
    sop_results.restimote(obj, trialId)
    df[iTrial, "pointing_time"] <- ls$pointing_time
    df[iTrial, "pointing_error"] <- point$pointing_error
  }
  return(df)
}
sop_trial_results.restimote <- function(obj, trialId){
  ls <- list()
  times <- get_trial_point_times.restimote(obj, trialId)
  ls_pos <- get_sop_location_target.restimote(obj, trialId)
  ls$pointed_angle <- get_trial_point_orientation.restimote(obj, trialId)
  ls$correct_angle <- navr::angle_from_positions(unlist(ls_pos$location), unlist(ls_pos$target))
  ls$pointing_error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  ls$pointing_time <- times$end - times$start
  return(ls)
}
## GENERAL ----

# Expects restimote object


restimote_sop_trial_pointing <- function(obj, trialId){

}