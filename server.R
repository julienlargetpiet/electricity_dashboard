
function(input, output, session) {
  output$tree_map <- renderPlot({tree_fun(country_var = input$country)})
  output$bar_chart <- renderPlot({bar_chart(country_var = input$country)})
  output$pie_chart <- renderPlot({pie_chart(country_var = input$country)})
  output$jauge <- renderPlot({jauge(country_var = input$country)})
  output$only_bar <- renderPlot({only_bar(country_var = input$country)})
  output$slope <- renderPlot({slope(country_var = input$country)})
  output$dumbell <- renderPlot({dumbell(country_var = input$country)})
  output$serie_temp <- renderPlot({serie_temp(country_var = input$country)})
  output$case3 <- renderText({paste("Electricity mix in", max(elec_data$year), "for", input$country)})
  output$case4 <- renderText({paste("Evolution of the electricity mix for", input$country)})
  output$case1 <- renderText({paste("Electricity balance (low/high carbon) in", max(elec_data$year), "for", input$country)})
  output$case2 <- renderText({paste("Total electricity production in", max(elec_data$year), "for", input$country,
          "compared to the world*")})
  output$cons_bar_graph1 <- renderPlot({cons_bar_graph1(country_var = input$country, 
          source_energy = input$source_energy)})
  output$net_imp_bar <- renderPlot({net_imp_bar(country_var = input$country)})
  output$net_imp_barb <- renderPlot({net_imp_barb(country_var = input$country)})
  output$case6 <- renderText({paste("Evolution of the volume of net imports (imports - exportations) of electricity for", 
          input$country)})
  output$case6b <- renderText({paste("Evolution of the volume of net exports (exportations - imports) of electricity for", 
          input$country)})
  output$indiv_graph <- renderPlot({indiv_graph(country_var = input$country, source_energy = input$source_energy2)})
  output$downloadData <- downloadHandler(
    filename = "raw_data.csv",
    content = function(file = "temp_file_data.csv"){
      write.table(x = raw_datas, file = file, sep = ",")
    }
  )
  output$comp_bar <- renderPlot({ comp_bar(
                                    country_var = input$country_comp,
                                    source_energy = input$source_energy_comp,
                                    yr_inpt = input$year_comp,
                                    top_n = input$top
                                  ) })
}
