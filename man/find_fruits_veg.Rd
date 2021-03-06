% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_fruits_veg.R
\name{find_fruits_veg}
\alias{find_fruits_veg}
\title{find_fruits_veg Documentation}
\usage{
find_fruits_veg(df, type_of_out = "categ")
}
\arguments{
\item{df}{An input dataframe}

\item{type_of_out}{A character that indicates the wanted type (numeric/ categorical) of data}
}
\value{
A vector of indices of wanted data type (numeric/ categorical)
}
\description{
Returns the indices of numeric and categorical variables in the dataset
}
\examples{
find_fruits_veg(iris, 'num')
}
