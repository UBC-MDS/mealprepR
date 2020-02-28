
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mealprepR

<!-- badges: start -->

<!-- badges: end -->

Mealprep offers a toolkit, made with care, to help users save time in
the data preprocessing kitchen.

## Overview

Recognizing that the preparation step of a data science project often
requires the most time and effort, `mealprep` aims to help data science
chefs of all specialties master their recipes of analysis. This package
tackles pesky tasks such as classifying columns as categorical or
numeric ingredients, straining NA values and outliers, and automating a
preprocessing recipe pipeline.

## Functions

Function 1)`find_fruits_veg()`: determine numeric and categorical
variable names from an input dataset

    #' find_fruits_veg Documentation
    #' 
    #' @description
    #' Returns the indexs of numeric and categorical variables in the dataset
    #'
    #' @param df an input dataframe
    #' @param type_of_out a character indicats the wanted type (numeric/ categorical) of data
    #'
    #' @return a vector of index of wanted data type (numeric/ categorical)
    #'
    #' @examples
    #' fruits_and_veg(df_demo, 'categ')
    #'
    #' @export

Function 2)`find_missing_ingredients()`: identify columns with missing
values, their frequency and proportion

``` 
#'find_missing_ingredients Documentation
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

Function 3)`find_bad_apples()`: identify columns with outliers, their
frequency and proportion

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

Function 4)`make_recipe()`: quickly apply your favourite data
preprocessing recipes in one line of code.

    @description
    #' The `make_recipe()` function is used to quickly apply common data preprocessing techniques
    #'
    #' @param data A dataframe containing training data, validation data, X, and y
    #' @param recipe A string specifying which recipe to apply to the data
    #' @param create_train_test Boolean, if TRUE will partition data into train and test
    #' @param create_train_valid_test Boolean, if TRUE will partition data into train, valid, and test
    #'
    #' @return A list of dataframes e.g. list(train, valid, test)
    #'
    #' @section Recipes
    #'
    #' The following recipes are available currently available to pass into the `recipe` parameter:
    #'
    #' "ohe_and_standard_scaler"
    #'
    #' Apply one hot encoding to categorical features and standard scaler to numeric features
    #'
    #' @export
    #'
    #' @examples

## Mealprep and Python’s Ecosystem

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
