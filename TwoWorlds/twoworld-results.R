sop_results <- function(obj){
  N_POINTING <- 12
  df <- data.frame(id = rep(obj$participant_id, N_POINTING), 
                   PointingTime = rep(NA, N_POINTING), 
                   PointingError = rep(NA, N_POINTING))
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