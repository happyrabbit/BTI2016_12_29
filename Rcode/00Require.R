p_needed <- c("plyr", "dplyr", "stringr", "lubridate", "jsonlite", "httr", 
              "xml2", "rvest", "devtools", "ggmap",  "networkD3", "RSelenium",
              "pageviews", "aRxiv", "twitteR", "streamR","igraph","rbokeh","shiny",
              "animation","caTools","wordcloud","coreNLP","plotly","DT")
lapply(p_needed, require, character.only = TRUE)
library(dygraphs)
library(xts)
library(leaflet)
