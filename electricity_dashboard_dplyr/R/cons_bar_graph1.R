cons_bar_graph1 <- function(country, source_energy){
  if (!(any(is.na(c(match(x = country, table = elec_data$country), 
                    match(x = country, table = cons_data$country)))))){
    source_energy <- match(x = source_energy, table = all_sources) 
    data <- elec_data %>%
            filter(country == !!country)
    data2 <- cons_data %>%
            filter(country == !!country)
    all_yrs <- intersect(data2$year, data$year)
    cur_yr <- max(all_yrs) - 30
    while (is.na(match(x = cur_yr, table = all_yrs))){
      cur_yr = cur_yr + 1
    }
    all_yrs <- all_yrs[match(x = cur_yr, table = all_yrs):length(all_yrs)]
    data <- data.frame(
                  "twh" = c(data[match(x = all_yrs, table = data$year), 
                            elec_var_vec[source_energy]],
                            data2[match(x = all_yrs, table = data2$year), 
                                  elec_cons_var_vec[source_energy]]
                         ),
                  "status" = c(rep(x = "production", times = length(all_yrs)), 
                               rep(x = "consumption change", times = length(all_yrs))),
                  "year" = c(all_yrs, all_yrs)
                )
    ggplot(data = data, mapping = aes(y = twh, fill = status, x = year, group = status)) + 
      geom_bar(stat = "identity", position = "dodge", width = 0.4) + 
      scale_fill_manual(values = c("red", "blue")) +
      theme_minimal() +
      theme(legend.position = "bottom") +
      labs(color = "origin")
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
