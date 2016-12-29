source("00Require.R")

trump_views <- article_pageviews(project = "en.wikipedia", article = "Donald Trump",
                                 user_type = "user", start = "20150101", end = "20161215")
trump<-trump_views%>%select(timestamp,views)
names(trump)<-c("Timestamp","Trump")

clinton_views <- article_pageviews(project = "en.wikipedia", article = "Hillary Clinton",
                                   user_type = "user", start = "20150101", end = "20161214")
clinton<-clinton_views%>% select(timestamp,views)
names(clinton)<-c("Timestamp","Clinton")
