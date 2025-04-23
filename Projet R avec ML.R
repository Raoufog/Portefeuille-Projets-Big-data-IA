
-------------------------------------#Etape 1 :Contexte et problématique---------------------------------------------------------------------------

#Contexte : Nous avons souhaité  travailler sur un avec des données sur la consommation annuelle d'électricité 
#et de gaz par région en France, dans un but de compréhension des tendances de consommation d'énergie au niveau régional. 

#Problématique : Doit-on investir plus sur le gaz ou l'électricité ? Et pourquoi?

#Comment la consommation d'électricité et de gaz varie-t-elle selon les régions ? 
#Quels facteurs influencent cette consommation ? 
#Peut-on prédire la consommation future en fonction des données actuelles ?

#Pourquoi?
#Ces informations peuvent être utilisées :
#-pour explorer l'efficacité énergétique, 
#-la planification des ressources, ou des politiques de réduction des émissions de gaz à effet de serre.

----------------------------------------#Etapes 2 Collecte et nettoyage (Importer)---------------------------------------------------------------------------


# Charger les bibliothèques nécessaires
library(readxl)  # Pour lire les fichiers Excel
library(dplyr)   # Pour manipulation des données
library(tidyr)   # Pour nettoyage des données
library(ggplot2) # pour la visualisation graphique
library(janitor) #Pour suppression des lignes avec valeur manquante
library(readxl)

library(readxl)
electricité_et_gaz_consommation_2018_2023 <- read_excel("C:/Users/AURIANE H/OneDrive/Bureau/MBA Innovation Tech, Bigdata  et IA/Programmation R/Projet R Groupe/electricité et gaz consommation 2018-2023.xlsx")
View(electricité_et_gaz_consommation_2018_2023)

# Afficher les premières lignes pour inspecter les données
data <- electricité_et_gaz_consommation_2018_2023
head(data)

# Vérifier les types de données et les valeurs manquantes
str(data)

# Nettoyage des données : suppression des lignes vides ou inutiles, correction des noms de colonnes
library(tidyr)
data_clean <- data %>% data_clean() %>% # Suppression des lignes avec valeurs manquantes
data_clean <- data

# Remplacement des valeur manquante 
data_clean$'Conso totale (MWh)'<- ifelse(
  is.na(data_clean$'Conso totale (MWh)'),  
  median(data_clean$'Conso totale (MWh)', na.rm = TRUE),
  data_clean$'Conso totale (MWh)'
)
# suppression colonne conso moyenne
data_clean <- data_clean %>% select(-`Conso moyenne (MWh)`)

head(data_clean)

-------------------------------------------#Etapes 3 Exploration des données---------------------------------------------------------------------------------

# Résumé statistique des données
summary(data_clean)

library(ggplot2)
library (scales)

# Graphique pour la consommation de Gaz par region
head(data_clean)
data_gaz <- data_clean %>%
  filter(FILIERE == "Gaz")

#Visuel
ggplot(data_gaz, aes(x = `Nom Région`, y = `Conso totale (MWh)`)) +
  geom_bar(stat = "identity", fill = "blue") +
  scale_y_continuous(
    labels = label_number(accuracy = 1, scale = 1e-6) 
  ) +
  labs(
    title = "Consommation de Gaz par Région",
    x = "Région",
    y = "Consommation (en million de MWh)" 
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Graphique pour la consommation de l'Electricité par region
head(data_clean)
data_elec <- data_clean %>%
  filter(FILIERE == "Electricité")
#visuel
ggplot(data_elec, aes(x = `Nom Région`, y = `Conso totale (MWh)`)) +
  geom_bar(stat = "identity", fill = "red") +
  scale_y_continuous(
    labels = label_number(accuracy = 1, scale = 1e-6) 
  ) +
  labs(
    title = "Consommation d'Electricité par Région",
    x = "Région",
    y = "Consommation (en million de MWh)" 
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
 
#Comparaison Gaz et électricité

# Filtrer uniquement Gaz et Electricité
data_energie <- data_clean %>%
  filter(FILIERE %in% c("Gaz", "Electricité"))

# Graphique comparatif
ggplot(data_energie, aes(x = `Nom Région`, y = `Conso totale (MWh)`, fill = FILIERE)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("Electricité" = "blue", "Gaz" = "red")) + 
  scale_y_continuous(
    labels = label_number(accuracy = 1, scale = 1e-6) 
  )+
  labs(
    title = "Comparaison Gaz vs Électricité par Région",
    x = "Région",
    y = "Consommation (en million de MWh)",
    fill = "Filière"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

---# Analyse comparatif
  #L’analyse montre que la consommation d’électricité est dominante dans certaines régions tandis que d’autres 
  #consomment davantage de gaz. 
  #Ces différences traduisent des usages et des besoins énergétiques variés selon les territoires.

  #Recommandation
  #Il est recommandé d’adapter les politiques énergétiques régionales en fonction des profils de consommation, 
  #en renforçant les infrastructures électriques dans les zones fortement électrifiées, tout en optimisant 
  #l'approvisionnement en gaz là où il reste essentiel.

------------------------------------------# Etapes 4 Entrainement du modèles (Regresion lineaire)----------------------------------------------------------------------------------
# Charger les librairies
library(caret)   # Pour la partition des données
library(Metrics) # Pour les métriques d’évaluation

# 1. Préparation des données
data_model <- data_clean %>%
  select(`Conso totale (MWh)`, FILIERE, Année, `Nom Région`) %>%
  mutate(FILIERE = as.factor(FILIERE),
         `Nom Région` = as.factor(`Nom Région`))

head(data_model)

data_model <- data_model %>%
  filter(!is.na(`Conso totale (MWh)`))

# 2. Séparer les données (70% train, 30% test)
set.seed(123)
trainIndex <- createDataPartition(data_model$`Conso totale (MWh)`, p = 0.7, list = FALSE)

train_data <- data_model[trainIndex, ]
test_data  <- data_model[-trainIndex, ]

# 3. Créer un modèle de régression linéaire simple
model <- lm(`Conso totale (MWh)` ~ FILIERE + Année + `Nom Région`, data = train_data)

# Résumé du modèle
summary(model)

# 4. Prédictions sur les données de test
predictions <- predict(model, newdata = test_data)

#courbe Suivant la droite affine
ggplot(test_data, aes(x = `Conso totale (MWh)`, y = predictions)) +
  geom_point(color = "steelblue", size = 2) +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  geom_smooth(method = "lm", se = FALSE, color = "darkgreen") +
  coord_equal() +
  theme_minimal() +
  labs(
    title = "Valeurs réelles vs. Prédictions",
    x = "Consommation réelle (MWh)",
    y = "Consommation prédite (MWh)"
  )

# Ajustement du modèle polynomial (degré 2)
modele_poly <- lm(`Conso totale (MWh)` ~ poly(predictions, 2), data = test_data)
# Prédictions avec le modèle polynomial
test_data$pred_poly <- predict(modele_poly, newdata = test_data)

ggplot(test_data, aes(x = predictions, y = `Conso totale (MWh)`)) +
  geom_point(color = "steelblue", size = 2) +  # Points réels
  geom_line(aes(y = pred_poly), color = "darkgreen", size = 1.2) +  # Courbe polynomial
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +  # Ligne parfaite
  theme_minimal() +
  labs(
    title = "Régression polynomiale : Prédictions vs Réalité",
    x = "Prédictions (MWh)",
    y = "Consommation réelle (MWh)"
  )
-----------------------------------------# Etapes 5 Evaluation du modèle ------------------------------------------------------------------------------------

# 5. Évaluation de la performance suiviant la regression linéaire simple
real_values <- test_data$`Conso totale (MWh)`

# RMSE
rmse <- sqrt(mean((test_data$`Conso totale (MWh)` - test_data$pred_poly)^2))

# MAE
mae <- mean(abs(test_data$`Conso totale (MWh)` - test_data$pred_poly))

# R² (à partir du modèle directement)
r2 <- summary(modele_poly)$r.squared

# Affichage
cat("Évaluation du modèle polynomial :\n")
cat(" - RMSE :", round(rmse, 2), "MWh\n")
cat(" - MAE  :", round(mae, 2), "MWh\n")
cat(" - R²   :", round(r2, 4), "\n")

modele_lm <- lm(`Conso totale (MWh)` ~ predictions, data = test_data)
summary(modele_lm)$r.squared  # R² linéaire

-----------analyse des deux modèles------------

# Modèle linéaire
modele_lm <- lm(`Conso totale (MWh)` ~ predictions, data = test_data)

# Modèle polynomial (de degré 2 ici, modifiable)
modele_poly <- lm(`Conso totale (MWh)` ~ poly(predictions, 2), data = test_data)

# Prédictions des deux modèles
test_data$pred_lm <- predict(modele_lm, newdata = test_data)
test_data$pred_poly <- predict(modele_poly, newdata = test_data)


ggplot(test_data, aes(x = predictions, y = `Conso totale (MWh)`)) +
  geom_point(color = "gray40", size = 2, alpha = 0.6) +  # Points réels
  geom_line(aes(y = pred_lm), color = "blue", size = 1, linetype = "dashed") +  # Régression linéaire
  geom_line(aes(y = pred_poly), color = "darkgreen", size = 1) +  # Régression polynomiale
  labs(
    title = "Comparaison Modèle Linéaire vs. Polynomial",
    x = "Valeurs prédites",
    y = "Consommation réelle (MWh)"
  ) +
  theme_minimal()


--------------------------------------#Conclusion------------------------------------------------------------- 
  
  