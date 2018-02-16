source("TwoWorlds/helpers-results.R")

# GENERIC ----
sop_results <- function(obj){
  UseMethod("sop_results")
}
sop_trial_results <- function(obj, trialId){
  UseMethod("sop_trial_results")
}
learn_results <- function(obj){
  UseMethod("learn_results")
}
learn_trial_results <- function(obj, trialId){
  UseMethod("learn_results")
}
## UNITY ----
sop_results.twunity <- function(obj){
  df <- create_sop_df(obj$sop)
  for (trialId in 1:12){
    ls <- sop_trial_results.twunity(obj, trialId)
    df[trialId, "pointing_time"] <- ls$pointing_time
    df[trialId, "pointing_error"] <- ls$pointing_error
  }
  return(df)
}
sop_trial_results.twunity <- function(obj, trialId){
  return(sop_trial_results(obj$sop))
}
sop_trial_results.sop <- function(obj, trialId){
  UNITY_SHIFT <- -90 # WEIRD thing that the controller actually was transformed by this amout, so we need to input it back
  ls_pos <- get_trial_start_goal(obj, trialId)
  point_line <- get_trial_point.sop(obj, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$pointed_angle <- navr::angle_to_360(point_line$Rotation.Controller.x) + UNITY_SHIFT
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  ls$pointing_error <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  times <- get_trial_times(obj, trialId)
  ls$pointing_time <- times$finish - times$start
  return(ls)
}
learn_results.twunity <- function(obj){
  df_results <- create_learn_df(obj$learn)
  for (trialId in 1:18){
    ls <- learn_trial_results.twunity(obj, trialId)
    df_results[trialId, "trial_time"] <- ls$trial_time
    df_results[trialId, "trial_distance"] <- ls$trial_distance
  }
  return(df_results)
}
learn_trial_results.twunity <- function(obj, trialId){
  ls <- list()
  log <- get_trial_log(obj$learn, trialId)
  ls$trial_time <- diff(range(log$Time))
  ls$trial_distance <- diff(range(log$cumulative_distance))
  return(ls)
}
## RESTIMOTE ----
learn_results.restimote <- function(obj){
  df_results <- create_learn_df(obj)
  for (trialId in 1:18){
    ls <- learn_trial_results.restimote(obj, trialId)
    df_results[trialId, "trial_time"] <- ls$trial_time
    df_results[trialId, "trial_distance"] <- ls$trial_distance
  }
  df_results$trial_distance[df_results$trial_distance == 0] <- NA
  return(df_results)
}
learn_trial_results.restimote <- function(obj, trialId){
  log <- get_trial_log(obj, trialId)
  log_true <- true_trial_log(obj, trialId, 30, radius = 3)
  ls <- list()
  ls$trial_time <- diff(range(log$Time))
  ls$trial_distance <- sum(log_true$distance)
  return(ls)
}
sop_results.restimote <- function(obj){
  df_results <- create_sop_df(obj)
  for (trialId in 1:12){
    ls <- sop_trial_results.restimote(obj, trialId)
    df_results[trialId, "pointing_time"] <- ls$pointing_time
    df_results[trialId, "pointing_error"] <- ls$pointing_error
  }
  return(df_results)
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