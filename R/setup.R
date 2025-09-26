# Always used packages
library(tidyverse)          # 
library(RColorBrewer)       # 
library(future)             # For parallel processing

# Homework specific packages

# Set seed for reproducibility
set.seed(6384)

# Set global chunk options
knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  fig.width = 8,
  fig.asp = 0.618,
  fig.align = 'center'
)

# Set plot options
theme_set(theme_minimal(base_size = 12))
options(
  ggplot2.discrete.colour = RColorBrewer::brewer.pal(3, "Dark2"),
  ggplot2.discrete.fill = RColorBrewer::brewer.pal(3, "Dark2"),
  ggplot2.continuous.colour = "viridis",
  ggplot2.continuous.fill = "viridis"
)

# Set up parallel processing
n_cores <- parallel::detectCores() - 1
plan(multisession, workers = n_cores)