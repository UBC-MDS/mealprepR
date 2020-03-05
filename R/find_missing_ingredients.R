#' find_missing_ingredients Documentation
#'
#' Example Description: Returns the indices of rows with columns which have missing values,
#' as well as how many missing values they have
#'
#' @param data
#'
#' @return
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
    report = data.frame("Column name"= names(data),
                        "NA count"= colSums(is.na(data)),
                        "NA proportion"= percent(colSums(is.na(data)/dim(data)[1])))

    return(report)
  }

}
