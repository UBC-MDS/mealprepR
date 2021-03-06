% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_bad_apples.R
\name{find_bad_apples}
\alias{find_bad_apples}
\title{Find bad apples}
\usage{
find_bad_apples(df)
}
\arguments{
\item{df}{A dataframe containing numeric data}
}
\value{
A dataframe with columns for 'variable' (dataframe column name),
'total_outliers' (number of outliers in the column), and
'indices' (list of row indices with outliers)
}
\description{
This function uses a univariate approach to outlier detection.
For each column with outliers (values that are 2 or more standard deviations from the mean),
this function will create a reference list of row indices with outliers, and
the total number of outliers in that column.

Note: This function works best for small datasets with unimodal variable distributions.
}
\examples{
df <- data.frame('A' = c(1, 1, 1, 10, 1, 1, 1, 1, 1, 1,
                         1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                         1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                 'B' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                         1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                         1, 1, 1, 1, 1, 1, 1, 1, 1, 10))

find_bad_apples(df)

}
