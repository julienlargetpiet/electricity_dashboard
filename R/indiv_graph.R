indiv_graph <- function(country_var, source_energy){
  if (!(is.na(match(x = country_var, table = indiv_data$country)))){
    source_energy <- indiv_var_vec[match(x = source_energy, table = all_sources)]
    data <- indiv_data[, c("year", "country", ..source_energy)]
    data <- data[country == country_var, ]
    cur_yr <- max(data$year) - 30
    while (is.na(match(x = cur_yr, table = data$year))){
      cur_yr = cur_yr + 1
    }
    data <- data[year %in% c(cur_yr:max(year)), ]
    ggplot(data = data, mapping = aes(x = year, y = get(source_energy))) +
      geom_bar(width = 0.4, stat = "identity") +
      geom_hline(aes(yintercept = 2223, color = "world mean"), linetype = "dashed", linewidth = 1.5) +
      scale_fill_manual(values = "red") +
      theme_minimal() +
      theme(legend.position = "bottom", legend.text = element_text(size = 11)) +
      labs(y = "kilowatts", colour = "")
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
