source("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/00Require.R")
source("/Users/happyrabbit/Documents/Hui/TwitterOauth.R")
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
yieldhero <- read.csv("tweets_yieldhero2016-10-28.csv")
tweets_chrome <- read.csv("tweets_chrome2016-10-28.csv")
sm <- unique(yieldhero$screenName,tweets_chrome$screenName)

description <- NULL
statusesCount <- NULL
followersCount <- NULL
favoritesCount <- NULL
friendsCount <- NULL
name <- NULL
# url <- NULL
created <- NULL
protected <- NULL
verified <- NULL
screenName <- NULL
location <- NULL
lang <- NULL
id <- NULL
followRequestSent <- NULL
profileImageUrl <- NULL

for (i in 651:length(sm)){
  user <- getUser(sm[i])
  description <- c(description, user$description) 
  statusesCount <- c(statusesCount, user$statusesCount)
  followersCount <- c(followersCount, user$followersCount)
  favoritesCount <- c(favoritesCount, user$favoritesCount)
  friendsCount <- c(friendsCount, user$friendsCount)
  name <- c(name, user$name)
  # url <- c(url, user$url)
  created <- c(created, user$created)
  protected <- c(protected, user$protected)
  verified <- c(verified, user$verified)
  screenName <- c(screenName, user$screenName)
  location <- c(location, user$location)
  lang <- c(lang, user$lang)
  id <- c(id, user$id)
  followRequestSent <- c(followRequestSent, user$followRequestSent)
  profileImageUrl <- c(profileImageUrl, user$profileImageUrl)
}

res<-data.frame(list(description=description,
                     statusesCount=statusesCount,
                     followersCount = followersCount,
                     favoritesCount = favoritesCount,
                     friendsCount = friendsCount,
                     name = name,
                     # url = url,
                     created = created,
                     protected = protected,
                     verified = verified,
                     screenName = screenName,
                     location = location,
                     lang = lang,
                     id = id,
                     followRequestSent = followRequestSent,
                     profileImageUrl = profileImageUrl
                     ))
summary(res)
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
write.csv(res,"User_info.csv")

