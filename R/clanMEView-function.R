#' @title Version function for the clanMEView library
#' @description Version function for the clanMEView library.
#' @usage
#' clanEGSnrc()
#' @name clanEGSnrc
#' @author Claus E. Andersen
#' @return A list of information about the version and functions within clanMEView.
#' @export
clanOptim <- function(){
  list(name="clanMEView",
       version=0.008,
       date="August 3, 2014 (uploaded August 6, 2016)",
       functions=sort(c("clanMEView",
                        "MEView.read.file.header"
       )))
}