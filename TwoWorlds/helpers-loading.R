#' Loads sheets from a particular google sheet into a list
#'
#' @param name 
#' @param sheets 
#'
#' @return
#'
#' @examples
fetch_sheet <- function(name, sheets){
  gap <- gs_title(name)
  ls <- list()
  for (sheet in sheets){
    tab <- tryCatch(
      {
        tab <- gs_read(gap, sheet)
        ls[[sheet]] <- tab
      },
      error = function(cond){
        message(cond)
        ls[[sheet]] <- NULL
      },
      finally = function(cond){
        print("sucessfully loaded")
      }
    )
  }
  return(ls)
}

get_participant_line <- function(code, settings){
  line <- settings$participants[settings$participants$Code == code, ]
  if(nrow(line) != 1){
    warning(paste0("Participant ", code, ", doesn't have single line"))
    return(NULL)
  }
  return(line)
}

get_settings_order <- function(code, what, phase, settings){
  line <- get_participant_line(code, settings)
  if(is.null(line)) return(NULL)
  settings_name <- paste0(what, phase) #Viewpoint1, Pointing2 etc.
  version_name <- as.character(line[, settings_name])
  order <- settings$goal_order[[what]][,version_name] #returns data.frame
  order <- order[[1]]
  return(order)
}