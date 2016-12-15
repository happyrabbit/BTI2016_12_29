source("00Require.R")


trump_views <- article_pageviews(project = "en.wikipedia", article = "Donald Trump",
                                 user_type = "user", start = "20150101", end = "20161214")
trump<-trump_views%>%select(timestamp,views)
names(trump)<-c("Timestamp","Trump")

clinton_views <- article_pageviews(project = "en.wikipedia", article = "Hillary Clinton",
                                   user_type = "user", start = "20150101", end = "20161214")
clinton<-clinton_views%>% select(timestamp,views)
names(clinton)<-c("Timestamp","Clinton")

dupont_views <- article_pageviews(project = "en.wikipedia", article = "DuPont", user_type = "user", start = "20150101", end = "20160803")
dupont<-dupont_views%>%select(timestamp,views)
names(dupont)<-c("Timestamp","DuPont")

phi_views <- article_pageviews(project = "en.wikipedia", article = "DuPont Pioneer", user_type = "user", start = "20150101", end = "20160803")
phi<-phi_views%>%select(timestamp,views)
names(phi)<-c("Timestamp","DuPont Pioneer")

dow_views <- article_pageviews(project = "en.wikipedia", article = "Dow Chemical Company", user_type = "user", start = "20150101", end = "20160803")
dow<-dow_views%>% select(timestamp,views)
names(dow)<-c("Timestamp","Dow")

mon_views <- article_pageviews(project = "en.wikipedia", article = "Monsanto", user_type = "user", start = "20150101", end = "20160803")
mon<-mon_views%>% select(timestamp,views)
names(mon)<-c("Timestamp","Monsanto")

syn_views <- article_pageviews(project = "en.wikipedia", article = "Syngenta", user_type = "user", start = "20150101", end = "20160803")
syn<-syn_views%>% select(timestamp,views)
names(syn)<-c("Timestamp","Syngenta")

pdata<-merge(clinton, trump)
pdata<-merge(pdata, dupont)
pdata<-merge(pdata, dow)
pdata<-merge(pdata, phi)
pdata<-merge(pdata, mon)
pdata<-merge(pdata,syn)
pdata$Timestamp<-ymd(substr(pdata$Timestamp,1,8))
setwd("/Users/happyrabbit/Documents/Hui/Data/Wikipedia")
write.csv(pdata,"WikiPageView2016_8_2.csv",row.names=F)

pdata <- xts(pdata[,c("Trump","Clinton","DuPont","Dow","DuPont Pioneer","Monsanto","Syngenta")], order.by=pdata$Timestamp)


dygraph(pdata) %>%
  dySeries("DuPont") %>%
  dySeries("Dow") %>%
  dySeries("DuPont Pioneer") %>%
  dySeries("Monsanto") %>%
  dySeries("Syngenta") %>%
 # dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector()
