library(palmerpenguins)
library(dplyr)
source("D:/JH/LEARN/DATA_REPRODUCIBILTITY/repro_2024/script")

penguins <- penguins

head(penguins)

# convert between metric and imperial measurements

39.1 * 0.03937008

# function to convert any value in mm to inches
mm_to_inches <- function(mm_value){
  
  inches_value = mm_value * 0.03937008
  return(inches_value)
}

mm_to_inches(39.1)

# take penguins data modify to have new column for inches
penguins_with_inches <- penguins |> 
  mutate(bill_length_in = mm_to_inches(bill_length_mm))

# modify for all mm columns
penguins_with_inches_all <- penguins |> 
  mutate(across(ends_with("mm"), mm_to_inches, .names = "{.col}_in"))

# to haviing rounded values with decimals
# no decimals
penguins_with_mm_rounded <- penguins |> 
  mutate(across(ends_with("mm"), round, .names = "{.col}_rounded"))

#creating an anonymous function that define round x to 1 digits
penguins_with_mm_rounded_1 <- penguins |> 
  mutate(across(ends_with("mm"), \(x) {round(x, digits = 2)}, .names = "{.col}_rounded"))

#####
g_to_lbs <- function(value_in_g){
  value_in_lbs <- 0.02204623 * value_in_g
  return(value_in_lbs)
}


# to load all functions from this function file
# add this on the top of your script with all other packages

source("D:/JH/LEARN/DATA_REPRODUCIBILTITY/repro_2024/script/measurement_conversion.R")



### conditionals
get_penguins_data <- function(units = "metric", penguins_data){
  if (units == "metric"){
    return(penguins_data)
  } else if (units == "imperial"){
    penguins_imperial <- penguins |> 
      mutate(across(ends_with("mm"), mm_to_inches, .names = "{.col}_in"), 
             across(ends_with("g"), g_to_lbs, .names = "{.col}_lb"))
    return(penguins_imperial)
    
  } else{
    stop("Please specify units as either 'metric' or 'imperial'!")
  }
}

get_penguins_data('metric', penguins)
get_penguins_data('imperial', penguins)
get_penguins_data('foo', penguins)

