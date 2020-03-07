#' find_missing_ingredients Documentation
#'
#' Example Description: Returns the indices of rows with columns which have missing values,
#' as well as how many missing values they have
#'
#' @param data A data frame that to be checked for missing values
#'
#' @return A dataframe containing the columns: column_name, list_of_indices, na_count, na_proportion
#' @export
#'
#' @examples
#' tb = tibble("letters" = c("a","b","c"),"numbers" = c(1,2,3))
#' find_missing_ingredients(tb)
find_missing_ingredients <- function(data) {
  if (sum(is.na(data)) == 0) {
    return("There are no missing values")
  }
  else {
    report = data.frame("Column_name"= names(data),
                        "NA_count"= colSums(is.na(data)),
                        "NA_proportion"= scales::percent(colSums(is.na(data)/dim(data)[1])))

    return(report)
  }

}
