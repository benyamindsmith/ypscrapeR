


###The function###
require(rvest)
require(tibble)
yp_scrape<-function(link){
  
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

  hrfs<-sapply(newurls, function(x) pipelink(x,"#main-content .business-name"))
  mainlink<-"https://www.yellowpages.com"
  goodlinks<-lapply(hrfs,function(y) unname(sapply(y,function(x) gsub(" ","",paste(mainlink,x)))))
  goodlinks<-unname(goodlinks)
  goodlinks<-unlist(goodlinks)
  
  ########Scraping########
  nms<-sapply(goodlinks,function(x) pipeit(x,"h1"))
  adr<-sapply(goodlinks,function(x) pipeit(x, ".address"))
  pn<-sapply(goodlinks,function(x) pipeit(x, ".phone"))
  wb<-sapply(goodlinks ,function(x) pipelink(x, ".website-link"))
  eml<-sapply(goodlinks,function(x)pipelink(x,".email-business"))
              
  Sys.sleep(sample(10, 1) * 0.1)

  tibble(Name=nms,Address=adr,"Phone Number"=pn,Website=wb,"Email"=eml)
}
