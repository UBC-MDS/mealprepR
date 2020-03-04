#' find_fruits_veg Documentation
#'
#' @description
#' Returns the indices of numeric and categorical variables in the dataset
#'
#' @param df An input dataframe
#' @param type_of_out A character that indicates the wanted type (numeric/ categorical) of data
#'
#' @return A vector of indices of wanted data type (numeric/ categorical)
#'
#' @examples
#' find_fruits_veg(iris, 'num')
#' [1] 1 2 3 4
#' @export
#'
library(tidyr)
find_fruits_veg <- function(df, type_of_out = 'categ') {
  list_of_categ = c()
  list_of_num = c()
  df_clean = tidyr::drop_na(df)
  if (dim(df_clean)[1] == 0) {
    return("It is a empty data frame or too many missing data")
  }
  for (i in c(1:dim(df_clean)[2])){
    if (!is.factor(df_clean[,i])){
      list_of_num[i] = i}
    if (is.factor(df_clean[,i])){
      list_of_categ[i] = i}
  }
  if (type_of_out == 'categ'){
    return (list_of_categ[!is.na(list_of_categ)])}
  if (type_of_out== 'num'){
    return (list_of_num[!is.na(list_of_num)])}
}

