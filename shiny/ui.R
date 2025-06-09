library(shinydashboard)
library(shiny)

dashboardPage(
  dashboardHeader(title = "Données historiques des Jeux Olympiques"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      valueBox(
        value = textOutput("helloWorld"),
        color = "aqua",
        subtitle = "Hello"
      )
    )
  )
)