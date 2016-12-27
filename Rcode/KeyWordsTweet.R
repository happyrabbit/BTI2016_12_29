source("/Users/happyrabbit/Documents/Hui/Projects/UnstrData/00Require.R")
source("/Users/happyrabbit/Documents/Hui/TwitterOauth.R")

##################################
tw_qrome<-searchTwitter('qrome', n = 1E6)
tw_yieldhero<-searchTwitter('#yieldhero', n = 1E6)
summary(tw_qrome%>%twListToDF())
summary(tw_yieldhero%>%twListToDF())
#####################################################
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
save(tw_yieldhero,file=paste0("tw_yieldhero",Sys.Date(),".RData") )
save(tw_qrome,file=paste0("tw_qrome",Sys.Date(),".RData"))
#load("tw_yieldhero2016-09-25.RData")
tw_user_billm = userTimeline("billmahanna", n=10000)

tw_user_trump = userTimeline("realDonaldTrump", n=10000)
tw_trump<-twListToDF(tw_user_trump)
setwd("/Users/happyrabbit/Documents/Hui/Data/Twitter")
save(tw_trump,file=paste0("tw_user_trump",Sys.Date(),".csv") )


length(tw_user_billm[[1]]$text)

tw_user_billm2=tw_user_billm
user_bill<- getUser("billmahanna")
str(user_bill)
##################################################
save(tw_user_billm,file=paste0("tw_user_billm",Sys.Date(),".RData") )
save(user_bill,file=paste0("user_bill",Sys.Date(),".RData"))

df=tw_user_billm%>%twListToDF()
df
str(tw_user_billm2%>%twListToDF())
