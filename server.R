library(pdftables)
library(shiny)
library(dplyr)
library(ggplot2)

folder <- "E:\\Projects\\manhattanPrep\\"
# folder <- "C:\\Users\\bmburk\\Dropbox\\manhattanPrep\\"
api.key <- read.table(paste0(folder, "convertAPIKey"), header = F)[[1]]
wf <- read.csv(paste0(folder, "GMATraw.csv"), stringsAsFactors = FALSE)
names(wf)[1] <- "SID"
kable(head(wf)[,1:21], longtable = TRUE)
kable(head(wf)[,22:38], longtable = TRUE)
ques <- read.csv(paste0(folder, "GMATrawQues.csv"), stringsAsFactors = FALSE)
names(wf) <- ques[,2]
nrow(wf)
# convert_pdf(paste0(folder, "CodeSheet.pdf"), paste0(folder, "codesheetcsv.csv"), api_key = api.key)
cs <- read.csv(paste0(folder, "codesheetcsv.csv"), skip = 2, stringsAsFactors = FALSE)
cat(paste(1:nrow(ques), ques[,2], " \n"))


# Load in the data
# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    # Filter by the chosen cause
    filter(wf, 'Lead Instructor Code' == input$cause)
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
