plot_learning_trial <- function(obj, trialId){
  plt <- create_plot(obj)
  dt <- get_player_log_trial(obj, trialId)
  plt <- plot_add_player_path(plt, dt)
  
  start_end <- get_trial_start_goal_pos(obj, trialId)
  plt <- plot_add_points(plt, start_end)
  plt
}