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

This workflow uses the usethis package to create a new project from this template repository, all from within the R console.
One-Time Setup

First, you need to connect RStudio to your GitHub account. You only need to do this once.

    Generate a GitHub Token: In the R console, run usethis::create_github_token(). This will open GitHub in your browser. Give the token a name (e.g., "RStudio-usethis"), and make sure the repo scope is checked. Click "Generate token" and copy the token immediately.

    Store the Token: Back in R, run gitcreds::gitcreds_set(). Paste your token when prompted and press Enter. You are now authenticated.

# Creating a New Project

For each new assignment, run a single command in your RStudio console (it does not matter which project you have open).

    Run create_from_github():

    usethis::create_from_github(
      "EDukeChase/sda-hw_template",
      destdir = "C:/Users/dukec/My Drive/CU_Denver/2025_3-Fall/Spatial-Data-Analysis_MATH-6384/homework",
      repo_name = "2025-mm-dd_sda_homework-#"
    )   

        "EDukeChase/sda-hw_template": Important: You must replace this with the actual path to your template repo on GitHub.

        destdir: Specify the folder on your computer where you want the new project folder to be created (e.g., "~/Documents/Spatial_Class").

        repo_name: This will be the name of the new folder on your computer and the new GitHub repository.

        usethis will automatically create the new repository on GitHub from your template, clone it to your computer, and open it in a new RStudio session.

    Restore the Environment:
    Once the new project is open, run renv::restore() in the console to install all the project-specific packages from the lockfile.

    Start Your Analysis:
    You are now ready to work! Create your new .qmd file for the assignment and remember to source your setup script.

Reminder: Using the Answer Box

To create a styled answer box for your responses, use the following Quarto syntax:

::: {.answer-box}
Your detailed answer goes here.
:::
