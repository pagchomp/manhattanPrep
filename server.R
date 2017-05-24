library(shiny)
library(dplyr)
library(ggplot2)

folder <- "E:\\Projects\\manhattanPrep\\"
wf <- read.csv(paste0(folder, "cleanedManhattan.csv"), stringsAsFactors = FALSE)
ques <- read.csv(paste0(folder, "GMATrawQues.csv"), stringsAsFactors = FALSE)

# Load in the data
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    # Filter by the chosen Instructor
    filter(wf, Instructor == input$code)
  })
  
  # Generate a summary of the dataset
  output$barPlot <- renderPlot({
    ques.df <- datasetInput()
    ggplot(data = ques.df, aes(x = factor(Questions), y = Means)) + 
      geom_bar(stat="identity", position = position_dodge(width=10)) + 
      ylim(0,4) +
      coord_flip() +
      ylab("Likert Score") +
      xlab("Questions") +
      ggtitle(paste("Instructor", input$code)) +
      theme_bw()
  })
})
