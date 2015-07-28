setClass("APIfunction",
        representation(
          para = "character",
          limit = "character",
          intro = "character",
          returnInfo = "character",
          url = "character",
          origin = "character"
        ),
        contain = 'function')




setMethod("summary",
          signature = "APIfunction",
          definition = function(object){
            cat("--------------URL-------------\n")
            cat(object@url)
            cat("\n\n---------Introduction--------\n")
            if(nchar(object@intro)>100){
              cat(paste0(substr(object@intro,1,100),"..."))
            }else{
              cat(object@intro)
            }
            cat("\n---------Parameter----------\n\n")
            cat(object@para)
            cat("\n-------Other Information------\n")
            if(nchar(object@returnInfo)>100){
              cat(paste0(substr(object@returnInfo,1,100),"..."))
            }else{
              cat(object@returnInfo)
            }
          } )