# Electricity dashboard

Rshiny App representing an electricity dashboard of the world for more than 40 years. 

Here the data source: https://github.com/owid/energy-data

# Add data

Download the dataset in the energy-dashboard app and add the new data respecting the variables documentation. You can find the documentation of he dataset in the file `codebook.csv`

Copy your new dataset in `datas/owid-energy-data.csv` and run the R script `scripts/filtre.R` fom `scripts` directory. 

Now, the app is ready to display the new dataset!

# Run now

`shiny::runGitHub(repo = "julienlargetpiet/electricity_dashboard")`

# data.table or dplyr

The app is built with the `data.table` package, but a `dplyr` version is available under the name of `electricity-dashboard_dplyr`


