# Package installation and loading
install_and_load <- function(package) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
    library(package, character.only = TRUE)
  }
}

packages <- c(
  # Data manipulation
  "dplyr",
  "tidyr",
  "readr",
  "lubridate",
  
  # Visualization
  "ggplot2",
  "plotly",
  
  # Statistical analysis
  "stats",
  "lmtest",
  "car",
  
  # Time series analysis
  "forecast",
  "tseries",
  
  # Machine learning
  "randomForest",
  "xgboost",
  "caret",
  
  # Interactive dashboard
  "shiny",
  "shinydashboard",
  
  # Report generation
  "rmarkdown",
  "knitr"
)

# Install and load all packages
sapply(packages, install_and_load)

# Print loaded packages
cat("Loaded packages:\n")
print(search()[grep("package:", search())])