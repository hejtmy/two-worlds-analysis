source('TwoWorlds/helpers-loading.R')
#' Title
#'
#' @param dir where to search for the unity logs
#' @param learn_timestamp what timestamp does the learning part have
#' @param sop_timestamp what timestamp does the sop task have
#'
#' @return list with learn and sop brainvr objects
#'
#' @examples
load_unity <- function(dir, learn_timestamp, sop_timestamp){
  learn <- load_experiment(dir, exp_timestamp = learn_timestamp)
  class(learn) <- append(class(learn), c("learn", "twunity"))
  sop <- load_experiment(dir, exp_timestamp = sop_timestamp)
  class(sop) <- append(class(sop), c("sop", "twunity"))
  
  learn <- preprocess_unity_log(learn, dir)
  sop <- preprocess_unity_log(sop, dir)
  learn <- transform_unity_coordinates(learn)
  sop <- transform_unity_coordinates(sop)
  
  learn$map_limits <- list(x = c(-5, 105), y = c(-5, 105))
  sop$map_limits <- list(x = c(-5, 105), y = c(-5, 105))
  return(list(learn = learn, sop = sop))
}

#' Title
#'
#' @param dir directory witht he log
#' @param df_goal_pos data frame with goal positions
#'
#' @return RestimoteObject
#'
#' @examples
load_restimote <- function(dir, df_goal_pos){
  restimoteObj <- load_restimote_log(dir)
  restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)
  
  restimoteObj <- add_goal_positions(restimoteObj, df_goal_pos)
  
  restimoteObj <- preprocess_companion_log(restimoteObj)
  restimoteObj <- preprocess_restimote_log(restimoteObj)
  
  restimoteObj$map_limits <- list(x = c(-2, 27), y = c(-2, 27))
  return(restimoteObj)
  #add goal order
}

load_google_sheets <- function(){
  ls <- list()
  goal_order <- "TW-GoalOrder"
  sheets_goal_order <- c("Learning", "Viewpoint", "Pointing")
  ls$goal_order <- fetch_sheet(goal_order, sheets_goal_order)
  participants <- "TW-Participants"
  sheets_participants <- c("Settings")
  ls$participants <- fetch_sheet(goal_order, sheets_participants)
  return(ls)
}
