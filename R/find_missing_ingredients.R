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
    
    NA_columns <- colnames(data)[colSums(is.na(data)) > 0]
    NA_counts <- colSums(is.na(data[NA_columns]))
    
    indices_df <- data.frame("NA_indices" = tidyr::tibble()) %>%
      tidyr::nest(data = tidyr::everything())
    
    
    for (i in seq(1,length(NA_columns))){
      
      addition_ind <- data.frame("NA_indices" = c(which(is.na(data[NA_columns][,i])))) %>%
        tidyr::nest(data = tidyr::everything())
      
      indices_df <- dplyr::bind_rows(indices_df, addition_ind)
      
    }
    
    report <- data.frame("Column_name"= NA_columns,
                         "NA_count"= NA_counts,
                         "NA_proportion"= scales::percent(NA_counts/dim(data)[1]))
    
    indices_df <- indices_df
    report$NA_indices <- indices_df$data
    #         report <- report %>%
    #             dplyr::group_by(Column_name,NA_count,NA_proportion) 
    
    
    return(report)
    
  }
}