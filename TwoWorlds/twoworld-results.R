sop_trial_pointing <- function(obj, trialId){
  ls_pos <- get_trial_start_goal(obj, trialId)
  #when player points, trial ends so the point is at the trial end
  point_line <- get_trial_point.sop(obj, trialId)
  ls <- as.list(get_rotations(point_line))
  ls$correct_angle <- navr::angle_from_positions(ls_pos$start, ls_pos$goal)
  return(ls)
}