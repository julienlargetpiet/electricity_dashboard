

# Packages ----------------------------------------------------------------

library("shiny")
library("shinyWidgets")
library("ggplot2")
library("data.table")
library("bslib")
library("tidyr")
library("treemapify")
library("ggforce")
library("edm1")
library("bsicons") # liste icons : https://icons.getbootstrap.com/
source("R/bar_chart.R")
source("R/pie_chart.R")
source("R/tree_fun.R")
source("R/jauge.R")
source("R/only_bar.R")
source("R/slope.R")
source("R/dumbell.R")
source("R/cons_bar_graph1.R")
source("R/net_imp_bar.R")
source("R/indiv_graph.R")
source("R/net_imp_barb.R")

raw_datas <- read.table(file = "datas/owid-energy-data.csv", quote = "\\", sep = ",", header = TRUE, fill = TRUE)
elec_data <- setDT(readRDS(file = "datas/elec_energy.rds"))
share_data <- setDT(readRDS(file = "datas/share_energy.rds"))
bin_data <- setDT(readRDS(file = "datas/bin_energy.rds"))
elec_data_pivoted <- setDT(readRDS(file = "datas/elec_energy_pivoted.rds"))
pre_elec_data_pivoted <- setDT(readRDS(file = "datas/pre_elec_energy_pivoted.rds"))
cons_data <- setDT(readRDS(file = "datas/cons_energy.rds"))
stats_datf <- setDT(read.table(file = "datas/stats.csv", sep = ",", header = TRUE))
imp_data <- setDT(readRDS(file = "datas/imp_data.rds"))
indiv_data <- setDT(readRDS(file = "datas/indiv_data.rds"))
filtered_elec_data_pivoted <- setDT(readRDS(file = "datas/filtered_elec_energy_pivoted.rds"))

cur_mean <- stats_datf$mean
cur_med <- stats_datf$median 
cur_max <- stats_datf$max


share_var_vec <- c(
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

share_color_vec <- c(
  "oil_share_elec" = "#80549f",
  "coal_share_elec" = "#a68832",
  "solar_share_elec" = "#d66b0d",
  "gas_share_elec" = "#f20809",
  "wind_share_elec" = "#72cbb7",
  "hydro_share_elec" = "#2672b0",
  "nuclear_share_elec" = "#e4a701",
  "biofuel_share_elec" = "#156956",
  "other_renewables_share_elec_exc_biofuel" = "#426915"
)

elec_color_vec <- c(
  "oil_electricity" = "#80549f",
  "coal_electricity" = "#a68832",
  "solar_electricity" = "#d66b0d",
  "gas_electricity" = "#f20809",
  "wind_electricity" = "#72cbb7",
  "hydro_electricity" = "#2672b0",
  "nuclear_electricity" = "#e4a701",
  "biofuel_electricity" = "#156956",
  "other_renewable_exc_biofuel_electricity" = "#426915",
  "tot" = "#000000"
)

#all_sources <- c("oil", 
#                 "coal", 
#                 "solar", 
#                 "gas", 
#                 "wind", 
#                 "hydro", 
#                 "nuclear", 
#                 "biofuel", 
#                 "other renewables energies excluding biofuel",
#                 "tot")

all_sources <- c("biofuel",
                 "coal",
                 "gas",
                 "hydro",
                 "nuclear",
                 "oil",
                 "other renewables energies excluding biofuel",
                 "solar",
                 "wind",
                 "tot"
)

elec_cons_var_vec <- c(
             "biofuel_cons_change_twh",
             "coal_cons_change_twh",
             "gas_cons_change_twh",
             "hydro_cons_change_twh",
             "nuclear_cons_change_twh",
             "oil_cons_change_twh",
             "other_renewables_cons_change_twh",
             "solar_cons_change_twh",
             "wind_cons_change_twh",
             "tot"
)

indiv_var_vec <- c(
             "biofuel_elec_per_capita",
             "coal_elec_per_capita",
             "gas_elec_per_capita",
             "hydro_elec_per_capita",
             "nuclear_elec_per_capita",
             "oil_elec_per_capita",
             "other_renewables_elec_per_capita_exc_biofuel",
             "solar_elec_per_capita",
             "wind_elec_per_capita",
             "tot"
)


# Datas -------------------------------------------------------------------

