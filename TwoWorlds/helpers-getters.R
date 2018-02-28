###Universal ----
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}

get_all_doors <- function(settings){
  i <- 1:nrow(settings$door_positions)
  ls_doors <- setNames(split(settings$door_positions[i, c(2,3)], i), as.character(settings$door_positions[i, 1][[1]]))
  return(ls_doors)
}
