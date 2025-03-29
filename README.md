# Analyse des Jeux Olympiques

## Introduction

Nous sommes des étudiants de l'Université de Technologie de Troyes et réalisons ce projet dans le cadre de l’UE **IF36** (intitulée : Visualiser des données). Ce projet nous permet de découvrir et d’acquérir des compétences en **data visualisation**, ainsi que de consolider nos connaissances en **R** à travers l’analyse de données issues des Jeux Olympiques.

L'objectif de notre étude est d’analyser les données des Jeux Olympiques entre **1896 et 2020** afin d’identifier des tendances et répondre à différentes questions. Nous nous interrogerons notamment sur l’impact du pays hôte sur les performances des athlètes nationaux, la répartition géographique des médaillés ou encore la domination de certains pays dans des disciplines spécifiques.

### Données

Pour notre analyse, nous avons sélectionné trois datasets relatifs aux Jeux Olympiques. Ces derniers sont disponibles sur Kaggle :

1. **[Olympics 124 years Dataset(till 2020)](https://www.kaggle.com/datasets/nitishsharma01/olympics-124-years-datasettill-2020)**
   Ce dataset compile des informations détaillées sur les Jeux Olympiques de 1896 à 2020, incluant les athlètes, les épreuves, les sports, les pays et les résultats.
   - **Variables :**  
     - `ID` : Identifiant unique de l'athlète
     - `Name` : Nom de l'athlète
     - `Sex` : Sexe de l'athlète (M/F)
     - `Age` : Age de l'athlète
     - `Team` : Pays représenté
     - `NOC` : Code du pays (Comité National Olympique)
     - `Games` : Année et saison des Jeux (ex: 2016 Summer)
     - `Year` : Année des Jeux
     - `Season` : Saison (Summer/Winter)
     - `City` : Ville hôte des Jeux
     - `Sport` : Sport pratiqué
     - `Event` : Épreuve spécifique
     - `Medal` : Type de médaille remportée (Gold, Silver, Bronze ou None)

2. **[Summer Olympic Medals 1896 - 2020](https://www.kaggle.com/datasets/ramontanoeiro/summer-olympic-medals-1986-2020)**
   Ce dataset se concentre sur le nombre de médailles remportées par chaque pays aux Jeux Olympiques d'été entre 1896 et 2020.
   - **Variables :**
     - `Year` : Année des Jeux
     - `Host_country` : Pays hôte des Jeux
     - `Host_city` : Ville hôte des Jeux
     - `Country_Name` : Nom du pays médaillé
     - `Country_Code` : Code du pays (ex: USA, FRA, GER)
     - `Gold` : Nombre de médailles d’or remportées
     - `Silver` : Nombre de médailles d’argent remportées 
     - `Bronze` : Nombre de médailles de bronze remportées

3. **[Olympics Althlete Events Analysis](https://www.kaggle.com/datasets/samruddhim/olympics-althlete-events-analysis)**
   Ce dataset détaille les participations des athlètes aux épreuves olympiques, incluant des informations sur leurs caractéristiques physiques et leurs performances.
   - **Variables :**
     - `ID` : Identifiant unique de l'athlète
     - `Name` : Nom de l'athlète
     - `Sex` : Sexe de l'athlète (M/F)
     - `Age` : Age de l'athlète
     - `Height` : Taille de l'athlète (cm)
     - `Weight` : Poids de l'athlète (kg)
     - `Team` : Pays ou équipe représentée
     - `NOC` : Code du pays (Comité National Olympique)
     - `Games` : Année et saison des Jeux (ex: 2016 Summer)
     - `Year` : Année des Jeux
     - `Season` : Saison (Summer/Winter)
     - `City` : Ville hôte des Jeux
     - `Sport` : Sport pratiqué
     - `Event` : Épreuve spécifique
     - `Medal` : Type de médaille remportée (Gold, Silver, Bronze ou None)

### Plan d’analyse

Voici les questions que nous souhaitons explorer à travers ces données :

- **Évolution de la participation** : Comment le nombre d'athlètes et de pays participants a-t-il évolué au fil des Jeux Olympiques ?
- **Analyse démographique** : Quelle est la répartition par sexe, âge, taille et poids des athlètes au fil du temps et selon les disciplines ?
- **Performance des pays** : Quels pays ont remporté le plus de médailles au fil des ans ? Existe-t-il des tendances ou des périodes de domination spécifiques ?
- **Impact du pays hôte** : Un pays organisateur a-t-il un avantage en termes de performances et de médailles remportées lorsqu’il accueille les Jeux ? Comment évolue la performance des athlètes locaux par rapport aux éditions précédentes et suivantes ?
- **Analyse des disciplines sportives** : Quels sports ont été les plus compétitifs en termes de nombre de participants et de médailles distribuées ?
- **Corrélations possibles** : Existe-t-il une corrélation entre l'âge des athlètes et leur performance dans certaines disciplines ?
- **Nouveaux sports et épreuves** : Comment l'introduction de nouvelles disciplines a-t-elle influencé la diversité des médaillés et la participation globale ?
- **Analyse des villes hôtes** : Y a-t-il une tendance géographique dans le choix des villes hôtes au fil des années ?
- **Performance individuelle** : Quels athlètes ont remporté le plus de médailles au cours de leur carrière ?
- **Disparités de genre** : Comment la participation et la performance des femmes aux Jeux Olympiques ont-elles évolué depuis leur introduction ?

Pour répondre à ces questions, nous comparerons des variables telles que le nombre d'athlètes, le nombre de pays participants, le nombre de médailles remportées, l'âge des athlètes, etc. Nous devrons également être attentifs aux éventuelles incohérences ou valeurs manquantes dans les données, ainsi qu'aux changements de catégories ou de disciplines au fil du temps, qui pourraient compliquer certaines analyses.