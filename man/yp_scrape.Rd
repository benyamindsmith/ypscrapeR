% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/yp_scrape.R
\name{yp_scrape}
\alias{yp_scrape}
\title{Scrape contact info from yellowpages.com}
\usage{
yp_scrape(link)
}
\arguments{
\item{link}{the desired link you want to scrape on yellowpages.com}
}
\description{
The following is a custom webscraper for extracting data from directories on <https://www.yellowpages.com>
}
\examples{
yp_scrape("https://www.yellowpages.com/search?search_terms=kosher+restaurant&geo_location_terms=Lakewood\%2C+NJ")

}
\keyword{yellowpages}
