# tester line
#Hi my name is Hazel!

# loading in tidy
library(dplyr) #tools for symbols, 2 dataframes
library(tidyr) #pivots for pivottable in excel
library(palmerpenguins)
library(ggplot2) 

penguins_data <- penguins
write.csv(penguins_data, 
          "D:/JH/LEARN/DATA_REPRODUCIBILTITY/repro_2024/data/data_raw/penguins.csv", 
          row.names = FALSE)
head(penguins)
str(penguins)

new_object <- penguins_data
new_object <- penguins_data |> head()

#subsetting data

#select

penguin_locations <- penguins_data |> select(species, island)

penguin_mm_measurements <- penguins_data |> select(ends_with("mm"))

# filter also operates on rows

adelie_penguins <- penguins_data |> filter(species == "Adelie")

#adding or modifying columns - "mutate"

penguins_ratio <- penguins_data |> mutate(bill_length_depth_ratio = bill_length_mm / bill_depth_mm)

penguins_rounded <- penguins_data |> mutate(bill_length_mm_rounded = round(bill_length_mm, digits = 2))
#second way of doing this
penguins_rounded_1 <- penguins_data |> mutate(across(ends_with("mm"), round))
#but we lost data(precision) in this method

# so we can create a new column by 
penguins_rounded_2 <- penguins_data |> mutate(across(ends_with("mm"), round, .names = "{.col}_rounded"))

### https://dplyr.tidyverse.org/

# split apply combine (for summary statistics)
penguins_species_total <- penguins_data |>
  group_by(species, island) |>
  summarize(total_penguins = n(), 
            total_penguin_biomass = sum(body_mass_g)) |>
  ungroup()

#removing NAs
penguins_species_total <- penguins_data |>
  group_by(species, island) |>
  summarize(total_penguins = n(), 
            total_penguin_biomass = sum(body_mass_g, na.rm = TRUE)) |>
  ungroup()


# commit to git but how? i am stuck on demo-repo 2024 
# Change project!
