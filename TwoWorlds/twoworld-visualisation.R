# plots all plots of certain ids given certain fuction
plot_all <- function(obj, ids, FUN){
  ls <- list()
  for(iTrial in ids){
    ls[[iTrial]] <- FUN(obj, iTrial)
  }
  plt <- navr::multiplot(ls, cols = 4)
  return(plt)
}

plot_learning_trial <- function(obj, trialId){
  plt <- create_plot(obj)
  dt <- get_player_log_trial(obj, trialId)
  plt <- navr::plot_add_path(plt, dt)
  
  start_end <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, start_end)
  plt <- plt + theme_bw()
  plt
}

plot_sop_point.sop <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj)
  plt <- add_goals.twunity(plt, obj)
  plt <- add_pointing_direction.sop(plt, obj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}

plot_sop_point.restimote <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj)
  ls_goals <- get_all_goal_positions(obj)
  plt <- navr::plot_add_points(plt, ls_goals, color = "black")
  plt <- add_pointing_direction.restimote(plt, obj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}

add_goals.twunity <- function(plt, obj){
  ls_goals <- get_all_goal_positions(obj, include_SOP = F)
  plt <- navr::plot_add_points(plt, ls_goals, color = "black")
  return(plt)
}

add_goals.restimote <- function(plt, obj){
  ls_goals <- get_all_goal_positions(obj, include_SOP = F)
  plt <- navr::plot_add_points(plt, ls_goals, color = "black")
  return(plt)
}

add_pointing_direction.sop <- function(plt, obj, trialId){
  ls <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, ls, color = "red")
  pointings <- sop_trial_pointing(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$start,pointings$pointed_angle, color = "black", len = 10)
  plt <- navr::plot_add_direction(plt, ls$start, pointings$correct_angle, color = "green", len = 10)
  return(plt)
}

add_pointing_direction.restimote <- function(plt, obj, trialId){
  ls <- get_sop_location_target.restimote(obj, trialId)
  plt <- navr::plot_add_points(plt, ls, color = "red")
  pointings <- restimote_sop_trial_pointing(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$location, pointings$pointed_angle, color = "black", len = 10)
  plt <- navr::plot_add_direction(plt, ls$location, pointings$correct_angle, color = "green", len = 10)
  return(plt)
}

plot_restimote_path <- function(restimoteObj, trialId){
  plt <- restimoter::plot_trial_path(restimoteObj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}