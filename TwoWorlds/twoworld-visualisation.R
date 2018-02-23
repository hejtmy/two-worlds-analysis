# GENERICS ----
plot_sop_point <- function(obj, trialId){
  UseMethod("plot_sop_point")
}
plot_walk_trial <- function(obj, trialId){
  UseMethod("plot_walk_trial")
}
## UNITY ----
plot_walk_trial.twunity <- function(obj, trialId){
  plt <- navr::create_plot()
  dt <- get_trial_log(obj$walk, trialId)
  plt <- brainvr.R::add_limits(plt, obj$walk)
  plt <- navr::plot_add_path(plt, dt$Position.x, dt$Position.z)
  start_end <- get_trial_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, start_end, color = "green")
  return(plt)
}
plot_sop_point.twunity <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj$sop)
  plt <- add_goals(plt, obj$sop)
  plt <- plot_sop_point.general(plt, obj, trialId)
  return(plt)
}
## RESTIMOTE ----
plot_walk_trial.restimote <- function(obj, trialId){
  plt <- plot_true_trial_path(obj, trialId)
  plt <- add_building(plt)
  return(plt)
}
plot_sop_point.restimote <- function(obj, trialId){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, obj)
  plt <- add_building(plt)
  plt <- add_goals(plt, obj)
  plt <- plot_sop_point.general(plt, obj, trialId)
  return(plt)
}
## GENERAL ----
add_pointing_direction <- function(plt, obj, trialId){
  ls <- get_point_start_goal(obj, trialId)
  plt <- navr::plot_add_points(plt, ls, color = "red")
  pointings <- sop_trial_results(obj, trialId)
  plt <- navr::plot_add_direction(plt, ls$start, pointings$pointed_angle, color = "black", len = 4)
  plt <- navr::plot_add_direction(plt, ls$start, pointings$correct_angle, color = "green", len = 4)
  return(plt)
}
plot_sop_point.general <- function(plt, obj, trialId){
  plt <- add_pointing_direction(plt, obj, trialId)
  plt <- plt + theme_void()
  return(plt)
}
add_building <- function(plt, obj){
  plt <- plot_add_shape(plt, BUILDING_SHAPE$x, BUILDING_SHAPE$y, fill = NA, color = 'black')
  return(plt)
}
add_goals <- function(plt, obj){
  ls_goals <- get_all_goal_positions(obj, include_SOP = F)
  plt <- navr::plot_add_points(plt, ls_goals, color = "black")
  return(plt)
}
# plots all plots of certain ids given certain fuction
plot_all <- function(obj, ids, FUN){
  ls <- list()
  for(iTrial in ids){
    ls[[iTrial]] <- FUN(obj, iTrial)
  }
  plt <- navr::multiplot(ls, cols = 4)
  return(plt)
}



