library(shiny)
library(readr)
library(tidyverse)
library(magrittr)
library(leaflet)
library(countrycode)
library(sf)
library(rnaturalearth)

server <- function(input, output, session) {
  # --- Chargement des données générales ---
  athletes <- read_csv("../data/Olympics Althlete Events Analysis/athlete_events.csv", show_col_types = FALSE)
  
  # --- Remplir dynamiquement les sports pour le selectInput ---
  observe({
    updateSelectInput(session, "sports_morpho", 
                      choices = sort(unique(na.omit(athletes$Sport))),
                      selected = c("Athletics", "Swimming"))
  })
  
  # --- Disparités de genre ---
  medalists <- athletes %>%
    filter(!is.na(Medal) & !is.na(Age))
  
  summer_medals_sex <- medalists %>%
    filter(Season == "Summer") %>%
    group_by(Year, Medal, Sex) %>%
    summarise(n = n(), .groups = "drop")
  
  output$medalists_sex <- renderPlot({
    req(input$medals)
    
    filtered_data <- summer_medals_sex %>%
      filter(Medal %in% input$medals)
    
    ggplot(filtered_data, aes(x = Year, y = n, fill = Sex)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(
        title = "Nombre d'hommes (M) et de femmes (F) médaillés par édition",
        subtitle = paste("Médailles sélectionnées :", paste(input$medals, collapse = ", "))
      ) +
      theme_minimal()
  })
  
  # --- Carte des premières participations ---
  team_iso <- athletes %>%
    mutate(
      iso3 = ifelse(Team %in% c("France", "Norway"),
                    NA_character_,
                    countrycode(Team, origin = "country.name", destination = "iso3c"))
    ) %>%
    filter(!is.na(iso3) | Team %in% c("France", "Norway")) %>%
    distinct(Team, iso3, Year, Season)
  
  first_participation_iso <- team_iso %>%
    group_by(iso3, Season) %>%
    summarise(first_year = min(Year), .groups = "drop") %>%
    filter(!is.na(iso3))
  
  first_participation_nom <- team_iso %>%
    filter(Team %in% c("France", "Norway")) %>%
    group_by(Team, Season) %>%
    summarise(first_year = min(Year), .groups = "drop")
  
  world <- ne_countries(scale = "medium", returnclass = "sf") %>%
    mutate(iso_a3 = ifelse(iso_a3 == "-99", adm0_a3, iso_a3))
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron") %>%
      setView(0, 20, zoom = 2)
  })
  
  observe({
    selected_iso3 <- first_participation_iso %>%
      filter(Season == input$season, first_year <= input$year) %>%
      pull(iso3)
    
    selected_nom <- first_participation_nom %>%
      filter(Season == input$season, first_year <= input$year) %>%
      pull(Team)
    
    map_data <- world %>%
      mutate(
        highlight_iso = iso_a3 %in% selected_iso3,
        highlight_nom = name %in% selected_nom,
        highlight = highlight_iso | highlight_nom
      )
    
    leafletProxy("map") %>%
      clearShapes() %>%
      addPolygons(
        data = map_data,
        fillColor = ~ifelse(highlight, "orange", "lightgray"),
        fillOpacity = 0.7,
        weight = 0.5,
        color = "#444444"
      )
  })
  
  # --- Classement des athlètes ---
  # Chargement des données été
  data_summer <- read_csv("../data/Olympics_124_years_Dataset/Athletes_summer_games.csv", show_col_types = FALSE)
  
  # Filtrage initial : uniquement les lignes avec une médaille
  data_medals_ranking <- data_summer %>%
    filter(!is.na(Medal) & Medal != "")
  
  # Graphique des 20 meilleurs athlètes selon le type de médaille sélectionné
  output$athlete_ranking <- renderPlot({
    req(input$ranking_medals)  # Nécessaire au bon fonctionnement
    
    # Regrouper les données selon le type de médaille sélectionné
    filtered_medals <- data_medals_ranking %>%
      filter(Medal %in% input$ranking_medals) %>%
      group_by(Name, Sport, Medal) %>%
      summarise(count = n(), .groups = "drop") %>%
      pivot_wider(
        names_from   = Medal,
        values_from  = count,
        values_fill  = list(count = 0),
        names_expand = TRUE
      )
    
    # Identifier les colonnes disponibles
    available_medals <- intersect(c("Gold", "Silver", "Bronze"), colnames(filtered_medals))
    
    # Calcul du total par athlète
    filtered_medals <- filtered_medals %>%
      mutate(total = rowSums(across(all_of(available_medals)))) %>%
      {
        if ("Gold" %in% available_medals) {
          arrange(., desc(total), desc(Gold))
        } else {
          arrange(., desc(total))
        }
      } %>%
      slice_head(n = 20) %>%
      mutate(Name_Sport = paste0(Name, " (", Sport, ")"))
    
    # Transformation en format long uniquement sur les colonnes présentes
    medals_long <- filtered_medals %>%
      select(all_of(c("Name_Sport", available_medals))) %>%
      pivot_longer(
        cols = all_of(available_medals),
        names_to = "Medal_Type",
        values_to = "Count"
      ) %>%
      mutate(
        Medal_Type = factor(Medal_Type, levels = c("Gold", "Silver", "Bronze")),
        Name_Sport = reorder(Name_Sport, Count, FUN = sum)
      )
    
    # Graphique
    ggplot(medals_long, aes(x = Count, y = Name_Sport, fill = Medal_Type)) +
      geom_col(position = "stack", width = 0.7) +
      scale_fill_manual(values = c("Gold" = "#FFD700", "Silver" = "#C0C0C0", "Bronze" = "#CD7F32")) +
      labs(
        title = "Les 20 athlètes les plus médaillés aux JO d'été",
        subtitle = paste("Médailles sélectionnées :", paste(input$ranking_medals, collapse = ", ")),
        x = "Nombre de médailles",
        y = "Athlète (Sport)",
        fill = "Type de médaille"
      ) +
      theme_minimal(base_size = 12) +
      theme(
        plot.title = element_text(hjust = 1, face = "bold"),
        legend.position = "bottom",
        plot.subtitle = element_text(hjust = 0.5),
        plot.margin = margin(0, 0, 0, -15, "pt")
      )
  })
  
  # --- Taille moyenne des athlètes ---
  output$height_trend <- renderPlot({
    req(input$sports_morpho)
    
    avg_height <- athletes %>%
      filter(!is.na(Height), Sport %in% input$sports_morpho) %>%
      group_by(Year, Sport) %>%
      summarise(mean_height = mean(Height), .groups = "drop")
    
    ggplot(avg_height, aes(x = Year, y = mean_height, color = Sport)) +
      geom_line(size = 1) +
      labs(
        title = "Évolution de la taille moyenne des athlètes",
        x = "Année",
        y = "Taille moyenne (cm)"
      ) +
      theme_minimal()
  })
  
  
  # --- Poids moyen des athlètes ---
  output$weight_trend <- renderPlot({
    req(input$sports_morpho)
    
    avg_weight <- athletes %>%
      filter(!is.na(Weight), Sport %in% input$sports_morpho) %>%
      group_by(Year, Sport) %>%
      summarise(mean_weight = mean(Weight), .groups = "drop")
    
    ggplot(avg_weight, aes(x = Year, y = mean_weight, color = Sport)) +
      geom_line(size = 1) +
      labs(
        title = "Évolution du poids moyen des athlètes",
        x = "Année",
        y = "Poids moyen (kg)"
      ) +
      theme_minimal()
  })
  
  
}