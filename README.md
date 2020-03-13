
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mealprepR

<!-- badges: start -->

[![R build
status](https://github.com/UBC-MDS/mealprepR/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/mealprepR/actions)

[![codecov](https://codecov.io/gh/UBC-MDS/mealprepR/branch/master/graph/badge.svg)](https://codecov.io/gh/UBC-MDS/mealprepR)

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

## Documentation

To view mealprepR documentation online, please visit
<https://ubc-mds.github.io/mealprepR/>

## Examples

To load the package:

``` r
library(mealprepR)
library(devtools)
load_all()
```

### `find_fruits_veg()`

### `find_missing_ingredients()`

### `find_bad_apples()`

If you don’t already have a dataframe to work with, run this code to set
up a toy dataframe (`df`) for testing.

``` r
df <- data.frame('A' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                          1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                          1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                  'B' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, -100,
                          1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                          1, 1, 1, 1, 1, 1, 1, 1, 1, 100),
                  'C' = c(19, 1, 1, 1, 17, 1, 1, 1, 1, 1,
                          1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                          1, 1, 1, 1, 1, 1, 20, 1, 1, 1))
df
#>    A    B  C
#> 1  1    1 19
#> 2  1    1  1
#> 3  1    1  1
#> 4  1    1  1
#> 5  1    1 17
#> 6  1    1  1
#> 7  1    1  1
#> 8  1    1  1
#> 9  1    1  1
#> 10 1 -100  1
#> 11 1    1  1
#> 12 1    1  1
#> 13 1    1  1
#> 14 1    1  1
#> 15 1    1  1
#> 16 1    1  1
#> 17 1    1  1
#> 18 1    1  1
#> 19 1    1  1
#> 20 1    1  1
#> 21 1    1  1
#> 22 1    1  1
#> 23 1    1  1
#> 24 1    1  1
#> 25 1    1  1
#> 26 1    1  1
#> 27 1    1 20
#> 28 1    1  1
#> 29 1    1  1
#> 30 1  100  1
```

To find the outliers in the dataframe, run `find_bad_apples(df)` and
you’ll get a dataframe that shows which columns have outliers.

``` r
find_bad_apples(df)
#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes

#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes

#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes
#> # A tibble: 2 x 3
#> # Groups:   variable, total_outliers [2]
#>   variable total_outliers indices         
#>   <chr>             <dbl> <list>          
#> 1 B                     2 <tibble [2 × 1]>
#> 2 C                     3 <tibble [3 × 1]>
```

To see the nested tibbles that show the indices of the outliers, add
`$indices` to the end of the function. This output shows that column ‘B’
has outliers in rows 10 and 30, and column ‘C’ has outliers in rows 1,
5, and 27.

``` r
find_bad_apples(df)$indices
#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes

#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes

#> Warning in bind_rows_(x, .id): Vectorizing 'vctrs_list_of' elements may not
#> preserve their attributes
#> [[1]]
#> # A tibble: 2 x 1
#>   indices
#>     <dbl>
#> 1      10
#> 2      30
#> 
#> [[2]]
#> # A tibble: 3 x 1
#>   indices
#>     <dbl>
#> 1       1
#> 2       5
#> 3      27
```

### `make_recipe()`

Do you find yourslef constantly applying the same data preprocessing
techniques time and time again? `make_recipe` can help by applying your
favourite preprocessing recips in only a few lines of code.

Below `make_recipe` applies the following common recipe in only one line
of code:

1.  Split data into training, validation, and testing
2.  Standardise and scale numeric features
3.  One hot encode categorical features

First load the classic `mtcars` data set.

``` r
library(dplyr)

X <- dplyr::as_tibble(mtcars) %>%
 mutate(
    carb = as.factor(carb),
    gear = as.factor(gear),
    vs = as.factor(vs),
    am = as.factor(am)
  )
head(X)
#> # A tibble: 6 x 11
#>     mpg   cyl  disp    hp  drat    wt  qsec vs    am    gear  carb 
#>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <fct> <fct> <fct> <fct>
#> 1  21       6   160   110  3.9   2.62  16.5 0     1     4     4    
#> 2  21       6   160   110  3.9   2.88  17.0 0     1     4     4    
#> 3  22.8     4   108    93  3.85  2.32  18.6 1     1     4     1    
#> 4  21.4     6   258   110  3.08  3.22  19.4 1     0     3     1    
#> 5  18.7     8   360   175  3.15  3.44  17.0 0     0     3     2    
#> 6  18.1     6   225   105  2.76  3.46  20.2 1     0     3     1
```

Use `make_recipe` to quickly apply split your data and apply your
favourite preprocessing techniques\!

``` r
library(mealprepR)

mtcars_splits <- make_recipe(
  X = X, 
  y = "gear", 
  recipe = "ohe_and_standard_scaler", 
  splits_to_return = "train_test"
)
head(mtcars_splits$X_train)
#> # A tibble: 6 x 17
#>      mpg    cyl    disp     hp   drat       wt   qsec  vs_0  vs_1  am_0  am_1
#>    <dbl>  <dbl>   <dbl>  <dbl>  <dbl>    <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1  0.162 -0.127 -0.547  -0.503  0.504 -0.598   -0.772     1     0     0     1
#> 2  0.162 -0.127 -0.547  -0.503  0.504 -0.326   -0.425     1     0     0     1
#> 3  0.454 -1.23  -0.966  -0.745  0.416 -0.918    0.560     0     1     0     1
#> 4 -0.212  0.973  1.07    0.423 -0.817  0.275   -0.425     1     0     1     0
#> 5 -0.309 -0.127 -0.0222 -0.574 -1.50   0.297    1.56      0     1     1     0
#> 6  0.714 -1.23  -0.654  -1.19   0.134  0.00905  1.42      0     1     1     0
#> # … with 6 more variables: carb_1 <dbl>, carb_2 <dbl>, carb_3 <dbl>,
#> #   carb_4 <dbl>, carb_6 <dbl>, carb_8 <dbl>
```

Calling `make_recipe` will then return a list containing all of your
transformed data.

``` r
str(mtcars_splits)
#> List of 6
#>  $ X_train:Classes 'tbl_df', 'tbl' and 'data.frame': 26 obs. of  17 variables:
#>   ..$ mpg   : num [1:26] 0.162 0.162 0.454 -0.212 -0.309 ...
#>   ..$ cyl   : num [1:26] -0.127 -0.127 -1.227 0.973 -0.127 ...
#>   ..$ disp  : num [1:26] -0.5465 -0.5465 -0.966 1.0667 -0.0222 ...
#>   ..$ hp    : num [1:26] -0.503 -0.503 -0.745 0.423 -0.574 ...
#>   ..$ drat  : num [1:26] 0.504 0.504 0.416 -0.817 -1.503 ...
#>   ..$ wt    : num [1:26] -0.598 -0.326 -0.918 0.275 0.297 ...
#>   ..$ qsec  : num [1:26] -0.772 -0.425 0.56 -0.425 1.558 ...
#>   ..$ vs_0  : num [1:26] 1 1 0 1 0 0 0 1 1 1 ...
#>   ..$ vs_1  : num [1:26] 0 0 1 0 1 1 1 0 0 0 ...
#>   ..$ am_0  : num [1:26] 0 0 0 1 1 1 1 1 1 1 ...
#>   ..$ am_1  : num [1:26] 1 1 1 0 0 0 0 0 0 0 ...
#>   ..$ carb_1: num [1:26] 0 0 1 0 1 0 0 0 0 0 ...
#>   ..$ carb_2: num [1:26] 0 0 0 1 0 1 0 0 0 0 ...
#>   ..$ carb_3: num [1:26] 0 0 0 0 0 0 0 1 1 1 ...
#>   ..$ carb_4: num [1:26] 1 1 0 0 0 0 1 0 0 0 ...
#>   ..$ carb_6: num [1:26] 0 0 0 0 0 0 0 0 0 0 ...
#>   ..$ carb_8: num [1:26] 0 0 0 0 0 0 0 0 0 0 ...
#>  $ X_valid:Classes 'tbl_df', 'tbl' and 'data.frame': 0 obs. of  0 variables
#>  $ X_test :Classes 'tbl_df', 'tbl' and 'data.frame': 6 obs. of  17 variables:
#>   ..$ mpg   : num [1:6] 0.227 -0.927 0.454 -0.131 -0.862 ...
#>   ..$ cyl   : num [1:6] -0.127 0.973 -1.227 -0.127 0.973 ...
#>   ..$ disp  : num [1:6] 0.244 1.067 -0.701 -0.485 1.712 ...
#>   ..$ hp    : num [1:6] -0.503 1.419 -0.716 -0.318 1.206 ...
#>   ..$ drat  : num [1:6] -0.94 -0.711 0.539 0.539 -0.676 ...
#>   ..$ wt    : num [1:6] 0.0357 0.4138 -0.0336 0.2753 2.3045 ...
#>   ..$ qsec  : num [1:6] 1.075 -1.157 3.219 0.368 -0.177 ...
#>   ..$ vs_0  : num [1:6] 0 1 0 0 1 0
#>   ..$ vs_1  : num [1:6] 1 0 1 1 0 1
#>   ..$ am_0  : num [1:6] 1 1 1 1 1 0
#>   ..$ am_1  : num [1:6] 0 0 0 0 0 1
#>   ..$ carb_1: num [1:6] 1 0 0 0 0 0
#>   ..$ carb_2: num [1:6] 0 0 1 0 0 1
#>   ..$ carb_3: num [1:6] 0 0 0 0 0 0
#>   ..$ carb_4: num [1:6] 0 1 0 1 1 0
#>   ..$ carb_6: num [1:6] 0 0 0 0 0 0
#>   ..$ carb_8: num [1:6] 0 0 0 0 0 0
#>  $ y_train:Classes 'tbl_df', 'tbl' and 'data.frame': 26 obs. of  1 variable:
#>   ..$ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 2 2 1 1 1 ...
#>  $ y_valid:Classes 'tbl_df', 'tbl' and 'data.frame': 0 obs. of  0 variables
#>  $ y_test :Classes 'tbl_df', 'tbl' and 'data.frame': 6 obs. of  1 variable:
#>   ..$ gear: Factor w/ 3 levels "3","4","5": 1 1 2 2 1 3
```
