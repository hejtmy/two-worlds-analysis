# plots all plots of certain ids given certain fuction
plot_all <- function(obj, ids, FUN){
  ls <- list()
  for(iTrial in ids){
    ls[[iTrial]] <- FUN(obj, iTrial)
  }
  plt <- navr::multiplot(ls, cols = 4)
  return(plt)
}

plot_trial.learn <- function(obj, trialId){
  plt <- navr::create_plot()
  dt <- get_trial_log(obj, trialId)
  plt <- navr::plot_add_path(plt, dt$Position.x, dt$Position.z)
  start_end <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, start_end, color = "green")
  return(plt)
}

plot_sop_point.sop <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj)
  plt <- add_goals(plt, obj$sop)
  plt <- add_pointing_direction.sop(plt, obj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}

plot_sop_point.restimote <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj)
  plt <- add_goals(plt, obj)
  plt <- add_pointing_direction.restimote(plt, obj, trialId)
  plt <- plt + theme_bw()
  return(plt)
}

add_goals <- function(plt, obj){
  ls_goals <- get_all_goal_positions(obj, include_SOP = F)
  plt <- navr::plot_add_points(plt, ls_goals, color = "black")
  return(plt)
}

add_pointing_direction.twunity <- function(plt, obj, trialId){
  ls <- get_trial_start_goal(obj$obj, trialId)
  plt <- navr::plot_add_points(plt, ls, color = "red")
  pointings <- sop_trial_results(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$start,pointings$pointed_angle, color = "black", len = 20)
  plt <- navr::plot_add_direction(plt, ls$start, pointings$correct_angle, color = "green", len = 20)
  return(plt)
}

add_pointing_direction.restimote <- function(plt, obj, trialId){
  ls <- get_sop_location_target.restimote(obj, trialId)
  plt <- navr::plot_add_points(plt, ls, color = "red")
  pointings <- sop_trial_results(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$location, pointings$pointed_angle, color = "black", len = 4)
  plt <- navr::plot_add_direction(plt, ls$location, pointings$correct_angle, color = "green", len = 4)
  return(plt)
}