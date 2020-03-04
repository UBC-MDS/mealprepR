#' find_bad_apples Documentation
#'
#' @description
#' This function uses a univariate approach to outlier detection.
#' For each column with outliers (values that are 2 or more standard deviations from the mean),
#' this function will create a reference list of row indices with outliers, and
#' the total number of outliers in that column.
#'
#' Note: This function works best for small datasets with unimodal variable distributions.
#'
#' @param df A dataframe containing numeric data
#'
#' @return A dataframe with columns for 'variable' (dataframe column name),
#' 'total_outliers' (number of outliers in the column), and
#' 'indices' (list of row indices with outliers)
#'
#' @examples
#' find_bad_apples(df)
#'
#' @export

find_bad_apples <- function(df) {

  # Returns a warning and stops the function if the dataframe includes non-numeric values
  nums <- unlist(lapply(df, is.numeric))
  if (dim(df)[2] != sum(nums)){
    warning('Every column in your dataframe must be numeric.')
    return()

    # Returns a warning and stops the function if the dataframe has fewer than 30 rows
  } else {
    if (dim(df)[1] < 30){
      warning('Sorry, you don\'t have enough data. The dataframe needs to have at least 30 rows.')
      return()

    } else {
      # Creates empty output dataframe that will be added to
      output <- tidyr::tibble(variable = character(),
                       indices = tidyr::tibble(),
                       total_outliers = integer()) %>%
        dplyr::group_by(variable, total_outliers) %>%
        dplyr::nest()

      columns = names(df)
      c <- 1

      for (column in columns){

        # Finds the mean and standard deviation for each column in the dataframe
        mean = mean(df[,c])
        sd = sd(df[,c])

        col <- 1
        ind <- c()
        tot <- 0

        r <- 1

        # Evaluates each value in a column to see if it's an outlier
        values = df[,c]
        for(value in values){
          if (((mean - 2*sd) <= value & value <= (mean + 2*sd)) == TRUE){
            r <- r + 1
          } else {

            # Adds the indices of any found outliers to 'ind'
            # And adds 1 to the total number of outliers for each outlier found
            if (((mean - 2*sd) <= value & value <= (mean + 2*sd)) == FALSE){
              ind <- c(ind, r)
              tot <- tot + 1
              r <- r + 1
            } else {
              next
            }
          }
        }
        c <- c + 1
        col <- col + 1

        if (tot == 0){
          next}
        else {
          # Creates a row for each column with outliers
          addition <- tidyr::tibble(variable = column,
                             indices = ind,
                             total_outliers = tot) %>%
            dplyr::group_by(variable, total_outliers) %>%
            dplyr::nest()

          # Appends the row of outlier data to the 'output' dataframe
          output <- dplyr::bind_rows(output, addition)
        }
      }
    }
  }
  # Cleans up and returns the 'output' dataframe
  output <- output %>% rename(indices = data)
  return(output)
}
