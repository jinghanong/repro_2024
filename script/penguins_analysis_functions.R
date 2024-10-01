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