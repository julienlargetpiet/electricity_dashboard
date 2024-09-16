comp_bar <- function(country_var, source_energy, yr_inpt, top_n){
  if (is.null(country_var)){
    country_var <- unique(elec_data_pivoted$country)
  }
  if (is.null(source_energy)){
    source_energy <- unique(elec_data_pivoted$type)
  }
  data <- filtered_elec_data_pivoted
  data <- data[type %in% source_energy & country %in% country_var & year %in% c(yr_inpt[1]:yr_inpt[2]), ]
  data <- setDT(intersect_mod2(inpt_datf = setDF(data), 
            inter_col = "year", 
            mod_col = "country", 
            n_min = 1))
  data[, tot := sum(twh), by = country]
  cur_ids <- grep_all(pattern_v = paste0("^", sort(x = unique(data$tot), decreasing = TRUE)[1:top_n], "$"), inpt_v = data$tot)
  data <- setDF(data[cur_ids, ])
  ggplot(data = data, mapping = aes(x = tot, y = reorder(country, tot))) +
    geom_col() +
    theme_minimal() 
}
