build_directions_df <- function(position, angles, types = "UNDEFINED"){
  n <- length(angles)
  direction_df <- data.frame(x = rep(position[1], n), y = rep(position[2], n), 
                             angle = angles, length = 1, type = types)
  return(direction_df)
}