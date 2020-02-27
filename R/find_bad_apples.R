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
find_bad_apples <- function(df) {
  # insert code here
}
