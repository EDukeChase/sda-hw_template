# Homework Template: Spatial Data Analysis (HTML)

This is a template for Spatial Data Analysis (CU Denver: MATH-6384), pre-configured to produce styled HTML documents. It uses renv to ensure that every assignment is fully reproducible with the correct R package versions.


## What's in This Template?

This repository contains several key configuration files that automate your setup process.

-   **`_quarto.yml`**: The main control panel for the Quarto project.

-   **`R/initialize_project.R`**: An automation script that runs once to set up a new project. It renames generic files (`.Rproj`, `.qmd`) and replaces this `README.md` with a project-specific template.

-   **`R/setup.R`**: The script where you load R packages and set global options for your analysis.

-   **`renv` files**: The core of the project's reproducibility (`renv.lock`, `.Rprofile`).

-   ...and other configuration files (`.gitignore`, `style.css`, etc.).

## Workflow for a New Assignment

### One-Time Setup

You need a GitHub Personal Access Token (PAT) so R can interact with your account.

1.  **Generate Token:** In R, run `usethis::create_github_token()`. Give it a name, check the `repo` scope, generate it, and **copy the token immediately**.

2.  **Store Token:** Back in R, run `gitcreds::gitcreds_set()` and paste the token when prompted.

### Creating a New Project

Follow these steps from your R console for each new assignment.

#### Step 1: Create the New Repository on GitHub
This command generates a new repository from this template. **Update the `name` and `description` each time.**

```r
library(gh)
new_repo_name <- "2025-10-14_sda_homework-06"
new_repo_desc <- "Homework 6 for Spatial Analysis"

gh::gh(
  "POST /repos/EDukeChase/sda-hw_template/generate",
  name = new_repo_name,
  description = new_repo_desc
)
```

#### Step 2: Clone the New Repository to Your Computer

Use `usethis` to clone the new repo to your local machine.

```r
library(usethis)
create_from_github(
  repo = paste0("EDukeChase/", new_repo_name),
  destdir = "G:\\My Drive\\CU_Denver\\2025_3-Fall\\Spatial-Data-Analysis_MATH-6384\\homework", # Change this to your main homework folder
  open = TRUE
)
```

#### Step 3: Restore the R Environment

Once the new project opens, run this in the console to install all the necessary packages.

```r
renv::restore()
```

#### Step 4: Initialize the Project

Run this script to automatically rename files and clean up the READMEs.

```r
source("R/project_initialization.R")
```

#### Step 5: Restart the Project

You **must** restart the project to use the new `.Rproj` file.

1. Go to `File > Close Project`.

2. Go to `File > Open Project...` and select your newly names `.Rproj` file.

#### Step 6: Customize Your New README.md

This is the final step. The main `README.md` has been replaced with a generic template.

1. Open the new `README.md` file.

2. Fill in the placeholders like `{num}`, `2025-mm-dd`, etc.

3. **Commit and push** this change to your repository. This ensures your new project is self-documenting.

# Template README.md for Projects

# Homework {num}: Spatial Data Analysis (Subject)

This repository contains the complete analysis for Homework {num} of the Spatial Data Analysis course (MATH-6384). {Brief description of homework subject}.

- Author: E. Duke Chase
- Course: MATH-6384, Spatial Data Analysis
- Due Date: 2025-mm-dd

## Repository Contents
This project is structured as a reproducible R environment using `renv` and Quarto.
- `2025-mm-dd_sda_homework-{num}.qmd`: The main Quarto document containing all code and analysis.
- `R/setup.R`: The R script that loads packages and sets global options.
- `_quarto.yml`: The project configuration file, which sets the HTML theme and other rendering options.
- `data/`: Contains raw data files used in the analysis. The contents of this folder are ignored by git.
- `output/`: Contains saved results like cached computations or exported plots. The contents of this folder are ignored by git.
- `renv.lock` / `.Rprofile`: Files that ensure the R environment is fully reproducible.

## How to Reproduce the Analysis
To run this analysis and render the final HTML report, please follow these steps:

1. Clone the Repository

```r
git clone <repository-url>
```

2. Open the Project: Open the `2025-mm-dd_sda_homework-{num}.Rproj` file in RStudio.

3. Restore the Environment: Run the following command in the R console. This will install the exact versions of all R packages used in the analysis.

```r
renv::restore()
```

4. Render the Document: 
Open the `2025-mm-dd_sda_homework-{num}.qmd` file and click the "Render" button, or run the following command in the R console:

```r
quarto::quarto_render("2025-mm-dd_sda_homework-{num}.qmd")
```