source("TwoWorlds/helpers-results.R")

unity_results <- function(obj){
  
}

# Expects brainvr learn object
learn_results.brainvr <- function(obj){
  df <- create_learn_df()
  for (iTrial in 1:18){
    log <- get_trial_log(obj, iTrial)
    df[iTrial, "TrialTime"] <- diff(range(log$Time))
    df[iTrial, "TrialLength"] <- diff(range(log$cumulative_distance))
  }
  return(df)
}

# Expects restimote object
learn_results.restimote <- function(obj){
  df <- create_learn_df()
  for (iTrial in 1:18){
    log <- get_trial_log(obj, iTrial)
    log_true <- true_trial_log(obj, iTrial, 30, radius = 3)
    df[iTrial, "TrialTime"] <- diff(range(log$Time))
    df[iTrial, "TrialLength"] <- sum(log_true$distance)
  }
  df$TrialLength[df$TrialLength == 0] <- NA
  return(df)
}

sop_results <- function(obj){
  df <- create_sop_df()
  for (iTrial in 1:N_POINTING){
    point <- sop_trial_pointing(obj, iTrial)
    times <- get_trial_times(obj, iTrial)
    df[iTrial, "PointingTime"] <- times$finish - times$start
    df[iTrial, "PointingError"] <- point$angle_difference
  }
  return(df)
}

sop_trial_pointing <- function(obj, trialId){
  # WEIRD thing that the controller actually was transformed by this amout, so we need to input it back
  UNITY_SHIFT <- -90
  ls_pos <- get_trial_start_goal(obj, trialId)
  #when player points, trial ends so the point is at the trial end
  point_line <- get_trial_point.sop(obj, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$pointed_angle <- navr::angle_to_360(point_line$Rotation.Controller.x) + UNITY_SHIFT
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  ls$angle_difference <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  return(ls)
}

restimote_sop_results <- function(obj){
  N_POINTING <- 11
  df <- data.frame(id = rep(obj$participant_id, N_POINTING), 
                   PointingTime = rep(NA, N_POINTING), 
                   PointingError = rep(NA, N_POINTING))
  for (iTrial in 1:N_POINTING){
    point <- restimote_sop_trial_pointing(obj, iTrial)
    times <- get_trial_point_times(obj, iTrial)
    df[iTrial, "PointingTime"] <- times$end - times$start
    df[iTrial, "PointingError"] <- point$angle_difference
  }
  return(df)
}

restimote_sop_trial_pointing <- function(obj, trialId){
  ls_pos <- get_sop_location_target.restimote(obj, trialId)
  point_line <- get_trial_point_orientation(obj, trialId)
  ls <- list()
  ls$pointed_angle <- point_line$Orientation
  ls$correct_angle <- navr::angle_from_positions(unlist(ls_pos$location), unlist(ls_pos$target))
  ls$angle_difference <- navr::angle_to_180(ls$correct_angle - ls$pointed_angle)
  return(ls)
}