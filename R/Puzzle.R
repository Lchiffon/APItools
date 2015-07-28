##' Puzzle 
##' 
##' @description Enjoy the puzzle!
##' 
##' @example 
##' Puzzle()

# APIstore.api = '1495c3e9b46f09c3c5a4f69b0e6c6e90'
Puzzle = function(...){
  if(.Platform$OS.type == "windows"){
    Sys.setlocale("LC_CTYPE",
                  "chs")
  }
  data = function440(...)
  if(is.null(data$title)){
    data = function440(...)
  }
  print(data$Title)
  ans = readline("Your Answer>")
  message = paste0('Good Job! You got it! Answer is ',data$Ans)
  while(!(nchar(ans)!=0 & grepl(ans,data$Answer))){
    cat("It is wrong. \nTry it again?[Answer/n]")
    ans2 = readline("Your Answer>")
    if(ans2 == 'n'){
      message = paste0("What a pity. Answer is ",data$Ans)
      break
    }
    ans = ans2
  }
  if(.Platform$OS.type == "windows"){
    Sys.setlocale("LC_CTYPE",
                  "eng")
  }
  cat(message)
}

function440 = function(id = '-1',api = APIstore.api){
  url = 'http://apis.baidu.com/myml/c1c/c1c'
  finalurl = paste0(url,'?','id' ,'=', id)
  curl = RCurl::getCurlHandle()
  RCurl::curlSetOpt( .opts = list(httpheader = c(apikey = api)),
              curl = curl)
  ans = RCurl::getURL(finalurl, curl = curl)
  if(length(grep(',',ans))==1){
    ans = rjson::fromJSON(ans)
  }
  ans
}