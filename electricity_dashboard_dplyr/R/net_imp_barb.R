net_imp_barb <- function(country){
  if (!(is.na(match(x = country, table = imp_data$country)))){
    data <- imp_data %>%
        filter(country == !!country)
    cur_yr <- max(data$year) - 30
    while (is.na(match(x = cur_yr, table = data$year))){
      cur_yr = cur_yr + 1
    }
    data <- data %>%
        filter(year %in% c(cur_yr:max(year)))
    ggplot(data = data, mapping = aes(x = year, y = net_elec_imports * -1, fill = as.character(status))) +
        geom_col(width = 0.4) +
        scale_fill_manual(values = c("0" = "blue", "1" = "red")) +
        theme_minimal() +
        theme(legend.position = "none") +
        labs(y = "Net electricity imports in terawatts")
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


