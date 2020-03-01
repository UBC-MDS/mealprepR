# creating some testing data
X_example <- dplyr::as_tibble(mtcars) %>%
  dplyr::mutate(carb = as.factor(carb),
                gear = as.factor(gear),
                vs = as.factor(vs),
                am = as.factor(am))
y_example <- "gear"


test_that("Correct dataframes are returned.", {

  train_test <- make_recipe(
    X = X_example,
    y = y_example,
    recipe = "ohe_and_standard_scaler",
    splits_to_return="train_test")

  train_test_valid <- make_recipe(
    X = X_example,
    y = y_example,
    recipe = "ohe_and_standard_scaler",
    splits_to_return="train_test_valid")

  expect_equal(length(train_test), 6, label = "train_test did not return list of length 6.")
  expect_equal(length(train_test_valid), 6, label = "train_test did not return list of length 6.")
  expect_true(nrow(train_test$X_valid) == 0, label = "Validation data should be empty.")
  expect_true(nrow(train_test_valid$X_valid) > 0, label = "Validation data should contain data.")
  nrow_train_test <- nrow(train_test$X_train) + nrow(train_test$X_valid) + nrow(train_test$X_test)
  nrow_train_test_valid <- nrow(train_test_valid$X_train) + nrow(train_test_valid$X_valid) + nrow(train_test_valid$X_test)
  expect_true(nrow_train_test == nrow(X_example), "Split data has incorrect number of rows for train_test.")
  expect_true(nrow_train_test_valid == nrow(X_example), "Split data has incorrect number of rows for train_test_valid.")

})
