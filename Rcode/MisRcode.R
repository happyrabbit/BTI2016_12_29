
source("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/00Require.R")
urlstat="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Listofstatisticians.html"
browseURL(urlstat)
browseURL("/Users/happyrabbit/Documents/Hui/Data/Web/MichaelWeirTwitter.html")
browseURL("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/IrvingFisher.html")
urlbuzz="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/BuzzFeed.html"
browseURL(urlbuzz)
urldekalb<-"/Users/happyrabbit/Documents/Hui/Data/Web/DEKALBCorn.html"
browseURL(urldekalb)
urlphi <- "/Users/happyrabbit/Documents/Hui/Data/Web/PHICorn.html"
browseURL(urlphi)
browseURL("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/connections.html")


## API: Trump v.s Clinton Wikipedia View

pdat <- xts(data[,c("Trump","Clinton")], order.by=data$Timestamp)
pdat%>%
  dygraph() %>%
  dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector()

## Twitter API : #yieldhero Who retweets whom

#tweets<-tweets%>%twListToDF()
#tweet_txt<-tweets$text

tweet_txt = sapply(tweets, function(x) x$getText())

# which tweets are retweets
#rt_patterns = grep("^RT",tweet_txt, ignore.case=TRUE)
#grep("(RT|via)((?:\\b\\W*@\\w+)+)", tweets, ignore.case=TRUE, value=TRUE)

rt_patterns = grep("(RT|via)((?:\\b\\W*@\\w+)+)",tweet_txt, ignore.case=TRUE)

# we create a list to store user names
who_retweet = as.list(1:length(rt_patterns))
who_post = as.list(1:length(rt_patterns))

# for loop
for (i in 1:length(rt_patterns))
{
  # get tweet with retweet entity
  twit = tweets[[rt_patterns[i]]]
  # get retweet source
  poster = str_extract_all(twit$getText(),"(RT|via)((?:\\b\\W*@\\w+)+)")
  #remove ':'
  poster = gsub(":", "", unlist(poster))
  # name of retweeted user
  who_post[[i]] = gsub("(RT @|via @)", "", poster, ignore.case=TRUE)
  # name of retweeting user
  who_retweet[[i]] = rep(twit$getScreenName(), length(poster))
}

# and we put it off the list
who_post = unlist(who_post)
who_retweet = unlist(who_retweet)

retweeter_poster = cbind(who_retweet, who_post)
rt_graph = graph.edgelist(retweeter_poster)
ver_labs = get.vertex.attribute(rt_graph, "name", index=V(rt_graph))
glay = layout.fruchterman.reingold(rt_graph)
par(bg="gray15", mar=c(1,1,1,1))
plot(rt_graph, layout=glay,
     vertex.color="gray25",
     vertex.size=10,
     vertex.label=ver_labs,
     vertex.label.family="sans",
     vertex.shape="none",
     vertex.label.color=hsv(h=0, s=0, v=.95, alpha=0.5),
     vertex.label.cex=0.65,
     edge.arrow.size=0.7,
     edge.arrow.width=0.5,
     edge.width=3,
     edge.color=hsv(h=.95, s=1, v=.7, alpha=0.5))
# add title
title("\nTweets with '#yieldhero':  Who retweets whom",
      cex.main=1, col.main="gray95") 
```


## Source for tweets including "DuPontPioneer"

```{r}
tw_phi<-read.csv("/Users/happyrabbit/Documents/Hui/Data/Twitter/tw_phi2016_8_2.csv")
MsgSource<-gsub(".*Twitter for ","",tw_phi$statusSource)
MsgSource<-gsub("</a>","",MsgSource)
MsgSource[grep("Twitter Web Client",MsgSource)]<-"Twitter Web Client"
MsgSource[grep("twitterfeed",MsgSource)]<-"twitterfeed"
MsgSource[grep("hootsuite.com",MsgSource)]<-"hootsuite.com"
MsgSource[grep("Mobile Web",MsgSource)]<-"Mobile Web"
MsgSource[grep("pioneer.com",MsgSource)]<-"pioneer.com"
MsgSource[grep("instagram.com",MsgSource)]<-"instagram.com"
MsgSource[grep("botlibre.com",MsgSource)]<-"botlibre.com"
MsgSource[grep("bufferapp.com",MsgSource)]<-"bufferapp.com"
MsgSource[grep("TweetDeck",MsgSource)]<-"TweetDeck"
MsgSource[grep("bufferapp.com",MsgSource)]<-"bufferapp.com"
MsgSource[grep("TweetDeck",MsgSource)]<-"TweetDeck"
MsgSource[grep("ifttt.com",MsgSource)]<-"ifttt.com"
MsgSource[grep("roundteam.co",MsgSource)]<-"roundteam.co"
MsgSource[grep("botize.com",MsgSource)]<-"botize.com"
MsgSource[grep("periscope.tv",MsgSource)]<-"periscope.tv"
ts<-table(MsgSource)
MsgSource <-factor(MsgSource, levels=names(ts)[order(ts)])
ts<-data.frame(table(MsgSource))
p<-ggplot(ts, aes(x=MsgSource, y=Freq)) + 
  geom_bar(stat="identity") + 
  coord_flip()+
  ylim(0,2600)+
  ggtitle("2016-07-25 to 2016-08-03")+
  labs( y='Counts')
ggplotly(p)
```

## Source for tweets including "Monsanto"

```{r}
tw_mon=read.csv("/Users/happyrabbit/Documents/Hui/Data/Twitter/tw_mon2016_8_3.csv")
MsgSource<-gsub(".*Twitter for ","",tw_mon$statusSource)
MsgSource<-gsub("</a>","",MsgSource)
MsgSource[grep("Twitter Web Client",MsgSource)]<-"Twitter Web Client"
MsgSource[grep("twitterfeed",MsgSource)]<-"twitterfeed"
MsgSource[grep("TweetDeck",MsgSource)]<-"TweetDeck"
MsgSource[grep("Twitter Ads",MsgSource)]<-"Twitter Ads"
MsgSource[grep("spredfast.com",MsgSource)]<-"spredfast.com"
MsgSource[grep("Mobile Web",MsgSource)]<-"Mobile Web"
MsgSource[grep("doubledutch.me",MsgSource)]<-"doubledutch.me"
MsgSource[grep("turpial.org.ve",MsgSource)]<-"turpial.org.ve"
MsgSource[grep("tweetjukebox.com",MsgSource)]<-"tweetjukebox.com"
MsgSource[grep("Facebook",MsgSource)]<-"Facebook"
MsgSource[grep("sproutsocial.com",MsgSource)]<-"sproutsocial.com"
MsgSource[grep("roundteam.co",MsgSource)]<-"roundteam.co"
MsgSource[grep("dustcloud.io",MsgSource)]<-"dustcloud.io"
MsgSource[grep("roundteam.co",MsgSource)]<-"roundteam.co"
MsgSource[grep("klinkerapps.com",MsgSource)]<-"klinkerapps.com"
MsgSource[grep("Tweetbot",MsgSource)]<-"Tweetbot"
MsgSource[grep("hootsuite.com",MsgSource)]<-"hootsuite.com"
MsgSource[grep("tweetcaster.com",MsgSource)]<-"tweetcaster.com"
MsgSource[grep("twitpane.com",MsgSource)]<-"twitpane.com"
MsgSource[grep("bufferapp.com",MsgSource)]<-"bufferapp.com"
MsgSource[grep("twitter.com/Monsant_destroy",MsgSource)]<-"twitter.com/Monsant_destroy"
MsgSource[grep("postcron.com",MsgSource)]<-"postcron.com"
MsgSource[grep("tweetiumapp.com",MsgSource)]<-"matthewongamedesign.com"
MsgSource[grep("nosudo.co",MsgSource)]<-"nosudo.co"
MsgSource[grep("seesmic.com",MsgSource)]<-"seesmic.com"
MsgSource[grep("echofon.com",MsgSource)]<-"echofon.com"
MsgSource[grep("Twidere for Android",MsgSource)]<-"Twidere for Android"
MsgSource[grep("matthewongamedesign.com",MsgSource)]<-"matthewongamedesign.com"
MsgSource[grep("ifttt.com",MsgSource)]<-"ifttt.com"
MsgSource[grep("socialoomph.com",MsgSource)]<-"socialoomph.com"
MsgSource[grep("paper.li",MsgSource)]<-"paper.li"
MsgSource[grep("instagram.com",MsgSource)]<-"instagram.com"
MsgSource[grep("rufdesign.co.uk",MsgSource)]<-"rufdesign.co.uk"
MsgSource[grep("linkis.com",MsgSource)]<-"linkis.com"
MsgSource[grep("williamengdahl.com",MsgSource)]<-"williamengdahl.com"
MsgSource[grep("flashwebcreations.biz",MsgSource)]<-"flashwebcreations.biz"
ts<-table(MsgSource)
MsgSource <-factor(MsgSource, levels=names(ts)[order(ts)])
ts<-data.frame(table(MsgSource))%>%
  filter(Freq>20)
# length(idx)
p<-ggplot(ts, aes(x=MsgSource, y=Freq)) + 
  geom_bar(stat="identity") + 
  coord_flip()+
  ylim(0,2600)+
  labs( y='Counts')+
  ggtitle("2016-07-26 to 2016-08-04")
ggplotly(p)
```

<!--
  ## Pioneer twitter account
  
  ```r
load("/Users/happyrabbit/Documents/Hui/Data/Twitter/tw_user_phi2016_8_6.RData")
tw_phi<-tw_user_phi%>%twListToDF()
MsgSource<-gsub(".*Twitter for ","",tw_phi$statusSource)
MsgSource<-gsub("</a>","",MsgSource)
MsgSource[grep("Twitter Web Client",MsgSource)]<-"Twitter Web Client"
MsgSource[grep("twitterfeed",MsgSource)]<-"twitterfeed"
MsgSource[grep("TweetDeck",MsgSource)]<-"TweetDeck"
MsgSource[grep("Twitter Ads",MsgSource)]<-"Twitter Ads"
MsgSource[grep("spredfast.com",MsgSource)]<-"spredfast.com"
MsgSource[grep("pioneer.com",MsgSource)]<-"pioneer.com"
ts<-table(MsgSource)
MsgSource <-factor(MsgSource, levels=names(ts)[order(ts)])
ts<-data.frame(table(MsgSource))
p<-ggplot(ts, aes(x=MsgSource, y=Freq)) + 
  geom_bar(stat="identity") + 
  coord_flip()+
  labs( y='Counts')
ggplotly(p)
```
-->
  
  ## Monsanto twitter account
  
  ```{r}
load("/Users/happyrabbit/Documents/Hui/Data/Twitter/tw_user_mon2016_8_6.RData")
tw_mon<-tw_user_mon%>%twListToDF()
MsgSource<-gsub(".*Twitter for ","",tw_mon$statusSource)
MsgSource<-gsub("</a>","",MsgSource)
MsgSource[grep("Twitter Web Client",MsgSource)]<-"Twitter Web Client"
MsgSource[grep("twitterfeed",MsgSource)]<-"twitterfeed"
MsgSource[grep("TweetDeck",MsgSource)]<-"TweetDeck"
MsgSource[grep("Twitter Ads",MsgSource)]<-"Twitter Ads"
MsgSource[grep("spredfast.com",MsgSource)]<-"spredfast.com"
ts<-table(MsgSource)
MsgSource <-factor(MsgSource, levels=names(ts)[order(ts)])
ts<-data.frame(table(MsgSource))
p<-ggplot(ts, aes(x=MsgSource, y=Freq)) + 
  geom_bar(stat="identity") + 
  coord_flip()+
  labs( y='Counts')
ggplotly(p)
```

## Static Web: Wikipedia

```{r}
read.csv("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/StatisticianR.csv")%>%
  datatable()
```

## Static Web: buzzfeed.com

```{r}
url_parsed <- read_html(urlbuzz)
authors <- html_nodes(url_parsed, css = ".small-meta__item:nth-child(1) a") %>% html_text()
table(authors) %>% sort(decreasing = T) %>% data.frame()%>% datatable()
```

## Static Web: buzzfeed.com

```{r}
titles<-html_nodes(url_parsed, css = ".lede__link") %>%
  html_text()%>%
  str_replace_all("\\n", "")%>%
  str_replace_all("\\t", "")%>% 
  str_trim()
titles=data.frame(titles[-which(titles=="")])
names(titles)<-"Titles"
datatable(titles)
```

## Static Web: Monsanto 

- I know we click, click, copy and paste

<img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/cccv.png" width="500px" />
  
  ## Static Web: Monsanto 
  
  ```{r}
url_parsed <- read_html(urldekalb)
results <- html_nodes(url_parsed, css = ".ba") %>% 
  html_text()%>%
  str_replace_all("\\n", "")%>%
  str_replace_all("\\t", "")%>% 
  str_replace_all("\\r", "")%>% 
  str_trim()
names(results)<-"Dekalb"
Brand<-NULL
Choice<-NULL
for (i in seq_along(results)){
  res<-strsplit(results[i], "         ")[[1]]
  res<-gsub(" *.D","D",res)
  Brand<-c(Brand,rep(res[1],length(res)-1))
  Choice<-c(Choice,res[-1])
}

df<-data.frame(Brand,Choice)
datatable(df)
```

## Static Web? Pioneer

```{r}
url_parsed <- read_html(urlphi)
tables <- html_table(url_parsed, fill = TRUE)
tbf<-tables[[4]]
datatable(tbf)
```

## One Step Further: Natural Language Processing

<img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/nosense.png" width="800px" />
  
  
  ## NLP: How does computer understand language?
  
  ```{r}
load("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/crazylanguage.RData")

names(annotres$token)[3]<-"word"
# plot(annotres,2)
plot(annotres,9)
names(annotres$token)[3]<-"token"
```

## Issue driven

- If you don't know where to go ......

<img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/watch.gif" alt="HTML5 Icon" style="width:300px;height:200px;">

## Issue driven

- If you don't know where to go ...

<img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/watch.gif" alt="HTML5 Icon" style="width:300px;height:200px;">
  
  - If you know where to go ...

<img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/fun.gif" alt="HTML5 Icon" style="width:300px;height:200px;">
  
  ## NLP: What are you interested in? 
  
  ```{r}
token<-data.frame(annotres$token)
ut = universalTagset(token$POS)
idx<-which(ut=="NOUN")
freq=table(token$token[idx])
wordcloud(words=names(freq),freq,min.freq =1,random.color = T,random.order=F,colors=rainbow(7),rot.per=.15)
```

## NLP: What are you interested in? 

```{r}
ptree<-getParse(annotres)
dep<-getDependency(annotres)
senid<-dep$sentence[which(dep$dependent=="English")]
depeng<-dep[which(dep$dependent=="English"),]

for (i in seq_along(depeng$sentence)){
  idx<-depeng$sentence
  getid<-c(depeng[i,]$dependentIdx:depeng[i,]$governorIdx)
  res<-paste(token$token[token$sentence==idx[i]][getid],collapse = " ")
  print(res)
}

names(annotres$token)[3]<-"word"
plot(annotres,2)
# plot(annotres,9)
names(annotres$token)[3]<-"token"
```

## NLP: Ag Forum

```r
library(shiny)
runApp('/Users/happyrabbit/Documents/GitHub/Projects/Shiny/NLP')
```

## Move on

<!--
  <img src="/Users/happyrabbit/Documents/GitHub/Projects/UnstrData/Images/pass-chase.gif" alt="HTML5 Icon" style="width:650px;height:400px;">
  -->
  
  
  