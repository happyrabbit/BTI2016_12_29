source("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/00Require.R")
source("/Users/happyrabbit/Documents/Hui/TwitterOauth.R")

load("/Users/happyrabbit/Documents/Hui/Data/Twitter/user_hui2016_8_2.RData")
hui_followers <- user_hui$getFollowers()%>%
  twListToDF()
load("/Users/happyrabbit/Documents/Hui/Data/Twitter/user_mon2016_8_2.RData")
mon_followers <- user_mon$getFollowers()%>%
  twListToDF()

load("/Users/happyrabbit/Documents/Hui/Data/Twitter/user_phi2016_8_2.RData")
phi_followers <- user_phi$getFollowers()%>%
  twListToDF()
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter/")
write.csv(hui_followers,"hui_followers2016_8_10.csv",row.names = F)
write.csv(mon_followers,"mon_followers2016_8_10.csv",row.names = F)
write.csv(phi_followers,"phi_followers2016_8_10.csv",row.names = F)

# followersCount   : num 93092 (get 16614)
#####################################
source("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/00Require.R")
library(tm)   
library(wordcloud)
hui_followers<-read.csv("/Users/happyrabbit/Documents/Hui/Data/Twitter/hui_followers2016_8_10.csv")

##############
user_bill<- getUser("billmahanna")
bill_followers <- user_bill$getFollowers()%>%
  twListToDF()

docs <- bill_followers$description
docs<-gsub(","," ",docs)
docs<-gsub("stats","statistics",docs)
reuters<-VCorpus(VectorSource(docs))
reuters <- tm_map(reuters, content_transformer(tolower))
reuters <- tm_map(reuters, removeWords, stopwords("english"))
dtm <- DocumentTermMatrix(reuters)
freq <- colSums(as.matrix(dtm)) 
wordcloud(words=names(freq),freq,min.freq =2,random.color = T,random.order=F,colors=rainbow(7),rot.per=.15)