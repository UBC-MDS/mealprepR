
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mealprepR

<!-- badges: start -->

<!-- badges: end -->

MealprepR offers a toolkit, made with care, to help users save time in
the data preprocessing kitchen.

## Overview

Recognizing that the preparation step of a data science project often
requires the most time and effort, `mealprepR` aims to help data science
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

## mealprepR and R’s Ecosystem

**mealprepR** complements many of the existing packages in the R
ecosystem around the theme of data preprocessing. With respect to
categorizing the columns of a dataframe by type, the base R code
`sapply(yourdataframe, class)` will produce the data types of each
column. However, there appears to be no easy way to divide the columns
into categorical and numerical groups. `find_fruits_veg()` aims to fill
this void. In terms of missing values, the package
[na.tools](https://cran.r-project.org/web/packages/na.tools/na.tools.pdf)
provides a suite of tools to check the number and proportion of missing
values in a dataset as well as methods controlling how they may be
replaced. The
[forecast](https://cloud.r-project.org/web/packages/forecast/forecast.pdf)
package includes the function `na.interp()` provides a similar
replacement tool for time series data. The gap between these packages is
that neither provides you a summary of the missing values including the
list of indices where they occur. `find_missing_ingredients()` augments
these tools by providing a summary dataframe detailing which columns
have missing values, as well as their count and proportion.

The base R `summary()` function is a popular first function to run
during the data exploration stage of a project because it returns the
mean, median, minimum, and maximum of each variable in a dataset, which
allows users to easily see whether there are possible outliers. However,
the output of this function does not tell you which rows of data these
outliers are found in, or how many outliers are present in the
dataframe. Packages like
[outliers](https://cran.r-project.org/web/packages/outliers/outliers.pdf)
and
[OutlierDetection](https://cran.r-project.org/web/packages/OutlierDetection/OutlierDetection.pdf)
provide many more ways of detecting outliers using both univariate and
multivariate outlier detection methods, and some functions such as the
`outlierTest()` function from the
[car](https://cran.r-project.org/web/packages/car/car.pdf) package also
output the row within a dataframe which has the most extreme observation
given a model. The `find_bad_apples()` function provides more detail
than the base R `summary()` function for outlier detection, but does not
provide multivariate outlier detection like other functions from
packages specifically made to detect outliers.

Lastly, there are many great tools in the data science ecosystem for
pre-processing data such as
[caret](https://cran.r-project.org/web/packages/caret/caret.pdf) in R.
However, you may find yourself frequently writing the same lengthy code
for common preprocessing tasks (e.g scale numeric features and one hot
encode categorical features). `preprocess_recipe()` provides a *shortcut
function* to apply your favourite recipes quickly to preprocess data in
one line of code.

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
