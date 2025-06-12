# Analyse des Jeux Olympiques

## Introduction

Nous sommes des étudiants de l'Université de Technologie de Troyes et réalisons ce projet dans le cadre de l’UE **IF36** (intitulée : Visualiser des données). Ce projet nous permet de découvrir et d’acquérir des compétences en **data visualisation**, ainsi que de consolider nos connaissances en **R** à travers l’analyse de données issues des Jeux Olympiques.

L'objectif de notre étude est d’analyser les données des Jeux Olympiques entre **1896 et 2020** afin d’identifier des tendances et répondre à différentes questions. Nous nous interrogerons notamment sur l’impact du pays hôte sur les performances des athlètes nationaux, la répartition géographique des médaillés ou encore la domination de certains pays dans des disciplines spécifiques.

---

### Données

Pour notre analyse, nous avons sélectionné trois datasets relatifs aux Jeux Olympiques. Ces derniers sont disponibles sur Kaggle :

#### 1. **[Olympics 124 years Dataset(till 2020)](https://www.kaggle.com/datasets/nitishsharma01/olympics-124-years-datasettill-2020)**

##### Nombre d'observations et de variables

Le dataset contient **environ 238 000 observations** et **13 variables**. Chaque ligne représente un athlète ayant participé à une épreuve spécifique lors des Jeux Olympiques d’été entre **1896 et 2020**.

##### Description des variables

- **Identifiants uniques** :
  - `ID` : Identifiant unique de l'entrée associant un athlète à une épreuve lors d'une session des jeux.
  - `Name` : Nom de l’athlète

- **Informations démographiques** :
  - `Sex` : Sexe de l’athlète (`M` / `F`)
  - `Age` : Âge de l’athlète (valeurs entre **10 et 97 ans**, avec une moyenne de **25,7 ans**)

- **Données liées au pays** :
  - `Team` : Nom du pays représenté
  - `NOC` : Code du Comité National Olympique

- **Données sur l’édition des JO** :
  - `Games` : Année et saison des JO (`ex: 2020 Summer`)
  - `Year` : Année des JO (de **1896 à 2020**)
  - `Season` : Saison (`Summer` ou `Winter`)
  - `City` : Ville hôte

- **Données sportives et résultats** :
  - `Sport` : Discipline sportive
  - `Event` : Épreuve spécifique
  - `Medal` : Type de médaille remportée (`Gold`, `Silver`, `Bronze`, ou `None`, dans le dernier cas le champ est simplement vide)

On mentionnera également le fichier [regions.csv](https://github.com/IF36-visualisation/projet-if36-p25-thx-1138/blob/master/data/Olympics_124_years_Dataset/regions.csv) reprenant le `NOC` et l'associant à la région de ce comité ainsi qu'à une note éventuelle le concernant. Celui-ci nous permettra éventuellement d'obtenir des informations complémentaires rendant certains résultats plus clairs.

##### Origine et pertinence du dataset
Ce dataset provient de **Kaggle** et a été sélectionné pour son **exhaustivité et sa richesse en informations**, couvrant plus d’un siècle de compétitions olympiques. Il permet d’analyser :
- **L’évolution des Jeux Olympiques**, du nombre d’athlètes et de pays participants
- **Les performances des nations et des athlètes**
- **Les tendances historiques** influencées par les guerres, boycotts et changements de règlements
- **Les disparités de genre dans le sport olympique**

Il s’intègre parfaitement dans notre projet sur la **visualisation et l’analyse des tendances olympiques**.

##### Format et structure des données

Le dataset est en **format CSV**, structuré de manière tabulaire et exploitable avec des outils de **data science** comme **R (tidyverse, ggplot2, dplyr)**.

- **Types de variables** :
  - **Catégoriques** : `Sex`, `Team`, `NOC`, `Games`, `Season`, `City`, `Sport`, `Event`, `Medal`
  - **Numériques** : `Age`, `Year`
  - **Identifiants uniques** : `ID`

- **Données manquantes** :
  - `Age` : 4 % de valeurs manquantes (≈ 9 189 observations)  
  - `Medal` : Contient de nombreuses valeurs `None`, représentant les athlètes n’ayant pas remporté de médaille.



**Catégories et sous-groupes dans les données**  
Le dataset peut être divisé en plusieurs groupes d’analyse :  
1. **Par saison** : Jeux d’été & jeux d'hiver 
2. **Par pays** : Comparaison des performances via `Team` et `NOC`
3. **Par discipline** : Étude des sports les plus compétitifs et leur évolution
4. **Par médaille** : Analyse des athlètes et pays ayant remporté le plus de médailles
5. **Par période historique** : Impact des guerres, boycotts et modifications des règles

Ce dataset offre une **opportunité unique d’explorer les tendances des JO**, aussi bien sur le plan **démographique, sportif que géopolitique**.


####  2. **[Summer Olympic Medals 1896 - 2020](https://www.kaggle.com/datasets/ramontanoeiro/summer-olympic-medals-1986-2020)**

##### Nombre d'observations et de variables
Le dataset contient **1344 observations** et **8 variables**. Chaque ligne représente le nombre de médailles remportées par un pays lors d’une édition des Jeux Olympiques d’été entre **1896 et 2020**.

##### Description des variables

- **Informations sur l’édition des JO** :
  - `Year` : Année des Jeux
  - `Host_country` : Pays hôte des Jeux
  - `Host_city` : Ville hôte des Jeux

- **Données sur les pays participants** :
  - `Country_Name` : Nom du pays participant
  - `Country_Code` : Code du pays (ex: USA, FRA, GER)

- **Données sur les médailles remportées par le pays participant** :
  - `Gold` : Nombre de médailles d’or remportées
  - `Silver` : Nombre de médailles d’argent remportées
  - `Bronze` : Nombre de médailles de bronze remportées

##### Origine et pertinence du dataset

Ce dataset provient de **Kaggle** et se concentre sur la **performance des pays aux Jeux Olympiques d’été** à travers le nombre de médailles obtenues. Il est pertinent pour analyser :  
- **L’évolution des performances des pays** sur plus d’un siècle de compétitions
- **Les tendances en matière de domination olympique** et l’impact des pays hôtes
- **L’influence des guerres, boycotts et autres événements historiques** sur la répartition des médailles
- **Les variations de performances des nations émergentes et puissances sportives historiques**

Ce dataset s’intègre parfaitement dans un projet de **visualisation et d’analyse des performances olympiques par pays**.

##### Format et structure des données

Le dataset est en **format CSV**, organisé sous une structure tabulaire exploitable avec des outils de **data science** comme **R (tidyverse, ggplot2, dplyr)**.

- **Types de variables** :
  - **Catégoriques** : `Host_country`, `Host_city`, `Country_Name`, `Country_Code`
  - **Numériques** : `Year`, `Gold`, `Silver`, `Bronze`

- **Données manquantes** :
  - `Country_Code` : 6 % de valeurs manquantes (86 observations)

**Catégories et sous-groupes dans les données**  
Ce dataset peut être segmenté selon plusieurs axes d’analyse :  
1. **Par édition des JO** : Comparaison des performances des pays sur chaque édition
2. **Par pays** : Évolution des performances d’un pays à travers les différentes années
3. **Par type de médaille** : Répartition des médailles d’or, d’argent et de bronze
4. **Par pays hôte** : Étude de l’impact du pays hôte sur la répartition des médailles
5. **Par période historique** : Influence des événements géopolitiques sur les résultats

Ce dataset constitue une **ressource précieuse pour étudier les performances olympiques des nations** et comprendre **l’évolution des tendances sportives au fil du temps**.

#### 3. **[Olympics Athlete Events Analysis](https://www.kaggle.com/datasets/samruddhim/olympics-althlete-events-analysis)**

##### Nombre d'observations et de variables

Le dataset contient **environ 271 000 observations** et **15 variables**. Chaque ligne représente un athlète ayant participé à une épreuve spécifique lors des Jeux Olympiques d'été et d'hiver, depuis **1896**.

##### Description des variables

- **Identifiants uniques** :
  - `ID` : Identifiant unique de l'athlète  
  - `Name` : Nom de l’athlète  

- **Informations démographiques** :
  - `Sex` : Sexe de l’athlète (`M` / `F`)  
  - `Age` : Âge de l’athlète (valeurs entre **10 et 97 ans**, avec une moyenne de **25,7 ans**)  

- **Données liées au pays** :
  - `Team` : Nom du pays représenté  
  - `NOC` : Code du Comité National Olympique  

- **Données sur l’édition des JO** :
  - `Games` : Année et saison des JO (`ex: 2020 Summer`)  
  - `Year` : Année des JO (de **1896 à 2020**)  
  - `Season` : Saison (`Summer` / `Winter`)  
  - `City` : Ville hôte  

- **Données sportives et résultats** :
  - `Sport` : Discipline sportive  
  - `Event` : Épreuve spécifique  
  - `Medal` : Type de médaille remportée (`Gold`, `Silver`, `Bronze`, ou `None`)  

##### Origine et pertinence du dataset

Ce dataset provient de **Kaggle** et a été sélectionné pour son **exhaustivité et sa richesse en informations**, couvrant plus d’un siècle de compétitions olympiques. Il permet d’analyser :
- **L’évolution des Jeux Olympiques**, du nombre d’athlètes et de pays participants
- **Les performances des nations et des athlètes**
- **Les tendances historiques** influencées par les guerres, boycotts et changements de règlements
- **Les disparités de genre dans le sport olympique**

Ce dataset est particulièrement pertinent pour les projets d'**analyse de données sportives** et peut être utilisé pour la **visualisation** et l’**analyse des tendances olympiques**.

##### Format et structure des données

Le dataset est en **format CSV**, structuré de manière tabulaire et exploitable avec des outils de **data science** comme **R (tidyverse, ggplot2, dplyr)**.

- **Types de variables** :
  - **Catégoriques** : `Sex`, `Team`, `NOC`, `Games`, `Season`, `City`, `Sport`, `Event`, `Medal`
  - **Numériques** : `Age`, `Year`
  - **Identifiants uniques** : `ID`

- **Données manquantes** :
  - `Age` : 4 % de valeurs manquantes (≈ 9 189 observations)  
  - `Medal` : Contient de nombreuses valeurs `None`, représentant les athlètes n’ayant pas remporté de médaille.

**Catégories et sous-groupes dans les données**  
Le dataset peut être divisé en plusieurs groupes d’analyse :
1. **Par saison** : Jeux d’été (`Summer`) et d’hiver (`Winter`)
2. **Par pays** : Comparaison des performances via `Team` et `NOC`
3. **Par discipline** : Étude des sports les plus compétitifs et leur évolution
4. **Par médaille** : Analyse des athlètes et pays ayant remporté le plus de médailles
5. **Par période historique** : Impact des guerres, boycotts et modifications des règles

Ce dataset offre une **opportunité unique d’explorer les tendances des JO**, aussi bien sur le plan **démographique, sportif que géopolitique**.

---

### Plan d’analyse

Voici les questions que nous souhaitons explorer à travers ces données :

- **Évolution de la participation** : Comment le nombre d'athlètes et de pays participants a-t-il évolué au fil des Jeux Olympiques ?
- **Analyse morphologique** : Quelle est la répartition par taille et poids des athlètes au fil du temps et selon les disciplines ?
- **Performance des pays** : Quels pays ont remporté le plus de médailles au fil des ans ? Existe-t-il des tendances ou des périodes de domination spécifiques ? Le nombre d'habitants est il corrélé avec le nombre de médailles ? Y'a-t-il des pays qui ne sont performant que dans une catégorie de sport (collectif, combat...) ?
- **Impact du pays hôte** : Un pays organisateur a-t-il un avantage en termes de performances et de médailles remportées lorsqu’il accueille les Jeux ? Comment évolue la performance des athlètes locaux par rapport aux éditions précédentes et suivantes ? Y'a il un impact géographique sur les performances des athlètes (exemple :altitude)
- **Analyse des disciplines sportives** : Quels sports ont été les plus compétitifs en termes de nombre de participants et de médailles distribuées ?
- **Corrélations possibles** : Existe-t-il une corrélation entre l'âge des athlètes et leur performance dans certaines disciplines ?
- **Nouveaux sports et épreuves** : Comment l'introduction de nouvelles disciplines a-t-elle influencé la diversité des médaillés et la participation globale ? Le nombre d'épreuve a-t-il augmenté au cours du temps ?
- **Analyse des villes hôtes** : Y a-t-il une tendance géographique dans le choix des villes hôtes au fil des années ?
- **Performance individuelle** : Quels athlètes ont remporté le plus de médailles au cours de leur carrière ?
- **Disparités de genre** : Comment la participation et la performance des femmes aux Jeux Olympiques ont-elles évolué depuis leur introduction ?
- **Effets des boycotts et des conflits** : Quels ont été les impacts des boycotts et des guerres sur les Jeux Olympiques en termes de participation et de performances des nations concernées ?
- **Influence économique et politique** : Y a-t-il une relation entre le niveau économique d’un pays et son nombre de médailles remportées ? Les périodes de tensions politiques ou de crises économiques ont-elles eu un impact sur la participation et les performances ?


Pour répondre à ces questions, nous comparerons des variables telles que le nombre d'athlètes, le nombre de pays participants, le nombre de médailles remportées, l'âge des athlètes, etc. Nous devrons également être attentifs aux éventuelles incohérences ou valeurs manquantes dans les données, ainsi qu'aux changements de catégories ou de disciplines au fil du temps, qui pourraient compliquer certaines analyses. La comparabilité entre différentes époques constitue également un enjeu majeur, car les règlements et les disciplines olympiques ont évolué au fil du temps, impactant les performances et les classements. De plus, des événements historiques tels que les boycotts ou les guerres ont parfois limité la participation de certains pays, ce qui pourrait biaiser certaines analyses. Il sera donc essentiel de prendre en compte ces facteurs pour garantir la pertinence et la fiabilité des conclusions.
