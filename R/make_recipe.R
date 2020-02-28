#' make_recipe Documentation
#'
#' @description
#' The `make_recipe()` function is used to quickly apply common data preprocessing techniques
#'
#' @param data A dataframe containing training data, validation data, X, and y
#' @param recipe A string specifying which recipe to apply to the data
#' @param create_train_test Boolean, if TRUE will partition data into train and test
#' @param create_train_valid_test Boolean, if TRUE will partition data into train, valid, and test
#'
#' @return A list of dataframes e.g. list(train, valid, test)
#'
#' @section Recipes
#'
#' The following recipes are available currently available to pass into the `recipe` parameter:
#'
#' "ohe_and_standard_scaler"
#'
#' Apply one hot encoding to categorical features and standard scaler to numeric features
#'
#' @examples
#' make_recipe(iris, "ohe_and_standard_scaler")
#'
#' @export

make_recipe <- function(data, recipe, create_train_test = FALSE, create_train_valid_test = TRUE) {
  # insert code here
}
