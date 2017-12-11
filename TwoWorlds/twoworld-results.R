sop_trial_pointing <- function(obj, trialId){
  ls_pos <- get_trial_start_point_pos(obj, trialId)
  #when player points, trial ends so the point is at the trial end
  dt_player <- get_player_log_trial(obj, trialId)
  point_line <- tail(dt_player, 1)
  ls <- as.list(get_rotations(point_line))
  ls$correct_angle <- brainvr.R::angle_from_positions(ls_pos$start, ls_pos$point)
  return(ls)
}