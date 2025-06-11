library(shinydashboard)
library(shiny)

dashboardPage(
  dashboardHeader(title = "Données historiques des Jeux Olympiques"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Disparités de genre", tabName = "gender_tab", icon = icon("venus-mars")),
      checkboxGroupInput(
        inputId = "medals",
        label = "Médailles",
        choiceNames = c("Or", "Argent", "Bronze"),
        choiceValues = c("Gold", "Silver", "Bronze"),
        selected = c("Gold", "Silver", "Bronze")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "gender_tab",
        fluidRow(
          box(
            title = "Évolution par sexe",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotOutput("medalists_sex")
          )
        )
      )
    )
  )
)
