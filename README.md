
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mealprepR

<!-- badges: start -->

<!-- badges: end -->

Mealprep offers a toolkit, made with care, to help users save time in the data preprocessing kitchen.

## Overview

Recognizing that the preparation step of a data science project often requires the most time and effort, `mealprep` aims to help data science chefs of all specialties master their recipes of analysis. This package tackles pesky tasks such as classifying columns as categorical or numeric ingredients, straining NA values and outliers, and automating a preprocessing recipe pipeline.

## Functions
Function 1)`fruit_and_veg()`: determine numeric and categorical variable names from an input dataset
```
ENTER DOC STRING
```

Function 2)`missing_ingredients()`: identify columns with missing values, their frequency and proportion
```
#' missing_ingredients Documentation
#'
#' For each column with missing values, this function will create a reference 
#' list of row indices, sum the number and calculate proportion of missing values 
#'
#' @param data A dataframe
#'
#' @return A dataframe containing the columns: column_name, list_of_indices, na_count, na_proportion
#'
#' @export
#'
#' @examples
#' missing_ingredients(df)
#' >>>> data.frame('column_name' = c('temp','duration'), 'list_of_indices' = list(c(2,36),c(36)), 
#'                 'na_count' = c(2, 1), 'na_proportion' = c(0.02,0.01)) 
#'
    
```

Function 3)`find_bad_apples()`: identify columns with outliers, their frequency and proportion
```
#' find_bad_apples
#'
#' @description
#' This function uses a univariate approach to outlier detection.
#' It returns the indices of rows within a dataframe that contain variable values
#' which are at least 3 standard deviations from the norm of the variable (outliers),
#' as well as how many outliers exist within those rows.
#'
#' Note: This function works best for small datasets with unimodal variable distributions.
#'
#'
#' @param df A dataframe containing numeric data
#'
#'
#' @return A dataframe with column for 'indices' and column for 'number of outliers'
#'
#' @example
#' find_bad_apples(df)
#' >>>> data.frame('indices' = c(5, 980), 'number_of_outliers' = c(1, 2))
#'
#' @export
#'
#' @examples
```

Function 4)`make_recipe()`: quickly apply your favourite data preprocessing recipes in one line of code.

```
Enter doc string
```

## Mealprep and Python's Ecosystem

TO DO

## Installation

You can install the released version of mealprepR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("mealprepR")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/mealprepR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(mealprepR)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
