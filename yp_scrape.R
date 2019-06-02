


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
  ###Required Info#####
  mainlink<-"https://www.yellowpages.com"
  n<-get_page_n(link)
  hrfs<-pipelink(link,"#main-content .business-name")
  goodlinks<-unname(sapply(hr,function(x) gsub(" ","",paste(ml,x))))
  nms<-unname(sapply(goodlinks,function(x) pipeit(x,"h1")))
  adr<-unname(sapply(goodlinks,function(x) pipeit(x, ".address")))
  pn<-unname(sapply(goodlinks,function(x) pipeit(x, ".phone")))
  wb<-unname(sapply(goodlinks,function(x) pipelink(x, ".website-link")))
  eml<-unname(sapply(goodlinks,function(x)pipelink(x,".email-business")))
  
  #Output
  tibble(Name=nms,Address=adr,"Phone Number"=pn,Website=wb,"Email"=eml)
}
