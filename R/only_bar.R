only_bar <- function(country_var){
  if (!(is.na(match(x = country_var, table = elec_data$country)))){
    data <- elec_data[country == country_var, ]
    data <- data[year == max(year), ]
    ggplot(data = data, 
           mapping = aes(x = tot, 
                         y = country, 
                         width = 0.1)) +
      geom_col() +
      geom_vline(aes(xintercept = cur_med, color = "median"), linetype = "dashed", linewidth = 0.5) +
      geom_vline(aes(xintercept = cur_mean, color = "mean"), linetype = "dashed", linewidth = 0.5) +
      geom_vline(aes(xintercept = cur_max, color = "max"), linetype = "dashed", linewidth = 0.5) +
      scale_color_manual(values = c("red", "black", "blue")) +
      scale_x_continuous(trans = "log10") +
      theme_minimal() +
      theme(legend.position = "bottom", legend.text = element_text(size = 11)) +
      labs(colour = "", x = "terawatthour")
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


