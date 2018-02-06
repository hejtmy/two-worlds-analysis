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