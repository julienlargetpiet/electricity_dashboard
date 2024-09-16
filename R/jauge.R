jauge <- function(country_var){
  if (!(is.na(match(x = country_var, table = bin_data$country)))){
    data <- bin_data[country == country_var, ]
    data <- data[year == max(data$year), ]
    spe_val <- as.numeric(data[1, 3])
    data <- data.frame("type" = c("low_carbon", "high_carbon"), 
                       "start" = c(0, spe_val / 100 * pi),
                       "end" = c(spe_val / 100 * pi, pi)
    )
    ggplot(data = data) +
      geom_arc_bar(
        mapping = aes(
          x0 = 1,
          y0 = 1,
          fill = type,
          start = start - pi / 2,
          end = end - pi / 2,
          r0 = 0.75,
          r = 1
        )
      ) +
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

