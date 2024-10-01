library(dplyr)
library(tidyr)
library(ggplot2)
library(palmerpenguins)

source("D:/JH/LEARN/DATA_REPRODUCIBILTITY/repro_2024/script/penguins_analysis_functions.R")

penguins <- penguins

island_name_list <- data.frame(unique(penguins$island))

dream_island <- get_island_data("Dream")
dream_lm_prediction <- get_predicted_body_masses(dream_island)

biscoe_island <- get_island_data("Biscoe")
biscoe_lm_prediction <- get_predicted_body_masses(biscoe_island)

torgersen_island <- get_island_data("Torgersen")
torgersen_lm_prediction <- get_predicted_body_masses(torgersen_island)

## using iteration for penguins
# using for loop
islands_data <- list()
for(an_island in c("Biscoe", "Dream", "Torgersen")){
  islands_data[[an_island]] <- get_island_data(an_island)
}

# purrr::map to get predictions
island_predictions <- purrr::map(islands_data, get_predicted_body_masses)

island_predictions_df <- dplyr::bind_rows(island_predictions)