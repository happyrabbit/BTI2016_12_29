library(shiny)
library(coreNLP)
library(wordcloud)
library(tm)
library(NLP)
initCoreNLP()
content<-c("Let's face it! English is a crazy language. There is no egg in eggplant nor 
ham in hamburger; neither apple nor pine in pineapple. English muffins weren't invented in England. Quicksand can work slowly, boxing rings are square, and a guinea pig is neither guinea nor is it a pig. 

           And why is it that writers write but fingers don't fing, grocers don't groce and hammers don't ham?
           Doesn't it seem crazy that you can make amends but not one amend? if teachers taught, why don't preachers praught? If a vegetarian eats vegetables, what does a humanitarian eat?
           
           In what other language do people recite at a play and play at a recital? We ship by truck but send cargo by ship. We have noses that run and feet that smell. We park in a driveway and drive in a parkway. And how can a slim chance and a fat chance be the same, while a wise man and a wise guy are opposites? 
           
           You have to marvel at the unique lunacy of a language in which your house can burn up as it burns down, in which you fill in a form by filling it out, and in which an alarm goes off by going on. And, in closing, if father is pop, how come mother's not mop?")

annotres<-annotateString(content)
setwd("/Users/happyrabbit/Documents/GitHub/Projects/UnstrData")
save(annotres,file="crazylanguage.RData")

token<-data.frame(annotres$token)
ut = universalTagset(token$POS)

idx<-which(ut=="NOUN")
token$token[idx]

ptree<-getParse(annotres)
dep<-getDependency(annotres)
head(dep)
senid<-dep$sentence[which(dep$dependent=="English")]
depeng<-dep[which(dep$dependent=="English"),]

for (i in seq_along(depeng$sentence)){
  idx<-depeng$sentence
  getid<-c(depeng[i,]$dependentIdx:depeng[i,]$governorIdx)
  res<-paste(token$token[token$sentence==idx[i]][getid],collapse = " ")
  print(res)
}


sentLen = table(getToken(anno)$sentence)
names(annotres$token)[3]<-"word"
plot(annotres,9)
