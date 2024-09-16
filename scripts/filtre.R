library("readr")
library("tidyr")
library("edm1")

data <- read.table(file = "../datas/owid-energy-data.csv", 
              sep = ",", 
              fill = TRUE, 
              head = TRUE,
              quote = "\\")

elec_vec <- c(
             "country", 
             "year", 
             "biofuel_electricity",
             "coal_electricity",
             "gas_electricity",
             "hydro_electricity",
             "nuclear_electricity",
             "oil_electricity",
             "other_renewable_exc_biofuel_electricity",
             "solar_electricity",
             "wind_electricity"
)

share_vec <- c(
             "country",
             "year",
             "biofuel_share_elec",
             "coal_share_elec",
             "gas_share_elec",
             "hydro_share_elec",
             "nuclear_share_elec",
             "oil_share_elec",
             "other_renewables_share_elec_exc_biofuel",
             "solar_share_elec",
             "wind_share_elec"
)

share_data <- data[, share_vec]

cur_v <- grep(pattern = TRUE, x = is.na(share_data[, 1]))
for (i in 2:ncol(share_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(share_data[, i]))))
}
share_data <- share_data[-cur_v, ]
write_rds(x = share_data, file = "../datas/share_energy.rds")
nrow(share_data)

elec_data <- data[, elec_vec] 
cur_v <- grep(pattern = TRUE, x = is.na(elec_data[, 1]))
for (i in 2:ncol(elec_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(elec_data[, i]))))
}
elec_data <- elec_data[-cur_v, ]
sum_v <- c()
for (i in 1:nrow(elec_data)){
  sum_v <- c(sum_v, sum(elec_data[i, 3:11]))
}
elec_data <- cbind(elec_data, "tot" = sum_v)
write_rds(x = elec_data, file = "../datas/elec_energy.rds")

elec_var_vec <- c(
             "biofuel_electricity",
             "coal_electricity",
             "gas_electricity",
             "hydro_electricity",
             "nuclear_electricity",
             "oil_electricity",
             "other_renewable_exc_biofuel_electricity",
             "solar_electricity",
             "wind_electricity",
             "tot"
)

cur_elec_data <- elec_data %>%
          pivot_longer(cols = all_of(elec_var_vec),
                       names_to = "type", 
                       values_to = "twh" 
          )

write_rds(x = cur_elec_data, file = "../datas/elec_energy_pivoted.rds")
filtered_elec_data <- cur_elec_data[-grep_all(pattern_v = c(
                                                  "Western",
                                                  "Upper",
                                                  "Oceania",
                                                  "OECD",
                                                  "North America",
                                                  "Middle",
                                                  "Low",
                                                  "Latin",
                                                  "High",
                                                  "G7",
                                                  "G20",
                                                  "Europ",
                                                  "Asia",
                                                  "Africa",
                                                  "ASEAN",
                                                  "World",
                                                  "South"
                                                 ),
                                       inpt_v = cur_elec_data$country
                                        ), ]
write_rds(x = filtered_elec_data, file = "../datas/filtered_elec_energy_pivoted.rds")


elec_cons_var_vec <- c(
             "country",
             "year",
             "biofuel_cons_change_twh",
             "coal_cons_change_twh",
             "gas_cons_change_twh",
             "hydro_cons_change_twh",
             "nuclear_cons_change_twh",
             "oil_cons_change_twh",
             "other_renewables_cons_change_twh",
             "solar_cons_change_twh",
             "wind_cons_change_twh"
)

cons_data <- data[, elec_cons_var_vec]
cur_v <- grep(pattern = TRUE, x = is.na(cons_data[, 1]))
for (i in 2:ncol(cons_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(cons_data[, i])))) 
}
cons_data <- cons_data[-cur_v, ]
print(nrow(cons_data))
sum_v <- c()
for (i in 1:nrow(cons_data)){
  sum_v <- c(sum_v, sum(cons_data[i, 3:11]))
}
cons_data <- cbind(cons_data, "tot" = sum_v)
write_rds(x = cons_data, file = "../datas/cons_energy.rds")

elec_var_vec <- c(
             "biofuel_electricity",
             "coal_electricity",
             "gas_electricity",
             "hydro_electricity",
             "nuclear_electricity",
             "oil_electricity",
             "other_renewable_exc_biofuel_electricity",
             "solar_electricity",
             "wind_electricity"
)

cur_elec_data <- elec_data %>%
          pivot_longer(cols = all_of(elec_var_vec),
                       names_to = "type", 
                       values_to = "twh" 
          )

write_rds(x = cur_elec_data, file = "../datas/pre_elec_energy_pivoted.rds")

filtered_data <- read.table(file = "../datas/owid-energy-data-sorted.csv", 
                            sep = ",", 
                            header = TRUE, 
                            fill = TRUE, 
                            quote = "\\")

filtered_data <- filtered_data$country
cur_data <- data[, elec_var_vec]
print("ok")
head(filtered_data)
tot_v <- c()
for (i in match(x = unique(filtered_data), table = data$country)){
  tot_v <- c(tot_v, sum(cur_data[i, elec_var_vec]))
}
tot_v <- tot_v[!(is.na(tot_v))]
write.table(x = data.frame("mean" = mean(tot_v), 
                  "median" = median(tot_v), 
                  "max" = max(tot_v)), sep = ",", file = "../datas/stats.csv")

imp_data <- data[, c("net_elec_imports", "country", "year")]
cur_v <- grep(pattern = TRUE, x = is.na(imp_data[, 1]))
for (i in 2:ncol(imp_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(imp_data[, i]))))
}
imp_data <- imp_data[-cur_v, ]
imp_data <- cbind(imp_data, 
                  "status" = mapply(function(x) return(ifelse(x < 0, 0, 1)), imp_data$net_elec_imports))
write_rds(x = imp_data, 
            file = "../datas/imp_data.rds")

indiv_var_vec <- c(
              "country",
              "year",
             "biofuel_elec_per_capita",
             "coal_elec_per_capita",
             "gas_elec_per_capita",
             "hydro_elec_per_capita",
             "nuclear_elec_per_capita",
             "oil_elec_per_capita",
             "other_renewables_elec_per_capita_exc_biofuel",
             "solar_elec_per_capita",
             "wind_elec_per_capita"
)

indiv_data <- data[, indiv_var_vec]

cur_v <- grep(pattern = TRUE, x = is.na(indiv_data[, 1]))
for (i in 2:ncol(indiv_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(indiv_data[, i]))))
}
indiv_data <- indiv_data[-cur_v, ]

tot_v <- c()
for (i in 1:nrow(indiv_data)){
  tot_v <- c(tot_v, sum(indiv_data[i, 3:11]))
}
indiv_data <- cbind(indiv_data, "tot" = tot_v)

write_rds(x = indiv_data, file = "../datas/indiv_data.rds")

bin_var_vec <- c("country",
                 "year",
                 "low_carbon_share_elec",
                 "fossil_share_elec"
)

bin_data <- data[, bin_var_vec]
cur_v <- grep(pattern = TRUE, x = is.na(bin_data[, 1]))
for (i in 2:ncol(bin_data)){
  cur_v <- unique(c(cur_v, grep(pattern = TRUE, x = is.na(bin_data[, i]))))
}
bin_data <- bin_data[-cur_v, ]
write_rds(x = bin_data, file = "../datas/bin_energy.rds")





