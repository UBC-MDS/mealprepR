#' make_recipe Documentation
#'
#' @description
#' The `make_recipe()` function is used to quickly apply common data preprocessing techniques
#'
#' @param X A dataframe containing training data, validation data, and testing data (should contain X and y).
#' @param y The name of the response column (as a string, e.g. "response_variable").
#' @param recipe A string specifying which recipe to apply to the data. See "The recipe parameter" section below for details.
#' @param splits_to_return A string specifying how to split the data. "train_test" to return train and test splits, "train_test_valid" to return train, test, and validation data, "train" to return all data without splits.
#' @param random_seed An integer. The random seed to set for splitting data to create reproducible results. By default NULL
#' @param train_valid_prop A float. The proportion to split the data by. Should range between 0 to 1. By default = 0.8
#'
#' @return A list of dataframes e.g. list(X_train, X_valid, X_test, y_train, y_valid, y_test)
#'
#' @section The recipe parameter:
#' The following recipes are available currently to pass into the `recipe` parameter:
#' * "ohe_and_standard_scaler" - Apply one hot encoding to categorical features and standard scaler to numeric features
#'
#' More recipes are under development and will be released in future updates.
#'
#' @md
#'
#' @examples
#' # apply "ohe_and_standard_scaler" on training and testing data
#' X_example <- dplyr::as_tibble(mtcars) %>%
#'   dplyr::mutate(
#'     carb = as.factor(carb),
#'     gear = as.factor(gear),
#'     vs = as.factor(vs),
#'     am = as.factor(am)
#'   )
#' y_example <- "gear"
#' make_recipe(X = X_example, y = y_example, recipe = "ohe_and_standard_scaler", splits_to_return = "train_test")
#' @export
make_recipe <- function(X, y, recipe, splits_to_return = "train_test", random_seed = NULL, train_valid_prop = 0.8) {
  set.seed(random_seed)

  # validate inputs
  testthat::test_that("An invalid parameter was entered, please review the documentation.", {
    testthat::expect_true(recipe %in% c("ohe_and_standard_scaler"), label = "Please select a valid string option for recipe.")
    testthat::expect_true(splits_to_return %in% c("train_test", "train_test_valid"), label = "Please enter a valid string for splits_to_return.")
  })

  # split data
  if (splits_to_return == "train_test") {
    train_index <- caret::createDataPartition(y = dplyr::pull(X[, y]), p = train_valid_prop, list = FALSE)
    X_train <- X[train_index, ] %>% dplyr::select(-y)
    X_valid <- dplyr::tibble()
    X_test <- X[-train_index, ] %>% dplyr::select(-y)
    y_train <- X[train_index, ] %>% dplyr::select(y)
    y_valid <- dplyr::tibble()
    y_test <- X[-train_index, ] %>% dplyr::select(y)
  } else if (splits_to_return == "train_test_valid") {
    train_valid_index <- caret::createDataPartition(y = dplyr::pull(X[, y]), p = train_valid_prop, list = FALSE)
    X_train_valid <- X[train_valid_index, ]
    train_index <- caret::createDataPartition(y = dplyr::pull(X_train_valid[, y]), p = train_valid_prop, list = FALSE)
    X_train <- X_train_valid[train_index, ] %>% dplyr::select(-y)
    X_valid <- X_train_valid[-train_index, ] %>% dplyr::select(-y)
    X_test <- X[-train_valid_index, ] %>% dplyr::select(-y)
    y_train <- X_train_valid[train_index, ] %>% dplyr::select(y)
    y_valid <- X_train_valid[-train_index, ] %>% dplyr::select(y)
    y_test <- X[-train_valid_index, ] %>% dplyr::select(y)
  } else {
    stop("splits_to_return should be either 'train_test' or 'train_test_valid'.")
  }

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
  if (splits_to_return == "train_test_valid") {
    X_valid <- predict(num_transformer, newdata = X_valid)
    X_valid <- dplyr::as_tibble(predict(cat_transformer, newdata = X_valid)) %>%
      janitor::clean_names()
  }
  X_test <- predict(num_transformer, newdata = X_test)
  X_test <- dplyr::as_tibble(predict(cat_transformer, newdata = X_test)) %>%
    janitor::clean_names()

  return(list(
    "X_train" = X_train, "X_valid" = X_valid, "X_test" = X_test,
    "y_train" = y_train, "y_valid" = y_valid, "y_test" = y_test
  ))
}
