library(shiny)
# Load in the data
folder <- "E:\\Projects\\manhattanPrep\\"
wf <- read.csv(paste0(folder, "cleanedManhattan.csv"), stringsAsFactors = FALSE)
shinyUI(pageWithSidebar(
  
  headerPanel("Instructor Results"),
  sidebarPanel(
    selectInput("code", 
                "Choose an Instructor Code:",
                choices = names(table(wf$Instructor)), 
                selected = "95"),
    submitButton("Update"),
    h5("Choose an Instructor to see their results.")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("barPlot", height="800px")
  )
))