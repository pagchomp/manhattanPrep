library(shiny)
library(shinythemes)
# Load in the data
# folder <- "E:\\Projects\\manhattanPrep\\"
folder <- ""
wf <- read.csv(paste0(folder, "cleanedManhattan.csv"), stringsAsFactors = FALSE)
# Fix so the numbers are ordered correctly
wf$Instructor <- as.numeric(wf$Instructor)
wf <- wf[order(wf$Instructor),]

fluidPage(
  # Set The theme color
  theme = shinytheme("cyborg"),
  titlePanel("Manhattan Prep Demo"),
  # Create the page
  pageWithSidebar(
    # Add Manhattan Prep logo
    headerPanel(img(src = 'logo.png', align = "center")),
    # Create the sidebar selector for each instructor
    sidebarPanel(
      selectInput("code", 
                  "Instructor Code:",
                  choices = names(table(wf$Instructor)), 
                  selected = "95"),
      submitButton("Update"),
      h5("Choose an Instructor to see their results.")
  ),
  # Show the plot
    mainPanel(
      plotOutput("barPlot", height="800px")
    )
  )
)