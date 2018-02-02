preprocess_unity_log <- function(obj, dir){
  if(!is_player_preprocessed(obj$data$player_log)){
    obj$data$player_log <- preprocess_player_log(obj$data$player_log, "virtualizer")
    save_preprocessed_player(dir, obj$data$player_log, obj$timestamp)
  }
  return(obj)
}

transform_unity_coordinates <- function(obj){
  obj <- mirror_axes(obj)
  obj <- translate_positions(obj, c(33.5, 0, 47.75))
  return(obj)
}