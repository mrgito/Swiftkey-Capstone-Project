library(shiny)
library(rmarkdown)
library(markdown)
library(shinydashboard)
# setwd("C:/RSTUDIO/Latihan/PracticalDS/ShinyApp_Reproducible_Project")
rmdfile <- c("About.Rmd")

# Define UI for application that draws a histogram
fluidPage(
  # Application title
  titlePanel("Coursera - JHU Swiftkey Capstone Project, Text Recommender System, with Max 2 last words predictor and 5 predicted words"),

  tabsetPanel(
    tabPanel("Main Page",
             sidebarLayout(
               sidebarPanel(
                 helpText("Please Fill Words/Sentences"),
                 textInput("wordinput", "Please write sentences",
                           value = "Hello")
               ),
               # Show Predicted Words
               mainPanel(
                 h4("Predicted Next word"),
                 verbatimTextOutput("prediction")
               )
             )
    ), tabPanel("Documentation/About",
                mainPanel(
                  includeMarkdown("About.Rmd")
                ))
  )
)

