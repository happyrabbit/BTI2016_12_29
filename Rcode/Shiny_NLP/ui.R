library(shiny)

# Define UI for dataset viewer application

shinyUI(fluidPage(
  
 # Application title
  
  titlePanel("Ag Forum: Precision Ag Talks"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("checkw","Keyword:","regular"),
      
      selectInput("topic","Choose a topic",
                   choices=c("Encirca","Pioneer","Monsanto"))),
      
    mainPanel(
      h3(textOutput("caption")),

      #tableOutput("view"),
      plotOutput("wordcould"),
      verbatimTextOutput("sen")
    )
  
)))

