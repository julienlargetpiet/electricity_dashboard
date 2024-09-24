bar_chart <- function(country){
  if (!(is.na(match(x = country, table = pre_elec_data_pivoted$country)))){
    data <- pre_elec_data_pivoted %>%
            filter(country == !!country)
    data <- data %>%
            filter(year == max(year))
    ggplot(data = data, 
         mapping = aes(x = twh, 
                       y = reorder(type, twh),
                       fill = type)) +
          geom_col() +
          scale_fill_manual(values = elec_color_vec) +
          theme_minimal() +
          theme(legend.position = "none") +
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



