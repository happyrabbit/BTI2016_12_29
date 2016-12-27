library(twitteR)
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
## yieldhero
temp = list.files(pattern="tw_yieldhero*")
dat_yieldhero<-NULL
for (i in 1:length(temp)){
  link <- paste0("/Users/happyrabbit/Documents/Hui/Data/Twitter/",temp[i])
  load(link)
  dat_yieldhero<-rbind(dat_yieldhero, twListToDF(tw_yieldhero))
}
dat_yieldhero<- dplyr::distinct(dat_yieldhero)
summary(dat_yieldhero)

## chrome
temp = list.files(pattern="tw_qrome*")
dat_chrome<-NULL
for (i in 1:length(temp)){
  link <- paste0("/Users/happyrabbit/Documents/Hui/Data/Twitter/",temp[i])
  load(link)
  dat_chrome<-rbind(dat_chrome, twListToDF(tw_qrome))
}
dat_chrome<- dplyr::distinct(dat_chrome)
summary(dat_chrome)
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
write.csv(dat_yieldhero,paste0("tweets_yieldhero",Sys.Date(),".csv"))
write.csv(dat_chrome,paste0("tweets_chrome",Sys.Date(),".csv"))

