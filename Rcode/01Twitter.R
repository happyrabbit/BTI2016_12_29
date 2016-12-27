source("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/00Require.R")
source("/Users/happyrabbit/Documents/Hui/TwitterOauth.R")

user_hui<- getUser("gossip_rabbit")
user_phi<- getUser("DuPontPioneer")
user_mon<- getUser("MonsantoCo")
user_basf<- getUser("BASFAgro")
user_usda<- getUser("USDA")
user_dow<- getUser("DowAgroUS")
user_dowchem<- getUser("DowChemical")
user_dupont<- getUser("DuPont_News")

setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
load("user_phi2016_8_2.RData")
user_phi%>%
  twListToDF()%>%
  glimpse(user_phi)

save(user_hui,file="user_hui2016_8_2.RData")
save(user_phi,file="user_phi2016_8_2.RData")
save(user_mon,file="user_mon2016_8_2.RData")
save(user_basf,file="user_basf2016_8_2.RData")
save(user_usda,file="user_usda2016_8_2.RData")
save(user_dow,file="user_dow2016_8_2.RData")
save(user_dowchem,file="user_dowchem2016_8_2.RData")
save(user_dupont,file="user_dupont2016_8_2.RData")
###################################################
# 1. When using searchTwitter(), get tweets from up to 6-9 days previously: searchTwitter("elon+musk")
# 2. Get up to 3200 tweets at a time from a user's timeline with userTimeline(): userTimeline("elonmusk", n = 3200)
# 3. You can also specify the maxID parameter in userTimeline(). If someone has more than 3200 tweets (find out quickly with: emusk <- getUser("elonmusk") and then em$statusesCount) and pass a tweet id to get tweets before then.
# Then filter on the results. But sadly not a direct way of getting Jan 1, 2016 to Apr 1, 2016 as per the API yet.

tw_user_phi = userTimeline("DuPontPioneer", n=10000)
# tw_user_hui = userTimeline("gossip_rabbit", n=1000)
tw_user_dowchem = userTimeline("DowChemical", n=10000)
tw_user_mon = userTimeline("MonsantoCo", n=10000)
tw_user_basf = userTimeline("BASFAgro", n=10000)
tw_user_usda = userTimeline("USDA", n=10000)
tw_user_dowagro = userTimeline("DowAgroUS", n=10000)

tw_user_dupont = userTimeline("DuPont_News", n=10000)
#load("tw_user_mon2016_8_6.RData")
#tw_user=tw_user_dupont%>%twListToDF()
#range(tw_user$created)
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
save(tw_user_hui,file="tw_user_hui2016_8_6.RData")
save(tw_user_phi,file="tw_user_phi2016_8_18.RData")
save(tw_user_mon,file="tw_user_mon2016_8_18.RData")
save(tw_user_dowchem,file="tw_user_dowchem2016_8_18.RData")
save(tw_user_basf,file="tw_user_basf2016_8_18.RData")
save(tw_user_usda,file="tw_user_usda2016_8_18.RData")
save(tw_user_dowagro,file="tw_user_dow2016_8_18.RData")


save(tw_user_dupont,file="tw_user_dupont2016_8_6.RData")
####################################
#tw_hui = searchTwitter('gossip_rabbit', n = 1E6) %>%
#  twListToDF()
tw_phi = searchTwitter('DuPontPioneer', n = 1E6) %>%
  twListToDF()

tw_mon1 = searchTwitter('#Monsanto', n = 1E6) %>%
  twListToDF()
tw_mon2 = searchTwitter('@Monsanto', n = 1E6) %>%
  twListToDF()
tw_mon<-rbind(tw_mon1,tw_mon2)

tw_dupont1 = searchTwitter('#DuPont', n = 1E6) %>%
  twListToDF()
tw_dupont2 = searchTwitter('DuPont_News', n = 1E6) %>%
  twListToDF()
tw_dupont<-rbind(tw_dupont1,tw_dupont2)

tw_usda1 = searchTwitter('#USDA', n = 1E6) %>%
  twListToDF()
tw_usda2 = searchTwitter('@USDA', n = 1E6) %>%
  twListToDF()
tw_usda<-rbind(tw_usda1,tw_usda2)

tw_basf = searchTwitter('BASFAgro', n = 1E6) %>%
  twListToDF()
tw_dowagro = searchTwitter('DowAgro', n = 1E6) %>%
  twListToDF()
tw_dowchem = searchTwitter('DowChemical', n = 1E6) %>%
  twListToDF()


######################################################
tw_encirca1=searchTwitter('Encirca', n = 1E6)%>%
  twListToDF()
tw_encirca2=searchTwitter('#Encirca', n = 1E6)%>%
  twListToDF()
tw_encirca=rbind(tw_encirca1,tw_encirca2)
tw_encirca=distinct(tw_encirca)

setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
write.csv(tw_encirca,"tw_encirca2016_8_18.csv",row.names=F)
#write.csv(tw_hui,"tw_hui2016_8_2.csv",row.names=F)
write.csv(tw_phi,"tw_phi2016_8_18.csv",row.names=F)
write.csv(tw_dupont,"tw_dupont2016_8_18.csv",row.names=F)
write.csv(tw_usda,"tw_usda2016_8_18.csv",row.names=F)
write.csv(tw_mon,"tw_mon2016_8_18.csv",row.names=F)
write.csv(tw_basf,"tw_basf2016_8_18.csv",row.names=F)
write.csv(tw_dowagro,"tw_dowagro2016_8_18.csv",row.names=F)
write.csv(tw_dowchem,"tw_dowchem2016_8_18.csv",row.names=F)
#############################################################


tw_user_hui$getText()
encirca_tweets = userTimeline("EncircaServices", n=1000)


#tail(tw)
d = twListToDF(tw)
# head(d$text,50)
d$text[grep("#Monsanto",d$text)]



getwd()
str(tw)
dim(tw)
tail(tw,200)

# saveRDS(tw, '../../R/MSST_Tweets.RDS')
tw = readRDS('../../R/MSST_Tweets.RDS')

user <- getUser("DuPontPioneer")
user_mon$lastStatus$text


str(user_hui)
user_mon$getFollowersCount()
user_phi$getFollowersCount()

user_followers <- user_mon$getFollowers()
warnings()

followers_n <- length(user_followers)

followers_screennames <- vector()
for (i in 1:followers_n) {
  followers_screennames[i] <- user_followers[[i]]$screenName
}
followers_screennames[1:6]