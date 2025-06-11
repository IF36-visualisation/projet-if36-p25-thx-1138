library(shinydashboard)
library(shiny)
library(readr)
library(magrittr)
library(tidyverse)

# Chargement des données
athletes <- read_csv("../data/Olympics Althlete Events Analysis/athlete_events.csv", show_col_types = FALSE)

# Traitements sur les données chargées
medalists <- athletes %>%
  filter(!is.na(Medal) & !is.na(Age)) 

summer_medals_sex <- medalists %>%
  filter(Season == "Summer" )%>%
  group_by(Year, Medal) %>%
  count(Sex, Medal)

function(input, output) {
  # Graphique sur les disparités de genre
  output$medalists_sex <- renderPlot({
    # Si aucun choix, ne rien afficher
    req(input$medals)
    
    # Filtrage dynamique selon les médailles sélectionnées
    filtered_data <- summer_medals_sex %>%
      filter(Medal %in% input$medals)
    
    ggplot(filtered_data, aes(x = Year, y = n, fill = Sex)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = paste("Nombre d'hommes (M) et de femmes (F) médaillés par édition"),
        subtitle = paste("Médailles sélectionnées :", paste(input$medals, collapse = ", "))
      ) +
      theme_minimal()
  })
  
  output$helloWorld <- renderText("Hello World !")
}