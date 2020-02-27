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
missing_ingredients <- function(data) {
  # insert code here
}
