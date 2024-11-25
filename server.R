#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)
library(tidyverse)
library(tm)
library(ggplot2)
library(RWeka)
library(SnowballC)
library(wordcloud)
library(stringi)
library(stringr)
library(data.table)


# generate bins based on input$bins from ui.R
# We have already got ngram data (monogram,bigram and trigram) from previous task02 project, we will import to server

monogram <- read.csv("C:/RSTUDIO/Latihan/PracticalDS/CAPSTONE/monogram.csv")
bigram <-  read.csv("C:/RSTUDIO/Latihan/PracticalDS/CAPSTONE/bigram.csv")
trigram <- read.csv("C:/RSTUDIO/Latihan/PracticalDS/CAPSTONE/trigram.csv")

# processing ngram into word tables in order to make easy filtering
bigram <- bigram |> separate(word, into = c("word1","word2"))
trigram <- trigram |> separate(word, into = c("word1","word2","word3"))


predict_word <- function(wordinput){
  # input will be cleaned to properly predict next word
  wordinput <- removeNumbers(wordinput)
  wordinput <- removePunctuation(wordinput)
  wordinput <- tolower(wordinput)
  # input will be space delimited and we will focus on last 2 words only to predict 2nd and 3rd word
  word_raw <- unlist(strsplit(wordinput, split = " " ))
  word_raw <- tail(word_raw,2)
  word_raw1 <- word_raw[1]
  word_raw2 <- word_raw[2]
  pred_word <- data.table()
  
  if (length(word_raw) == 0) {
    pred_word <- head(monogram,5)
    pred_word <- pred_word$word
  }
  if (length(word_raw) == 1) {
    pred_word <- head(subset(bigram,word1 == word_raw1),5)
    pred_word <- pred_word$word2
  }
  if (length(word_raw) == 2) {
    pred_word <- head(subset(trigram, word1 == word_raw1 & word2 == word_raw2),5)
    pred_word <- pred_word$word3
  }
  paste0(pred_word,sep = ",")
}

# Define server logic required to draw a histogram
function(input, output, session) {
  data_prediction <- reactive({
    predict_word(input$wordinput)
  })
  
  output$prediction <- renderPrint({
    ds <- data_prediction()
    # data_prediction
  noquote(ds)
  }
  )
}
