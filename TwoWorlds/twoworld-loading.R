source('TwoWorlds/helpers-loading.R')

load_participant <- function(code, settings, dir){
  dirs <- list.dirs(dir)
  which_folder <- grep(paste0(".*", code, ".*"), dirs)
  if(length(which_folder) != 1){
    warning(paste0("No folder of code ", code, " in ", dir))
    return(NULL)
  }
  exp_folder <- dirs[which_folder]
  ls <- list()
  line <- get_participant_line(code, settings)
  if(is.null(line)) return(NULL)
  
  if(line$First.phase == "vr") ls$phase1 <- load_unity(exp_folder, line$LearnTimestamp1, line$SOPTimestamp1)
  if(line$First.phase == "real") ls$phase1 <- load_restimote(exp_folder, code, 1, settings)
  
  if(line$Second.phase == "vr") ls$phase2 <- load_unity(exp_folder, line$LearnTimestamp2, line$SOPTimestamp2)
  if(line$Second.phase == "real") ls$phase2 <- load_restimote(exp_folder, code, 2, settings)
  return(ls)
}


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
#' @param settings settings file from google sheets
#'
#' @return RestimoteObject
#'
#' @examples
load_restimote <- function(dir, code, phase, settings){
  restimoteObj <- load_restimote_log(dir)
  restimoteObj <- load_restimote_companion_log(dir, obj = restimoteObj)
  
  df_goal_pos <- settings$positions[, 1:3]
  
  restimoteObj <- add_goal_positions(restimoteObj, df_goal_pos)
  
  restimoteObj <- preprocess_companion_log(restimoteObj)
  restimoteObj <- preprocess_restimote_log(restimoteObj)
  
  restimoteObj$goal_order <- get_settings_order(code, "Learning", phase, settings)
  restimoteObj$pointing_location <- get_settings_order(code, "Viewpoint", phase, settings)
  restimoteObj$pointing_target <- get_settings_order(code, "Pointing", phase, settings)
  restimoteObj$map_limits <- list(x = c(-2, 30), y = c(-2, 30))
  return(restimoteObj)
  #add goal order
}

#' Loads all google sheets with settings and positions
#'
#' @return
#' @export
#'
#' @examples
load_google_sheets <- function(){
  ls <- list()
  ls$goal_order <- fetch_sheet("TW-GoalOrder", c("Learning", "Viewpoint", "Pointing"))
  settings <- fetch_sheet("TW-Participants", "Settings")
  ls$versions <- settings$Settings[!is.na(settings$Settings$Code),]
  positions <- fetch_sheet("TW-BuildingPositions", "Positions")
  ls$positions <- positions$Positions

  tw_questionnaire <- fetch_sheet('TW questionnaire (Responses)', 'Form Responses 1')
  tw_questionnaire <- tw_questionnaire$`Form Responses 1`
  tw_participants <- fetch_sheet('TW-Participants', 'Overview')
  tw_participants <- tw_participants$Overview
  ls$participants <- merge(tw_participants, tw_questionnaire, by = 'Code')
  
  colnames(ls$participants)[18:20] <- c("age", "weight", "hours_sleep")
  colnames(ls$participants)[44:45] <- c("sex", "ethnicity")
  
  return(ls)
}