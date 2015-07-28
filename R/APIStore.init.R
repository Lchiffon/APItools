##' Initialize the APIStore token
##' 
##' @description 
##' Initialize the APIStore token which get from 
##' <\url{http://apistore.baidu.com/astore/usercenter}>
##' 
##' @details 
##' This function runs every time you use \code{APIStore}. 
##' You should use your own token which is registered in 
##' <\url{http://apistore.baidu.com/astore/usercenter}>
##' 
##' @param  apikey  your APIkey from 
##' \url{http://apistore.baidu.com/astore/usercenter}
##' 
##' @example 
##' APIStore.init("Your APIkey")
##' 
APIStore.init = function(apikey){
  if(!is.character(apikey))
    stop('apikey should be a string')
  APIstore.api <<- apikey
  


  cat("Set API key succeed!\nYour key:",apikey)
}