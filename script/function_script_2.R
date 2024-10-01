library(dplyr)
library(tidyr)
library(ggplot2)
library(palmerpenguins)

penguins <- penguins

# Extract data for biscoe island from the penguins data
# remove rows with NA for the sex and body mass variables

biscoe <- penguins |> 
  filter(island == "Biscoe") |>
  filter(!is.na(sex),
         !is.na(body_mass_g))

# fits a linear model of body mass g ~ sex + species + sex:species
biscoe_lm <- lm(body_mass_g ~ sex * species, 
                data = biscoe)

# look at the results of the model
summary(biscoe_lm)

ggplot(biscoe, aes(sex, body_mass_g, color = species)) +
  geom_jitter()

# Extracting the predicted values from the linear model
biscoe_lm_prediction <-  biscoe |> select(sex, species) |>
  distinct()

biscoe_lm_prediction <- biscoe_lm_prediction |> 
  mutate(predicted = predict(biscoe_lm, newdata = biscoe_lm_prediction))

# when developing a workflow
# decide what needs to be run
# such as running plot are not exactly necessary 

# turning into function
get_island_data <- function(island_name){
  this_island <- penguins |> 
    filter(island == island_name) |>
    filter(!is.na(sex),
           !is.na(body_mass_g))
  return(this_island)
}

get_predicted_body_masses <- function(island_data){
  if(length(unique(island_data$species)) > 1){
    # fits a linear model of body mass g ~ sex + species + sex:species
    island_lm <- lm(body_mass_g ~ sex * species, 
                    data = island_data)
  } else{
    island_lm <- lm(body_mass_g ~ sex, 
                    data = island_data)
  }
  
  # Extracting the predicted values from the linear model
  island_lm_prediction <-  island_data |> select(island, sex, species) |>
    distinct()
  
  island_lm_prediction <- island_lm_prediction |> 
    mutate(predicted = predict(island_lm, newdata = island_lm_prediction))
  
  return(island_lm_prediction)
  
}

island_name_list <- unique(penguins$island)

dream_island <- get_island_data("Dream")
dream_lm_prediction <- get_predicted_body_masses(dream_island)

biscoe_island <- get_island_data("Biscoe")
biscoe_lm_prediction <- get_predicted_body_masses(biscoe_island)

torgersen_island <- get_island_data("Torgersen")
torgersen_lm_prediction <- get_predicted_body_masses(torgersen_island)
# error because torgersen only has one species
# linear model cant work with one value, cant contrast cant compare etc
# so lets edit the function (add if else statement)
# removed species in the linear model eqn if species < 1

# created a new function file
# let try it in a new script_2_clean

###### iteration
# for loop
# across() [dplyr]
# purrr::map (r package for mapping)

for(i in 1:10){
  print(i+5)
}

# create a vector to store values
squares <- vector(length = 10)

for (i in 1:10) {
  squares[i] <- i^2
  
}

# purrr::map
# turning into a list
purrr::map(1:10, \(x) x^2)

# storing output
# assigning it to an object
purr_squares <- purrr::map(1:10, \(x) x^2) 

## using iteration for penguins
# using for loop
islands_data <- list()
for(an_island in c("Biscoe", "Dream", "Torgersen")){
  islands_data[[an_island]] <- get_island_data(an_island)
}

# purrr::map to get predictions
island_predictions <- purrr::map(islands_data, get_predicted_body_masses)

island_predictions_df <- dplyr::bind_rows(island_predictions)
