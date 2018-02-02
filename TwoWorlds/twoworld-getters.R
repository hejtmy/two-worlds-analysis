### GENERIC DEFINITIONS ---------
get_goal <- function(obj, goal_id){
  UseMethod("get_goal")
}
get_trial_start <- function(obj, trialId){
  UseMethod("get_trial_start")
}

get_trial_goal <- function(obj, trialId){
  UseMethod("get_trial_goal")
}

get_trial_goal_id <- function(obj, trialId){
  UseMethod("get_trial_goal_id")
}

get_trial_goal_name <- function(obj, trialId){
  UseMethod("get_trial_goal_name")
}

get_trial_start_goal <- function(obj, trialId){
  UseMethod("get_trial_start_goal")
}

get_trial_pointing <- function(obj, trialId){
  
}
### twunity ---------
get_goal.twunity <- function(obj, goal_id){
  goal_pos <- obj$data$experiment_log$positions$GoalPositions[goal_id, ]
  return(c(goal_pos$Position.x, goal_pos$Position.z))
}
get_trial_goal_id.twunity <- function(obj, trialId){
  # C# indexes from 0
  goal_id <- obj$data$experiment_log$settings$GoalOrder[trialId]
  return(goal_id + 1)
}
get_trial_goal.twunity <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal(obj, goal_id))
}
get_trial_start.twunity <- function(obj, trialId){
  goal_id <- get_trial_goal_id(obj, trialId)
  return(get_goal(obj, goal_id))
}
get_trial_goal_name.twunity <- function(obj, trialId){
  id <- get_trial_goal_id(obj, trialId)
  return(obj$data$experiment_log$settings$GoalNames[id])
}
get_trial_start_goal.twunity <- function(obj, trialId){
  start <- get_trial_start(obj, trialId)
  goal <- get_trial_goal(obj, trialId)
  ls <- list(start = start, goal = goal)
  return(ls)
}
#' Returns pointing direction during given trial. If there are more than two pointings, selects the first one
#' If target position is passed, also returnes what should have been the correct pointing angle
#' @param obj BrainvrObject
#' @param target_pos vector 2 of target position
#' @noRd
get_trial_pointing.twunity <- function(obj, trialId, target_pos = NULL){
  ls <- list()
  quest_log <- get_trial_log(obj, trialId)
  point_situation <- quest_log[Input == "Point", ]
  ls$target <- NA
  if(nrow(point_situation) < 1){
    print(paste0("Warning", "get_trial_pointing", "no point event found"))
    ls$time <- NA
    ls$chosen <- NA
  } else { 
    point_situation = point_situation[1]
    player_pos <- c(point_situation$Position.x, point_situation$Position.z)
    ls$time <- point_situation$Time
    ls$chosen <- point_situation$Rotation.X
    if (!is.null(target_pos)){
      ls$target <- navr::angle_from_positions(player_pos, target_pos)
    }
  }
  return(ls)
}

### learn ------
get_trial_start.learn <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal_pos(obj, trialId - 1))
}

get_trial_start.learn <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal_pos(obj, trialId - 1))
}

### sop ----------
get_trial_start.sop <- function(obj, trialId){
  #First trial is started in a center hall
  if(trialId == 1){
    df_firs_pos <- obj$data$player_log[1, ]
    return(c(df_firs_pos$Position.x[1], df_firs_pos$Position.z[1]))
  }
  return(get_trial_goal_pos(obj, trialId - 1))
}

get_trial_start_point.sop <- function(obj, trialId){
  # this is actually more accurate, becaseu player might not have moved yet when the trial have started
  # player moves in monobehavuiour, but trial gets logged before the move happens
  start <- get_trial_goal(obj, trialId)
  point <- get_trial_point(obj, trialId)
  ls <- list(start = start, point = point)
  return(ls)
}

get_trial_point.sop <- function(obj, trialId){
  #when player points, trial ends so the point is at the trial end
  player_log <- get_player_log_trial(obj, trialId)
  point_line <- tail(player_log, 1)
}

get_trial_goal.sop <- function(obj, trialId){
  point_id <- obj$data$experiment_log$settings$GoalPointOrder[trialId]
  r_point_id <- point_id + 1
  return(get_goal_pos(obj, r_point_id))
}

### RESTIMOTE ----------
get_start.restimote <- function(obj, trialId){
  return(restimoter::get_start_position(obj, trialId))
}
get_goal.restimote <- function(obj, trialId){
  return(restimoter::get_goal_position(obj, trialId))
}

###Universal ----
get_rotations <- function(df){
  ids <- grep("Rotation", colnames(df))
  return(as.data.frame(df[,..ids]))
  return(as.data.frame(df[,ids]))
}