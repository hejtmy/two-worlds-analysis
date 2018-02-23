###Universal ----
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}