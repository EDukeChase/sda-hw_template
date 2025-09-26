# Homework Template: Spatial Data Analysis (HTML)

This is a template for Spatial Data Analysis (CU Denver: MATH-6384), pre-configured to produce styled HTML documents. It uses renv to ensure that every assignment is fully reproducible with the correct R package versions.


# What's in This Template?

This repository contains several key configuration files that automate your setup process.

    _quarto.yml: This is the main control panel for the Quarto project. It's set up to:

        Render your .qmd file to a single, self-contained HTML file.

        Apply a clean visual theme (cosmo).

        Automatically link the style.css stylesheet to control the appearance of custom elements.

    style.css: This is the stylesheet for your HTML output. It contains the rules that make text in the answer-box appear blue. You can add more custom styles here if you wish.

    R/setup.R: This script is where you should load all R packages (library(...)) and set global options for your project (like knitr::opts_chunk$set). Your .qmd files should source this script in the first code chunk to ensure a consistent setup for every analysis.

    renv files (renv.lock, .Rprofile): These files are the core of the project's reproducibility.

        renv.lock: Acts as a detailed "recipe book," listing the exact version of every R package used in the template.

        .Rprofile: A small script that automatically loads renv every time you open this project in RStudio.

    .gitignore: A standard file that tells Git to ignore temporary files and folders (like the renv/library/ folder, user settings, etc.). This keeps your repository clean and focused only on the source code.

# Workflow for a New Assignment

This is a two-step process that you will run from the R console. It first creates a new, independent repository on GitHub from this template, and then clones that new repository to your local machine.

## Step 1: Create the New Repository on GitHub

Run the following command in your R console. This tells GitHub to generate a new repository. **Make sure to change the `name` and `description` for each new assignment.**

```r
# Load the gh package
library(gh)

# --- Fill in the details for your new assignment ---
new_repo_name <- "yyyy-mm-dd_sda_homework-num"
new_repo_desc <- "Homework # for Spatial Analysis"
# ----------------------------------------------------

gh::gh(
  "POST /repos/EDukeChase/sda-hw_template/generate",
  name = new_repo_name,
  description = new_repo_desc,
  private = TRUE
)
```

## Step 2: Clone the New Repository to Your Computer

Now that the new repository exists on GitHub, use the `usethis` package to clone it. Make sure the `repo` argument matches the `new_repo_name` you set in Step 1.

```r
# The 'destdir' should be the parent folder where you keep all your homework.
usethis::create_from_github(
  repo = paste0("EDukeChase/", new_repo_name),
  destdir = "C:/Users/dukec/My Drive/CU_Denver/2025_3-Fall/Spatial-Data-Analysis_MATH-6384/homework",
  open = TRUE
)
```

## Step 3: Restore the R Environment

Once the new project opens in RStudio, run the following command in the console to install all the necessary packages.

```r
renv::restore()
```

Your new project is now set up and ready to go.
