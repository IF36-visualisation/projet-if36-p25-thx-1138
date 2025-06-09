library(shinydashboard)
library(shiny)

dashboardPage(
  dashboardHeader(title = "Données historiques des Jeux Olympiques"),
  dashboardSidebar(
    checkboxGroupInput(
      inputId = "medals",
      label = NULL,
      choiceNames = c("Or", "Argent", "Bronze"),
      choiceValues = c("Gold", "Silver", "Bronze")
    )
  ),
  dashboardBody(
    fluidRow(
      box(plotOutput("medalists_sex"))
    )
  )
)