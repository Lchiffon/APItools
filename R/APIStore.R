##' Create an APIfunction from API Store
##' 
##' @description This function create an API function object 
##' from a webpage in API Store.<\url{store.baidu.com}>
##' 
##' @details Please Initialize the APIStore token first and
##' use APIStore function to create the API function
##' 
##' @param URL The URL of the API page or the num of the API
##' @param apinum which API will be used for function creating
##' @return an S4 object: APIfuncion,which can directly 
##' used as a function
##' @example 
##' function440 = APIStore(URL = 440, apinum = 1)
##' function440()


APIStore = function(URL,apinum = 1){
  
  ## Test apikey
  if(!"APIstore.api" %in% ls(.GlobalEnv)){
    help("APIstore.api.init")
    stop("apikey haven't set!\nUse APIstore.api.init() to set it! ")
  }
  
  
  
  ## Get URL
  if(is.character(URL)){
    apiURL = URL
  }else{
  apiURL = paste0("http://apistore.baidu.com",
                  "/apiworks/servicedetail/",URL,".html")
  }
  ## Test URL Exist
  if(!RCurl::url.exists(apiURL)){
    stop("This API does not exist!")
  }
  
  
  ## Get table & API Link from URL
  tableList = XML::readHTMLTable(apiURL,stringsAsFactors = F)
  doc = XML::htmlParse(apiURL,encoding="UTF-8")
  rootNode = XML::xmlRoot(doc)
  Xpath = "//p[@class='interface-line clearfix']/span[@class='api-content-right']"
  APILink = XML::xpathSApply(rootNode,Xpath,XML::xmlValue)
  
  
  n = length(APILink)/2
  
  ## Test Table
  if(length(tableList) < 6){
    stop("This API may not support for function creating.")
  }
  
  limitNum = 2*n+1
  limitData = tableList[[limitNum]]
  
  limit = as.character(limitData[1,3])
  if (as.character(limitData[1,3]) == '无限制'){
    limitWarn = F
  }else{
    limitWarn = T
  }
  
  cat('The Limit of API is: ',limit)
  
  
  ## Find the paramter used by API
  if(!apinum %in% 1:length(APILink)/2){
    stop(paste0("There is no Num.",apinum," API!"))
  }
  
  APILink = APILink[apinum*2-1]
  ParamNum = apinum*2
  urlParamter = tableList[[ParamNum]]
  paramList = as.character(urlParamter[,1])
  defaultList = as.character(urlParamter[,6])
  defaultList = sapply(defaultList,function(x)
                  substr(x,1,nchar(x)/2))
  
  ##Argument part
  paramPart1 = paste(paste(paramList,defaultList,sep = " = '"),
                collapse = "',\n")
  paramPart1 = paste0(paramPart1,"'")
  
  ## function part
  paramPart2 = paste(paste(paramList,paramList,sep = "' ,'=', "),
                     collapse = ",'&',\n'")
  paramPart2 = paste0("'",paramPart2)
  
  ##Write function file
  functionString ="forChangekkkmmmAPIfunction = function(
paraPart1Data
){
url = 'APILinkData'
finalurl = paste0(url,'?',
paraPart2Data
)
curl = RCurl::getCurlHandle()
RCurl::curlSetOpt( .opts = list(httpheader = c(apikey = 'apikeyData')),
curl = curl)
ans = RCurl::getURL(finalurl, curl = curl)
if(length(grep(',',ans))==1){
ans = rjson::fromJSON(ans)
}
ans
}"
  


  if(.Platform$OS.type == "windows"){
    Sys.setlocale("LC_CTYPE",
                "chs")
  }
  functionString = sub("forChange",
                    "一",functionString)


  functionString = sub("paraPart1Data", paramPart1, functionString)
  functionString = sub("APILinkData", APILink, functionString)
  functionString = sub("paraPart2Data", paramPart2, functionString)
  functionString = sub("apikeyData", APIstore.api, functionString)
  
  functionString = strsplit(functionString,"kkkmmm")[[1]][2]
  
  writeLines(functionString,'baiduAPI.R',useBytes = T)
  source("baiduAPI.R",encoding = "UTf-8")
  unlink("baiduAPI.R")

  if(.Platform$OS.type == "windows"){
    Sys.setlocale("LC_CTYPE","eng")
  }
  
  urlParamter = cbind(urlParamter,defaultList)
  urlParamterContent = apply(urlParamter,1,function(x)
    paste0('Name: ',x[1],
           '\nDescription:',x[5],
           "\nDefault:",as.character(x[7]),"\n\n\n"))
  urlParamterContent = paste0(urlParamterContent)
  
  out = new('APIfunction')
  out@.Data = APIfunction
  out@para = urlParamterContent
  out@intro = XML::xpathSApply(rootNode,
                               "//span[@id='service-intro']",
                               XML::xmlValue)
  out@returnInfo = XML::xpathSApply(rootNode,
                                    "//div[@class='api-content-right']/pre",
                                    XML::xmlValue)[apinum]
  out@url = apiURL
  out@origin = "Baidu,http://apistore.baidu.com"
  
  out
}

# 
# 
# findLimit = function(tableList){
#   mat = sapply(tableList,dim)
#   Limitnum =   which(mat[1,] == 1  & mat[2,] == 4)
#   Limitnum
# }
# 
# 
# findParam = function(tableList){
#   mat = sapply(tableList,dim)
#   paramNum =   which(mat[2,] == 6)[2]
#   paramNum
# }