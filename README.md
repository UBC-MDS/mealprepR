
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

`find_fruits_veg()`: This function returns the indices of numeric and
categorical variables in the dataset.

`find_missing_ingredients()`: For each column with missing values, this
function will create a reference list of row indices, sum the number,
and calculate the proportion of missing values.

`find_bad_apples()`: This function uses a univariate approach to outlier
detection. For each column with outliers (values that are 2 or more
standard deviations from the mean), this function will create a
reference list of row indices with outliers, and the total number of
outliers in that column.

**Example:** This sets up a toy dataframe (`df`) for testing.

    > df <- data.frame('A' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                              1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                              1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                      'B' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, -100,
                              1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                              1, 1, 1, 1, 1, 1, 1, 1, 1, 100),
                      'C' = c(19, 1, 1, 1, 17, 1, 1, 1, 1, 1,
                              1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                              1, 1, 1, 1, 1, 1, 20, 1, 1, 1))
    > df
       A    B   C
    1  1    1  19
    2  1    1   1
    3  1    1   1
    4  1    1   1
    5  1    1  17
    6  1    1   1
    7  1    1   1
    8  1    1   1
    9  1    1   1
    10 1 -100   1
    11 1    1   1
    12 1    1   1
    13 1    1   1
    14 1    1   1
    15 1    1   1
    16 1    1   1
    17 1    1   1
    18 1    1   1
    19 1    1   1
    20 1    1   1
    21 1    1   1
    22 1    1   1
    23 1    1   1
    24 1    1   1
    25 1    1   1
    26 1    1   1
    27 1    1  20
    28 1    1   1
    29 1    1   1
    30 1  100   1

The output of `find_bad_apples(df)` is a dataframe that shows which
columns have outliers.

    > find_bad_apples(df)
    # A tibble: 2 x 3
    # Groups:   variable, total_outliers [2]
      variable total_outliers indices         
      <chr>             <dbl> <list>          
    1 B                     1 <tibble [1 × 1]>
    2 C                     1 <tibble [1 × 1]>

To see the nested tibbles that show the indices of the outliers, add
`$indices` to the end of the function. This output shows that column ‘B’
has outliers in rows 10 and 30, and column ‘C’ has outliers in rows 1,
5, and 27.

    > find_bad_apples(df)$indices
    [[1]]
    # A tibble: 2 x 1
      indices
        <dbl>
    1      10
    2      30
    
    [[2]]
    # A tibble: 3 x 1
      indices
        <dbl>
    1       1
    2       5
    3      27

`make_recipe()`: This function is used to quickly apply common data
preprocessing techniques.

## mealprepR and R’s Ecosystem

**mealprepR** complements many of the existing packages in the R
ecosystem around the theme of data preprocessing. With respect to
categorizing the columns of a dataframe by type, the base R code
`sapply(yourdataframe, class)` will produce the data types of each
column. However, there appears to be no easy way to divide the columns
into categorical and numerical groups. `find_fruits_veg()` aims to fill
this void.

In terms of missing values, the package
[na.tools](https://cran.r-project.org/web/packages/na.tools/na.tools.pdf)
provides a suite of tools to check the number and proportion of missing
values in a dataset as well as methods controlling how they may be
replaced. The
[forecast](https://cloud.r-project.org/web/packages/forecast/forecast.pdf)
package includes the function `na.interp()` which provides a similar
replacement tool for time series data. The gap between these packages is
that neither provides a summary of the missing values including the list
of indices where they occur. `find_missing_ingredients()` augments these
tools by providing a summary dataframe detailing which columns have
missing values, as well as their count and proportion.

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

## Coverage

If not already installed, enter the following code into your R console:

    install.packages("covr")

Use the following to derive the test coverage results:

    library(covr)
    report()

The coverage result is shown below:

<img src='img/R_coverage.png' width = 800 />
