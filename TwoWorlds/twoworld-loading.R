load_all <- function(settings, dir, select = NULL, only_ok = TRUE){
  ls <- list()
  if(only_ok){
    finished <- settings$versions[settings$versions$finished == "yes" & (settings$versions$is_ok == "yes" & !is.na(settings$versions$is_ok)), "Code"][[1]]
  } else {
    finished <- settings$versions[settings$versions$finished == "yes", "Code"][[1]]
  }
  if(!is.null(select)) finished <- finished[select]
  for(i in 1:length(finished)){
    code <- finished[i]
    print(paste0("Loading participant ", i,  " with code ", code))
    ls[[code]] <- load_participant(code, settings, dir)
    print("Finished")
    print("----------------------------")
  }
  return(ls)
}

#' Loads complete participant using directory and code
#'
#' @param code 
#' @param settings 
#' @param dir 
#'
#' @return
#' @export
#'
#' @examples
load_participant <- function(code, settings, dir){
  dirs <- list.dirs(dir)
  which_folder <- grep(paste0(".*", code, "[_].*"), dirs)
  if(length(which_folder) != 1){
    warning(paste0("No folder of code ", code, " in ", dir))
    return(NULL)
  }
  exp_folder <- dirs[which_folder]
  ls <- list()
  line <- get_participant_line(code, settings)
  if(is.null(line)) return(NULL)
  
  if(line$First.phase %in% c("vr", "ve")) ls$phase1 <- load_unity(exp_folder, line$WalkTimestamp1, line$SOPTimestamp1)
  if(line$First.phase == "real") ls$phase1 <- load_restimote(exp_folder, code, line$WalkTimestamp1, 1, settings)
  
  if(line$Second.phase %in% c("vr", "ve")) ls$phase2 <- load_unity(exp_folder, line$WalkTimestamp2, line$SOPTimestamp2)
  if(line$Second.phase == "real") ls$phase2 <- load_restimote(exp_folder, code, line$WalkTimestamp2, 2, settings)
  return(ls)
}

#' Loads unity logs
#'
#' @param dir where to search for the unity logs
#' @param walk_timestamp what timestamp does the walking part have
#' @param sop_timestamp what timestamp does the sop task have
#'
#' @return list with walk and sop brainvr objects
#'
#' @examples
load_unity <- function(dir, walk_timestamp, sop_timestamp){
  walk <- load_experiment(dir, exp_timestamp = walk_timestamp)
  class(walk) <- append(class(walk), c("walk"))
  sop <- load_experiment(dir, exp_timestamp = sop_timestamp)
  class(sop) <- append(class(sop), c("sop"))
  
  walk <- preprocess_unity_log(walk, dir)
  sop <- preprocess_unity_log(sop, dir)
  
  # messes up Y rotation axis - looking up and down
  walk <- transform_unity_coordinates(walk)
  sop <- transform_unity_coordinates(sop)
  
  walk$map_limits <- BUILDING_LIMITS
  sop$map_limits <- BUILDING_LIMITS
  
  # smooths walking
  walk <- smooth_unity_log(walk)
  
  ls <- list(walk = walk, sop = sop)
  
  class(ls) <-  append(class(ls), "twunity")
  return(ls)
}

#' Loads restimote 
#'
#' @param dir directory witht he log
#' @param settings settings file from google sheets
#' @param code 
#' @param exp_timestamp 
#' @param phase 
#'
#' @return RestimoteObject
#'
#' @examples
load_restimote <- function(dir, code, exp_timestamp = NULL, phase, settings){
  restimoteObj <- load_restimote_log(dir, exp_timestamp = exp_timestamp)
  restimoteObj <- load_restimote_companion_log(dir, exp_timestamp = exp_timestamp, obj = restimoteObj)
  
  df_goal_pos <- settings$goal_positions[, 1:3]
  
  restimoteObj <- add_goal_positions(restimoteObj, df_goal_pos)
  
  restimoteObj <- preprocess_companion_log(restimoteObj)
  restimoteObj <- preprocess_restimote_log(restimoteObj)
  
  restimoteObj <- calibrate_compass(restimoteObj, 333)
  restimoteObj$participant_id <- code
  restimoteObj$goal_order <- get_settings_order(code, "Walking", phase, settings)
  restimoteObj$pointing_location <- get_settings_order(code, "Viewpoint", phase, settings)
  restimoteObj$pointing_target <- get_settings_order(code, "Pointing", phase, settings)
  restimoteObj$map_limits <- BUILDING_LIMITS
  
  ### WARNINGS
  if(restimoteObj$n_trials != 18) warning(paste0(code, " in phase ", phase, " has ", restimoteObj$n_trials, " instead of 18 trials"))
  n_pointings <- get_n_pointings(restimoteObj)
  if (n_pointings$log != 14) warning(paste0(code, " in phase ", phase, " has ", n_pointings$log, " instead of 14 pointings in player log"))
  if (n_pointings$companion != 12) warning(paste0(code, " in phase ", phase," has ", n_pointings$companion, " instead of 12 should point in companion log"))
  
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
  ls$goal_order <- fetch_sheet("TW-GoalOrder", c("Walking", "Viewpoint", "Pointing"))
  settings <- fetch_sheet("TW-Participants", "Settings")
  ls$versions <- settings$Settings[!is.na(settings$Settings$Code),]
  positions <- fetch_sheet("TW-BuildingPositions", c("GoalPositions", "AllDoors"))
  ls$goal_positions <- positions$GoalPositions
  ls$door_positions <- positions$AllDoors
  
  tw_questionnaire <- fetch_sheet('TW questionnaire (Responses)', 'Form Responses 1')
  tw_questionnaire <- tw_questionnaire$`Form Responses 1`
  tw_participants <- fetch_sheet('TW-Participants', 'Overview')
  tw_participants <- tw_participants$Overview
  ls$participants <- merge(tw_participants, tw_questionnaire, by = 'Code')
  colnames(ls$participants)[18:45] <- c("age", "weight", "hours_sleep", 
                                        "last_eaten", "video_game_experience", 
                                        "vr_experience", "motion_sickness", 
                                        "dizzy_history", "stress_level", "stressors", 
                                        "general_discomfort", "fatigue", "headache", 
                                        "eye_strain", "focus_difficulty", "salivation", 
                                        "sweating", "nausea", "concentrate_difficulty", 
                                        "full_head", "blurred_vision", "dizzy_eyes_open", 
                                        "dizzy_eyes_closed", "vertigo", 
                                        "stomach_awareness", "burping", "sex", "ethnicity")
  
  return(ls)
}