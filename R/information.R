##' Get the information of the APIfunction
##' 
##' Get the information of the APIfunction which created by 
##' \code{APIstore} 
##' 
##' @details 
##' \code{Param} show the Parameter information of the function.
##' 
##' \code{intro} show the Introduction information of the function.
##' 
##' \code{info} show the information of function return .
##' 
##' \code{link} show the link of the function.
##' 
##' \code{origin} show the origin of the function.
##' 
##' @usage Param(object) 
##' intro(object) 
##' info(object) 
##' link(object)
##' origin(object) 
##' 
##' @aliases Param intro info link origin
##' @param object  an APIfunction object created by e.g. \code{APIstore} 
##' @return the information of the Object
##' @author Chiffon <\url{http://chiffon.gitcafe.io}>
##' @examples
##' function440 = APIStore(440)
##' Param(function440)
##' intro(function440)
##' info(function440)
##' link(function440)
##' origin(function440)




Param = function(object){
  cat("---------Parameter----------\n\n")
  cat(object@para)
}

intro = function(object){
  cat("---------Introduction--------\n\n")
  cat(object@intro)
}


info = function(object){
  cat("-------Other Information------\n\n")
  cat(object@returnInfo)
}

link = function(object){
  cat("--------------URL-------------\n\n")
  cat(object@url)
}


origin = function(object){
  cat("--------------Origin-------------\n\n")
  cat(object@origin)
}