preprocess_unity_log <- function(obj, dir){
  if(!is_player_preprocessed(obj$data$player_log)){
    obj$data$player_log <- preprocess_player_log(obj$data$player_log)
    save_preprocessed_player(dir, obj$data$player_log, obj$timestamp)
  }
  return(obj)
}

transform_unity_coordinates <- function(obj){
  obj <- mirror_axes(obj)
  obj <- translate_positions(obj, c(33.5, 0, 47.75))
  obj <- resize_layout(obj, 1/4)
  return(obj)
}

smooth_unity_log <- function(obj){
  obj <- brainvr.R::smooth_positions.brainvr(obj, "median", points = 201)
  return(obj)
}