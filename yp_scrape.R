


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
  n<-n+1
  
  
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
  
  ########Scraping########
  nms<-lapply(goodlinks,function(y) unname(sapply(y,function(x) pipeit(x,"h1"))))
  adr<-lapply(goodlinks, function(y) unname(sapply(y,function(x) pipeit(x, ".address"))))
  pn<-lapply(goodlinks, function(y) unname(sapply(y,function(x) pipeit(x, ".phone"))))
  wb<-lapply(goodlinks, function(y) unname(sapply(y ,function(x) pipelink(x, ".website-link"))))
  eml<-lapply(goodlinks, function(y) unname(sapply(y,function(x)pipelink(x,".email-business"))))

  kr<-tibble(Name=nms,Address=adr,"Phone Number"=pn,Website=wb,"Email"=eml)
  
  #####Wrangling#####
  Nm<-unlist(unname(lapply(kr$Name, function(y) lapply(y, function(x) if(identical(x, character(0))) NA_character_ else x))))
  Ad<-unlist(unname(lapply(kr$Address, function(y) lapply(y, function(x) if(identical(x, character(0))) NA_character_ else x))))
  Pn<-unlist(unname(lapply(kr$Address, function(y) lapply(y, function(x) if(identical(x, character(0))) NA_character_ else x)))) 
  Web<-unlist(unname(lapply(kr$Website, function(y) lapply(y, function(x) if(identical(x, character(0))) NA_character_ else x))))
  Email<-kr$Email
                   
  tibble(Name=Nm,Address=Ad,"Phone Number"=Pn,Website=Web,Email)
}
