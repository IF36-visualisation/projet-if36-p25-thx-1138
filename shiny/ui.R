library(shiny)
library(shinydashboard)
library(leaflet)

ui <- dashboardPage(
  dashboardHeader(title = "Données historiques des Jeux Olympiques"),
  
  dashboardSidebar(
    sidebarMenu(id = "sidebar",  # important pour savoir quel tab est actif
                menuItem("Disparités de genre", tabName = "gender_tab", icon = icon("venus-mars")),
                menuItem("Premières participations", tabName = "map_tab", icon = icon("globe")),
                menuItem("Classement des athlètes", tabName = "ranking_tab", icon = icon("trophy")),
                menuItem("Évolution morphologique", tabName = "morpho_tab", icon = icon("ruler"))
                
    ),
    
    # Filtres visibles uniquement dans l'onglet "Disparités de genre"
    conditionalPanel(
      condition = "input.sidebar === 'gender_tab'",
      checkboxGroupInput(
        inputId = "medals",
        label = "Médailles",
        choiceNames = c("Or", "Argent", "Bronze"),
        choiceValues = c("Gold", "Silver", "Bronze"),
        selected = c("Gold", "Silver", "Bronze")
      )
    ),
    
    # Filtres visibles uniquement dans l'onglet "Premières participations des pays"
    conditionalPanel(
      condition = "input.sidebar === 'map_tab'",
      sliderInput("year", "Année :", min = 1896, max = 2016, value = 1896, step = 4, sep = ""),
      selectInput("season", "Saison :", choices = c("Summer", "Winter"), selected = "Summer")
    ),
    conditionalPanel(
      condition = "input.sidebar === 'ranking_tab'",
      checkboxGroupInput(
        inputId = "ranking_medals",
        label = "Filtrer par type de médaille",
        choiceNames = c("Or", "Argent", "Bronze"),
        choiceValues = c("Gold", "Silver", "Bronze"),
        selected = c("Gold", "Silver", "Bronze")
      )
    ),
    
    conditionalPanel(
      condition = "input.sidebar === 'morpho_tab'",
      selectInput("sports_morpho", "Sélectionner les sports :", 
                  choices = NULL, multiple = TRUE, selected = NULL)
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
      ),
      tabItem(
        tabName = "map_tab",
        fluidRow(
          box(
            title = "Carte des premières participations",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            leafletOutput("map", height = 600)
          )
        )
      ),
      tabItem(
        tabName = "ranking_tab",
        fluidRow(
          box(
            title = "Top 20 des athlètes les plus médaillés JO d'été",
            status = "warning",
            solidHeader = TRUE,
            width = 12,
            plotOutput("athlete_ranking")
          )
        )
      ),
      tabItem(
        tabName = "morpho_tab",
        fluidRow(
          box(
            title = "Taille moyenne des athlètes",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            plotOutput("height_trend")
          )
        ),
        fluidRow(
          box(
            title = "Poids moyen des athlètes",
            status = "danger",
            solidHeader = TRUE,
            width = 12,
            plotOutput("weight_trend")
          )
        )
      )
      
      
      
    )
  )
)