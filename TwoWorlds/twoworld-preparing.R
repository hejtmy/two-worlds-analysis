preprocess_unity_log <- function(obj, dir){
  if(!is_player_preprocessed(obj$data$player_log)){
    obj$data$player_log <- preprocess_player_log(obj$data$player_log, "virtualizer")
    save_preprocessed_player(dir, obj$data$player_log, obj$timestamp)
  }
}

