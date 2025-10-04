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

## One-Time Setup

First, you need a GitHub Personal Access Token (PAT) so that the `gh` and `usethis` packages can interact with your account. You onle need to do this once.

1. **Generate a GitHub Token:** In R, run `usethis::create_github_token()`. In your browser, give the token a name (e.g., "RStudio-gh-usethis") and make sure the `repo` scope is checked. Click "Generate token" and **copy the token immediately.**

2. **Store the Token:** Back in R, run `gitcreds::gitcreds_set()`. Paste your token when prompted.

## Creating a New Project

For each new assignment, follow these steps from your R console.

## Step 1: Create the New Repository on GitHub

This command generates a new repository on your GitHub account using this template as the blueprint. **Change the `name` and `description` for each new assignment.**

```r
# Load the gh package
library(gh)

# --- Fill in the details for your new assignment ---
new_repo_name <- "yyyy-mm-dd_sda_homework-num"
new_repo_desc <- "Homework # for Spatial Data Analysis"
# ----------------------------------------------------

gh::gh(
  "POST /repos/EDukeChase/sda-hw_template/generate",
  name = new_repo_name,
  description = new_repo_desc,
  private = TRUE
)
```

## Step 2: Clone the New Repository to Your Computer

Use `usethis` to clone the new repository you just created.

```r
# Load the usethis package
library(usethis)

# The 'destdir' should be the parent folder where you keep all your homework.
create_from_github(
  repo = paste0("EDukeChase/", new_repo_name),
  destdir = "G:/Users/dukec/My Drive/CU_Denver/2025_3-Fall/Spatial-Data-Analysis_MATH-6384/homework",
  open = TRUE
)
```

## Step 3: Restore the R Environment

Once the new project opens in RStudio, run this command in the console to install all the necessary packages.

```r
renv::restore()
```

## Step 4: Rename Project Files

Run the following command in the console. This script will automatically rename the generic `.Rproj` and `.qmd` files to match your new repository's name.

```r
source("R/rename_project.R")
```

## Step 5: Restart the Project
This is the final, crucial step. After the script runs, you **must** close and reopen the project to use the new `.Rproj` file.

1. Go to `File > Close Project`.

2. Go to `File > Open Project...` and select your newly names `.Rproj` file.

Your new project is now fully set up, correctly names, and ready to go.

# Reminders
To create a styled answer box, use:
```
:::{.answer-box}
    Answer here
:::
```

To create a styled proof box, use:
```
::: {.boxed-proof}
    Proof here
:::
