#' Rename Project Files to Match the Repository Name
#'
#' @description
#' This script is designed to be run once, immediately after creating a new
#' project from the template. It automates the process of renaming the generic
#' template files (`.Rproj` and `.qmd`) to match the new project's directory name,
#' which corresponds to the GitHub repository name.
#'
#' @details
#' The script performs the following actions:
#'   1. Detects the current project's directory name.
#'   2. Finds the generic template `.Rproj` file (e.g., "sda-hw_template.Rproj").
#'   3. Finds the generic starter `.qmd` file (e.g., "2025-mm-dd_sda_homework-num.qmd").
#'   4. Renames both files to match the new project name.
#'   5. Prints a message instructing the user to restart the RStudio session.
#'
#' @return This function is called for its side effects (renaming files) and
#'   does not return a value. It will print a message to the console.
#'
rename_project_files <- function() {
  
  # Get the current project directory name (which is the repo name)
  project_dir <- here::here()
  new_name <- basename(project_dir)
  
  message("New project name detected: '", new_name, "'")
  
  # --- 1. Rename the .Rproj file ---
  
  # Find the old .Rproj file (adjust name if your template changes)
  old_rproj_name <- "sda-hw_template.Rproj"
  old_rproj_path <- here::here(old_rproj_name)
  
  if (file.exists(old_rproj_path)) {
    new_rproj_path <- here::here(paste0(new_name, ".Rproj"))
    file.rename(from = old_rproj_path, to = new_rproj_path)
    message("Renamed '", old_rproj_name, "' to '", basename(new_rproj_path), "'")
  } else {
    message("No '", old_rproj_name, "' found. Skipping .Rproj rename.")
  }
  
  # --- 2. Rename the starter .qmd file ---
  
  # Find the generic .qmd file (this pattern should be unique)
  old_qmd_name <- list.files(path = project_dir, pattern = "-num\\.qmd$")
  
  if (length(old_qmd_name) == 1) {
    old_qmd_path <- here::here(old_qmd_name)
    new_qmd_path <- here::here(paste0(new_name, ".qmd"))
    file.rename(from = old_qmd_path, to = new_qmd_path)
    message("Renamed '", old_qmd_name, "' to '", basename(new_qmd_path), "'")
  } else {
    message("Could not find a unique '...-num.qmd' file. Skipping .qmd rename.")
  }
  
  # --- 3. Remove the template README files ---
  
  # List of README files to remove
  readme_files <- c(
    "data/README.md",
    "output/README.md"
  )
  
  for (file_path in readme_files) {
    full_path <- here::here(file_path)
    if (file.exists(full_path)) {
      file.remove(full_path)
      message("Removed template file: '", file_path, "'")
    }
  }
  
  # --- 4. Final instruction ---
  
  message("\nIMPORTANT: File renaming complete. Please close and reopen this project.")
  message("Use 'File > Open Project...' and select the new '", new_name, ".Rproj' file.")
  
}

# Automatically run the function when the script is sourced
rename_project_files()