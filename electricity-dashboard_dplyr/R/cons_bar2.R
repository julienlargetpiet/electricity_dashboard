cons_bar2 <- function(country, source_energy){
  if (!(any(is.na(c(match(x = country, table = elec_data$country), 
                    match(x = country, table = cons_data$country)))))){
    source_energy <- match(x = source_energy, table = all_sources) + 2
    print(paste("source energy", source_energy))
    data <- elec_data %>%
            filter(country == !!country)
    data2 <- cons_data %>%
            filter(country == !!country)
    cur_yr <- max(intersect(data2$year, data$year))
    data <- data.frame(
                  "twh" = c(data[match(x = cur_yr, table = data$year), elec_var_vec[source_energy]],
                            data2[match(x = cur_yr, table = data2$year), elec_cons_var_vec[source_energy]]
                         ),
                  "status" = c("production", "consumption on production")
                )
    print(data)
    ggplot(data = data, mapping = aes(y = reorder(status, twh), x = twh, fill = status)) + 
      geom_col() + 
      scale_fill_manual(values = c("red", "blue")) +
      theme_minimal() +
      theme(legend.position = "bottom") +
      labs(title = cur_yr, x = "terawatthour")
  }else{
    ggplot(data = data.frame("type" = c("NA"),
                             "twh" = c(1)), 
           mapping = aes(y = reorder(type, twh), fill = status, x = twh)) + 
      geom_col() + 
      scale_fill_manual(values = "white") +
      theme_minimal() +
      theme(legend.position = "bottom") + 
      labs(x = "terawatthour") 
  }
}
