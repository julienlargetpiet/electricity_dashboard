tree_fun <- function(country){
  if (!(is.na(match(x = country, table = pre_elec_data_pivoted$country)))){
    data <- pre_elec_data_pivoted %>%
            filter(country == !!country)
    data <- data %>%
            filter(year == max(year))
    ggplot(data = data, 
          mapping = aes(
                       fill = type,
                       area = twh,
                       label = twh
                       )) +
          geom_treemap() +
          geom_treemap_text(color = "black", place = "center", size = 15) +
          scale_fill_manual(values = elec_color_vec) +
          theme_minimal() +
          theme(legend.position = "bottom", legend.text = element_text(size = 11))
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


