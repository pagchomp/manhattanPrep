library(shiny)
library(dplyr)
library(ggplot2)

# folder <- "E:\\Projects\\manhattanPrep\\"
folder <- ""
wf <- read.csv(paste0(folder, "cleanedManhattan.csv"), stringsAsFactors = FALSE)
ques <- read.csv(paste0(folder, "GMATrawQues.csv"), stringsAsFactors = FALSE)
ms <- read.csv(paste0(folder, "meanScores.csv"), stringsAsFactors = FALSE)

cols <- c("#D8372E", "#1C1C1E")

# Load in the data
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  # Return the requested dataset
  datasetInput <- reactive({
    # Filter by the chosen Instructor
    filter(wf, Instructor == input$code)
  })
  output$barPlot <- renderPlot({
    ques.df <- datasetInput()
    # Combine the means with the individual selected scores
    temp <- rbind(data.frame(ques.df, "Type" = "Individual"), ms)
    
    # temp$Type <- factor(temp$Type, levels = rev(levels(temp$Type)))
    
    # Generate the plot
    ggplot(data = temp, aes(x = factor(Questions), y = Means, fill = Type)) +
      geom_bar(stat="identity", position = "dodge", color = "black") +
      ylim(0,4.5) +
      ylab("Likert Score") +
      scale_fill_manual(values=cols, drop = FALSE, breaks = c("Mean", "Individual")) +
      xlab("Questions") +
      geom_label(aes(label=round(Means, 2)), position=position_dodge(width=0.9), hjust = 1.5, color = "white") +
      coord_flip() +
      theme_bw()
  })
})