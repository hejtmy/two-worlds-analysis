plot_learning_trial <- function(obj, trialId){
  plt <- create_plot(obj)
  dt <- get_player_log_trial(obj, trialId)
  plt <- navr::plot_add_path(plt, dt)
  
  start_end <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, start_end)
  plt <- plt + theme_bw()
  plt
}

plot_sop_points <- function(obj, trialIds){
  plt <- navr::create_plot(obj)
  for(id in trialIds){
    plt <- navr::add_pointing_direction(plt, obj, id)
  }
  plt <- plt + theme_bw()
  return(plt)
}

plot_sop_point <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- add_pointing_direction.sop(plt, obj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}

add_pointing_direction.sop <- function(plt, obj, trialId){
  ls <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, ls)
  pointings <- sop_trial_pointing(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$start,pointings$pointed_angle, color = "black", len = 10)
  plt <- navr::plot_add_direction(plt, ls$start, pointings$correct_angle, color = "green", len = 10)
  return(plt)
}

plot_restimote_path <- function(restimoteObj, trialId){
  plt <- restimoter::plot_trial_path(restimoteObj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}