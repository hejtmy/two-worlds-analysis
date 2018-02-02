load_unity <- function(dir, learn_timestamp, sop_timestamp){
  learn <- load_experiment(dir, exp_timestamp = learn_timestamp)
  class(learn) <- append(class(learn), c("twunity", "learn"))
  sop <- load_experiment(dir, exp_timestamp = sop_timestamp)
  class(sop) <- append(class(sop), c("twunity", "sop"))
  
  learn <- preprocess_unity_log(learn, dir)
  sop <- preprocess_unity_log(sop, dir)
  learn <- transform_unity_coordinates(learn)
  sop <- transform_unity_coordinates(sop)
  
  learn$map_limits <- list(x = c(-5, 105), y = c(-5, 105))
  sop$map_limits <- list(x = c(-5, 105), y = c(-5, 105))
  return(list(learn = learn, sop = sop))
}
