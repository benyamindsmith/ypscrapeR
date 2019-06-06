#'Scrape contact info from yellowpages.com
#'
#'The following is a custom webscraper for extracting data from directories on <https://www.yellowpages.com>
#'
#'@import rvest xml2
#'
#'@param link the desired link you want to scrape on yellowpages.com
#'
#'@keywords yellowpages
#'@export 
#'@examples
#'yp_scrape("https://www.yellowpages.com/search?search_terms=kosher+restaurant&geo_location_terms=Lakewood%2C+NJ")
#'



yp_scrape<-function(link){
  
  options(timeout = 4000000)
  ###Required functions#####
  pipelink<-function(url,code){
    read_html(url)%>%html_nodes(code)%>%html_attr("href")
  }
  
  pipeit<-function(url,code){
    read_html(url)%>%html_nodes(code)%>%html_text()
  }
  
  
  get_page_n<-function(url){
    n<-pipeit(url,".pagination")
    n<-gsub("[A-Z]|[a-z]"," ",n)
    n<-strsplit(n,"     ")
    n<-unlist(n)
    n<-as.numeric(n[2])
    p<-length(pipelink(url,"#main-content .business-name"))
    n<-ceiling(n/p)
    n
  }
  
  make_nice<-function(x){
    x%>%vapply(paste,collapse=", ",character(1L))
  }
  ##########################
  ###Required Info########
  n<-get_page_n(link)
  
  
  newurl<-paste(link,"&page=")
  newurl<-gsub(" ","",newurl)
  
  newurls<-c()
  for(i in 1:n){
    newurls[i]<-paste(newurl,i)
  }
  
  newurls<-gsub(" ","",newurls)
  
  hrfs<-sapply(newurls, function(x) {Sys.sleep(sample(10, 1) * 0.1)
                                   pipelink(x,"#main-content .business-name")})
  mainlink<-"https://www.yellowpages.com"
  goodlinks<-lapply(hrfs,function(y) unname(sapply(y,function(x) gsub(" ","",paste(mainlink,x)))))
  goodlinks<-unname(goodlinks)
  goodlinks<-unlist(goodlinks)
  
  ########Scraping########
  nms<-sapply(goodlinks,function(x){Sys.sleep(sample(10, 1) * 0.1)
                                    pipeit(x,"h1")})
  adr<-sapply(goodlinks,function(x){ Sys.sleep(sample(10, 1) * 0.1)
                                     pipeit(x, ".address")})
  pn<-sapply(goodlinks,function(x) {Sys.sleep(sample(10, 1) * 0.1)
                                      pipeit(x, ".phone")})
  wb<-sapply(goodlinks ,function(x){ Sys.sleep(sample(10, 1) * 0.1)
                                     pipelink(x, ".website-link")})
  eml<-sapply(goodlinks,function(x) {Sys.sleep(sample(10, 1) * 0.1)
                                      pipelink(x,".email-business")})
  
  
  
  dt<-tibble(Name=nms,Address=adr,"Phone Number"=pn,Website=wb,"Email"=eml)
  dt$Address<-make_nice(dt$Address)
  dt$`Phone Number`<-make_nice(dt$`Phone Number`)
  dt$Website<-make_nice(dt$Website)
  dt$Email<-make_nice(dt$Email)
  
  options(timeout=10001)
  
  dt
  
}
