library(shiny)
# Load in the data
cdc <- read.csv("cleaned-cdc-mortality-1999-2010.csv")
# Filter so it's only using 2010's data
cdc <- filter(cdc, Year==2010)
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    # Filter by the chosen cause
    filter(cdc, ICD.Chapter == input$cause)
  })
  
  # Generate a summary of the dataset
  output$barPlot <- renderPlot({
    to.be.sorted <- datasetInput()
    # Sorting by crude rate
    sorted <- to.be.sorted[order(to.be.sorted$Crude.Rate),]
    sorted$State <- factor(sorted$State, levels=unique(as.character(sorted$State)))
    # Plotting
    # Simple error handling
    if (length(sorted$State) > 0){
      ggplot(data=sorted, aes(x=State, y=Crude.Rate, fill=Population)) + 
        geom_bar(stat="identity", position = position_dodge(width=10)) + 
        coord_flip() + 
        ylab("Crude Mortality Rate") + 
        ggtitle(input$cause) +
        theme_bw()
    }
    # Not ideal, but this way nothing has to be changed in the ui file
    else {
      # Plots so that it is still returned
      par(mar = c(0,0,0,0))
      plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
      text(x = 0.5, y = 0.5, "No data available for 2010", 
           cex = 1.6, col = "black")
    }
  })
})
