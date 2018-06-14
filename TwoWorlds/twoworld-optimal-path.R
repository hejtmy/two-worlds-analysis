calculate_optimal_path <- function(office1, office2){
  
}
prepare_thing <- function(){
  tw <- ls$tw148
  walk <- tw$phase1$walk
  
  goals <- get_all_goal_positions(walk, F)
  start_location <- get_trial_start.twunity(tw$phase1, 1)
  positions <- melt(goals)
  positions <- dcast(positions, L1 ~ variable, value.var = "value")
  positions <- rbind(positions, c("Start", start_location))
  colnames(positions) <- c('name', 'x', 'y')
  positions$x <- as.numeric(positions$x)
  positions$y <- as.numeric(positions$y)
  ls_positions <-  split(positions[,c(2:3)], seq(nrow(positions)))
  
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, BUILDING_LIMITS)
  plt <- navr::plot_add_points(plt, ls_positions, color = "green")
  plt <- add_building(plt)
  plt
  
}


plot_path <- function(points){
  plt <- navr::create_plot()
  plt <- brainvr.R::add_limits(plt, BUILDING_LIMITS)
  plt <- navr::plot_add_path(plt, points$x, points$y)
  start_end <- list(start = as.numeric(points[1,]), goal = as.numeric(points[nrow(points),]))
  plt <- navr::plot_add_points(plt, start_end, color = "green")
  plt <- add_building(plt)
  return(plt)
}

