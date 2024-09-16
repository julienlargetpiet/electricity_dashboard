dumbell <- function(country){
  if (!(is.na(match(x = country, table = elec_data_pivoted$country)))){
    data <- elec_data_pivoted %>%
            filter(country == !!country)
    cur_yr <- max(data$year) - 30
    all_yr <- unique(data$year)
    while (is.na(match(x = cur_yr, table = all_yr))){
      cur_yr = cur_yr + 1
    }
    data <- data %>%
            filter(year %in% c(max(year), !!cur_yr))
    data$year <- as.character(data$year)
    ggplot(data = data, mapping = aes(x = twh, 
                                        y = type, 
                                        group = type
                                        )) +
      geom_line() +
      geom_point(mapping = aes(shape = year), size = 3) +
      theme_minimal() + 
      theme(legend.position = "bottom", legend.text = element_text(size = 11)) +
      labs(x = "terawatthour")
  }else{
    ggplot(data = data.frame("type" = "NA", "twh" = 1), 
          mapping = aes(
                       fill = type,
                       area = twh,
                       label = type
                       )) +
          geom_treemap() +
          geom_treemap_text(color = "black", place = "center", size = 15) +
          scale_fill_manual(values = "white") +
          theme_minimal() +
          theme(legend.position = "bottom", legend.text = element_text(size = 11))
  }
}
