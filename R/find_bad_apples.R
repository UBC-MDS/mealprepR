#' find_bad_apples Documentation
#'
#' @description
#' This function uses a univariate approach to outlier detection.
#' For each column with outliers (values that are 3 or more standard deviations from the mean),
#' this function will create a reference list of row indices with outliers, and
#' the total number of outliers in that column.
#'
#' Note: This function works best for small datasets with unimodal variable distributions.
#'
#' @param df A dataframe containing numeric data
#'
#' @return A dataframe with columns for 'Variable' (dataframe column name),
#' 'Indices' (list of row indices with outliers),
#' 'Total Outliers' (number of outliers in the column)
#'
#' @examples
#' find_bad_apples(df)
#'
#' @export

find_bad_apples <- function(df) {
  # insert code here
}
