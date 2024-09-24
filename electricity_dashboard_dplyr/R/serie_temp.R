serie_temp <- function(country){
  if (!(is.na(match(x = country, table = elec_data_pivoted$country)))){
    data <- elec_data_pivoted %>%
            filter(country == !!country)
    cur_yr <- max(data$year) - 30
    data <- data %>%
            filter(year %in% c(!!cur_yr:max(year)))
    ggplot(data = data, mapping = aes(x = year, color = type, group = type, y = twh)) +
      geom_point() +
      geom_line() +
      scale_color_manual(values = elec_color_vec) +
      theme_minimal() +
      theme(legend.position = "bottom", legend.text = element_text(size = 11)) +
      labs(y = "terawatthour")
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
