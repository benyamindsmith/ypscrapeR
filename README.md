# ypscrapeR <a href='https://github.com/benyamindsmith/ypscrapeR/tree/master/'><img src='	Add a heading.png' align="right" height="200" /></a>

A webscraping package for yellowpages.com for pulling name, address, number, website and email of contacts listed in the yellow pages in R. 

## Disclaimer
__Note:__ Extracting data for this will take alot of time, I have experimented with having to improve the speed of this function but have not had a sucessful solution. So when running this, go for a walk outside, read a book, do something else on your computer etc. Depending on the size of the scrape it might take a hour+ to get the data you want to extract (but it sure beats copy/pasting).

After seeing other repos on github who made this in other languages I skimmed over [yellowpages.com's TOS](https://www.yellowpages.com/about/legal/terms-conditions) and have not found anything explicitly violating this. With this in mind, I made this scraper (Please feel free to post an issue if there is a problem on GitHub).

## Dependencies

This package is presently dependent on the `rvest` and `xml2` packages for scraping, the `magrittr` package for the pipe operator, and the `tibble` package for the data structure of the output. 

## Installing this package
Based on the trouble I got into with the [sbscrapeR package](https://benyamindsmith.github.io/sbscrapeR/) I don't think I am going to submit this package quite yet to CRAN. But it can easily be accessed with the `devtools` package: 

```R
devtools::install_github("benyamindsmith/ypscrapeR)
```


## Example
Lets say I want to get the contact information for all the pizza stores in Lakewood NJ as listed on the yellow pages. The link for this is:

https://www.yellowpages.com/search?search_terms=pizza&geo_location_terms=Lakewood%2C+NJ

Now to run this code I would run the `yp_scrape` function:

```R

dt<-yp_scrape("https://www.yellowpages.com/search?search_terms=pizza&geo_location_terms=Lakewood%2C+NJ")

```

After some time (could be a while based on your machine). 

With this, you should get the following output

(_Scraped June 6, 2019_)

```R
>dt

# A tibble: 450 x 5
   Name                       Address                     `Phone Number` Website                Email               
   <chr>                      <chr>                       <chr>          <chr>                  <chr>               
 1 D & D Pizza                130 Ocean Ave, Lakewood, N… (732) 364-3790 ""                     ""                  
 2 Ippolito's Pizzeria e Ris… 700 Highway 70, Lakewood, … (732) 363-0103 http://www.ippolitosc… mailto:pi929@aol.com
 3 Charlie's Pizza            1000 Highway 70, Lakewood,… (732) 370-3580 http://www.charliespi… mailto:charliespizz…
 4 Emilio's Pizza & Restaura… 715 Bennetts Mills Rd Unit… (732) 719-6944 http://emiliosjackson… mailto:solano1777@g…
 5 Via Roma Restaurant & Piz… 2360 Route 9, Toms River, … (732) 276-4331 ""                     mailto:viaromatomsr…
 6 Frank's Pizza & Restaurant 1900 Highway 70, Lakewood,… (732) 477-4103 http://www.frankspizz… mailto:frankspizza@…
 7 Knockout Pizza             60 Chambersbridge Rd, Lake… (732) 363-3000 http://knockoutpizza.… mailto:dmkofnj@aol.…
 8 Rincon Mexicano Pizzeria … 100 Clifton Ave, Lakewood,… (732) 994-7350 ""                     ""                  
 9 Pizzaleh                   32 Clifton Ave, Lakewood, … (732) 367-7977 ""                     mailto:efraim@pizza…
10 Pizano                     1715 Clifton Ave, Lakewood… (732) 367-0200 http://thepizano.com   ""                  
# … with 440 more rows
```

Hope this is useful.

Enjoy the package!
