library(shiny)
library(coreNLP)
library(wordcloud)
library(tm)
library(NLP)
#initCoreNLP()
df_encirca<-read.csv("RawData/df_encirca.csv")
df_phi<-read.csv("RawData/df_phi.csv")
df_mon<-read.csv("RawData/df_mon.csv")


## encirca
# get only adv, noun, adj
idx_encirca<-which(df_encirca$UT%in%c("ADV","NOUN","ADJ"))
word_encirca<-tolower(df_encirca$lemma[idx_encirca])
word_encirca=word_encirca[word_encirca!="encirca"]
word_encirca=word_encirca[word_encirca!="field360"]

## pioneer
idx_phi<-which(df_phi$UT%in%c("ADV","NOUN","ADJ"))
word_phi<-tolower(df_phi$lemma[idx_phi])
word_phi=word_phi[word_phi!="pioneer"]
word_phi=word_phi[word_phi!="dupont"]
word_phi=word_phi[word_phi!="download"]
word_phi=word_phi[word_phi!="axis"]
word_phi=word_phi[word_phi!="vt2p"]
word_phi=word_phi[word_phi!="day"]
word_phi=word_phi[word_phi!="genss"]
word_phi=word_phi[word_phi!="seeding.jpg"]
word_phi[word_phi=="guy"]<-"rep"
word_phi[word_phi=="field"]<-"field360"

## Monsanto
idx_mon<-which(df_mon$UT%in%c("ADV","NOUN","ADJ"))
word_mon<-tolower(df_mon$lemma[idx_mon])
word_mon=word_mon[word_mon!="monsanto"]
word_mon=word_mon[word_mon!="dekalb"]
word_mon=word_mon[word_mon!="axis"]
word_mon=word_mon[word_mon!="vt2p"]
word_mon=word_mon[word_mon!="genss"]

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  wordInput<-reactive({
    if (input$topic=="Encirca") {word_encirca}
    else if (input$topic=="Pioneer"){word_phi}
    else {word_mon}
  })
  
  sentenceInput<-reactive({
   if (input$topic=="Encirca") {
   seno<-unique(df_encirca$sentence[df_encirca$lemma==input$checkw])
   sen_encirca<-NULL
   for (i in seno) {
     df<-subset(df_encirca,sentence==i)
     ent<-df$token
     sen<-paste(ent,collapse=" ")
     #wod_encirca<-c(wod_encirca,ent)
     sen_encirca<-c(sen_encirca,sen)
     #df_encirca<-rbind(df_encirca,df)
   }
  sen_encirca
   }
    else if (input$topic=="Pioneer"){
    seno<-unique(df_phi$sentence[df_phi$lemma==input$checkw])
    sen_phi<-NULL
    for (i in seno) {
      df<-subset(df_phi,sentence==i)
      ent<-df$token
      sen<-paste(ent,collapse=" ")
      #wod_phi<-c(wod_phi,ent)
      sen_phi<-c(sen_phi,sen)
      #df_phi<-rbind(df_phi,df)
    }
   sen_phi 
    }
    else {
    seno<-unique(df_mon$sentence[df_mon$lemma==input$checkw])
    sen_mon<-NULL
    for (i in seno) {
      df<-subset(df_mon,sentence==i)
      ent<-df$token
      sen<-paste(ent,collapse=" ")
      #wod_mon<-c(wod_mon,ent)
      sen_mon<-c(sen_mon,sen)
      #df_mon<-rbind(df_mon,df)
    }
    sen_mon
    }
    })
  
  output$caption<-renderText({
    "Origional Message"
  })
    output$sen<-renderPrint({
    print(sentenceInput())
  })
  output$wordcould <- renderPlot({
    wordcloud(words=wordInput(),min.freq =2,random.color = T,random.order=F,colors=rainbow(7))
    })
})
