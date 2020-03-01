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

make_recipe <- function(X, y, recipe, splits_to_return="train_test") {

  # validate inputs
  testthat::test_that("An invalid parameter was entered, please review the documentation.", {
    testthat::expect_true(nrow(X), nrow(y), label = "X and y should have the same number of observations.")
    testthat::expect_true(recipe %in% c("ohe_and_standard_scaler"), label = "Please select a valid string option for recipe.")
  })

  # split data
  train_valid_index <- caret::createDataPartition(y = dplyr::pull(X[,y]), p = 0.8, list = FALSE)
  X_train_valid <- X[train_valid_index,]
  X_test <- X[-train_valid_index,] %>% dplyr::select(-y)
  train_index <- caret::createDataPartition(y = dplyr::pull(X_train_valid[,y]), p = 0.8, list = FALSE)
  X_train <- X_train_valid[train_index,] %>% dplyr::select(-y)
  X_valid <- X_train_valid[-train_index,] %>% dplyr::select(-y)

  # determine column types
  numerics <- dplyr::select_if(X_train, is.numeric) %>% colnames()
  categorics <- dplyr::select_if(X_train, is.character) %>% colnames()
  categorics <- c(categorics, dplyr::select_if(X_train, is.factor) %>% colnames())

  # preprocess data
  if (recipe == "ohe_and_standard_scaler") {
    # numerics
    num_transformer <- caret::preProcess(X_train, method = c("center", "scale"))
    # categoricals
    X_train <- dplyr::mutate_if(X_train, is.character, as.factor)
    cat_transformer <- caret::dummyVars(~., data = X_train)
  } else {
    stop("Please select a valid string option for recipe.")
  }

  # apply preprocess transformations
  X_train <- predict(num_transformer, newdata = X_train)
  X_train <- dplyr::as_tibble(predict(cat_transformer, newdata = X_train)) %>%
    janitor::clean_names()
  X_valid <- predict(num_transformer, newdata = X_valid)
  X_valid <- dplyr::as_tibble(predict(cat_transformer, newdata = X_valid)) %>%
    janitor::clean_names()
  X_test <- predict(num_transformer, newdata = X_test)
  X_test <- dplyr::as_tibble(predict(cat_transformer, newdata = X_test)) %>%
    janitor::clean_names()

  return(list("X_train" = X_train))
}

X <- dplyr::as_tibble(mtcars) %>%
  dplyr::mutate(carb = as.factor(carb),
                gear = as.factor(gear),
                vs = as.factor(vs),
                am = as.factor(am))
y <- "gear"
X[,y]
