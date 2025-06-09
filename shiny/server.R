library(shinydashboard)
library(shiny)

function(input, output) {
  output$helloWorld <- renderText("Hello World !")
}