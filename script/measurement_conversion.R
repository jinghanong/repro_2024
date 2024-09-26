g_to_lbs <- function(value_in_g){
  value_in_lbs <- 0.02204623 * value_in_g
  return(value_in_lbs)
}

mm_to_inches <- function(mm_value){
  
  inches_value = mm_value * 0.03937008
  return(inches_value)
}
