# --- Always used packages ---
library(digest)             # Creates hashes for caching function.
library(future)             # Parallel processing
library(here)               # Robust file paths
library(knitr)              # Used for running R code in Quarto
library(RColorBrewer)       # Color palettes to enable color-blind friendliness
library(tidyverse)          # Essential R packages

# --- Homework specific packages ---

# --- Set seed for reproducibility ---
set.seed(6384)

# --- Set global chunk options ---
knitr::opts_chunk$set(
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  fig.width = 8,
  fig.asp = 0.618,
  fig.align = 'center'
)

# --- Set plot options ---
theme_set(theme_minimal(base_size = 12))
options(
  ggplot2.discrete.colour = RColorBrewer::brewer.pal(3, "Dark2"),
  ggplot2.discrete.fill = RColorBrewer::brewer.pal(3, "Dark2"),
  ggplot2.continuous.colour = "viridis",
  ggplot2.continuous.fill = "viridis"
)

# --- Set up parallel processing ---
n_cores <- parallel::detectCores() - 1
plan(multisession, workers = n_cores)

# --- Custom Functions ---

#' Cache a Computation Based on Code Hash
#'
#' @description
#' This function provides a smart caching mechanism. It evaluates an R expression
#' and saves the result to a file. On subsequent runs, it first generates a
#' cryptographic hash of the code expression. If that hash matches the hash
#' stored in the cache file, it loads the result directly from the cache,
#' saving significant time. If the code has changed (and thus the hash is
#' different) or if no cache file exists, it re-runs the computation and
#' saves the new result and hash.
#'
#' @param code {expression} The R code to be executed and cached. This should
#'   be enclosed in curly braces `{}`.
#' @param cache_filename {character} A unique filename for the cache file (e.g.,
#'   "my_analysis_cache.rds"). The file will be saved in the `output/` directory.
#'
#' @return The result of the evaluated `code` expression, either newly
#'   computed or loaded from the cache.
#'
#' @importFrom digest digest
#'   This tag explicitly declares that we are using the `digest` function from
#'   the `digest` package. This is a best practice for managing dependencies.
#'
#' @export
#'   This tag marks the function as available for use outside of this script,
#'   which is a standard practice for functions you intend to use in your analysis.
#'
#' @examples
#' \dontrun{
#' # --- How to use the function in your .qmd file ---
#'
#' # Define a long-running computation
#' my_computation <- cache_computation({
#'
#'   # Simulate a long process
#'   Sys.sleep(5)
#'
#'   # Perform the calculation
#'   iris %>%
#'     group_by(Species) %>%
#'     summarise(mean_petal = mean(Petal.Length))
#'
#' }, cache_filename = "iris_summary.rds")
#'
#' # The first time this runs, it will take 5 seconds.
#' # Every subsequent time, it will load instantly.
#' print(my_computation)
#' }
cache_computation <- function(code, cache_filename) {
  # Create a unique hash of the code expression
  code_expr <- substitute(code)
  current_hash <- digest::digest(code_expr)
  
  # Define the full path to the cache file
  cache_path <- here::here("output", cache_filename)
  
  # Check if a cache file exists and if the hash matches
  if (file.exists(cache_path)) {
    cached_data <- readRDS(cache_path)
    if (identical(cached_data$hash, current_hash)) {
      message("Cache hit: Loading '", cache_filename, "' from cache.")
      return(cached_data$result)
    } else {
      message("Code has changed. Re-running computation.")
    }
  } else {
    message("No cache found. Running computation.")
  }
  
  # If we get here, we need to run the code
  result <- eval(code_expr)
  
  # Save the result AND the hash to the cache file
  data_to_cache <- list(result = result, hash = current_hash)
  saveRDS(data_to_cache, file = cache_path)
  
  return(result)
}