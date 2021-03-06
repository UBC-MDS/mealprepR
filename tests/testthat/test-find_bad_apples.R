# Makes dataframe for testing 'warning is raised for non-numerical data'
df_test1 <- data.frame('A' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, "test"), stringsAsFactors = FALSE)

# Makes dataframe for testing 'warning is raised for insufficient'
df_test2 <- data.frame('A' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1))

# Makes dataframe for testing 'positive and negative outliers are detected'
df_test3 <- data.frame('A' = c(100, -100, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1))

# Makes the output dataframe for testing 'positive and negative outliers are detected'
output <- tidyr::tibble(variable = character(), indices = tidyr::tibble(), total_outliers = integer()) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
addition3 <- tidyr::tibble(variable = 'A', indices = c(1,2), total_outliers = 2) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
df_answer3 <- dplyr::bind_rows(output, addition3) %>% dplyr::rename(indices = data)

# Makes dataframe for testing 'empty output is returned when there are no outliers'
df_test4 <- data.frame('A' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1))

# Makes output dataframe testing 'empty output is returned when there are no outliers'
df_answer4 <- tidyr::tibble(variable = character(), indices = tidyr::tibble(), total_outliers = integer()) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest() %>%
  dplyr::rename(indices = data)

# Makes dataframe for testing 'correct output is returned for data with one column'
df_test5 <- data.frame('A' = c(1, 1, 1, 10, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1))

# Makes output dataframe testing 'correct output is returned for data with one column'
output <- tidyr::tibble(variable = character(), indices = tidyr::tibble(), total_outliers = integer()) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
addition5 <- tidyr::tibble(variable = 'A', indices = c(4), total_outliers = 1) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
df_answer5 <- dplyr::bind_rows(output, addition5) %>% dplyr::rename(indices = data)

# Makes dataframe for testing 'correct output is returned for data with two columns'
df_test6 <- data.frame('A' = c(1, 1, 1, 10, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
                       'B' = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                               1, 1, 1, 1, 1, 1, 1, 1, 1, 10))

# Makes output dataframe testing 'correct output is returned for data with two columns'
output <- tidyr::tibble(variable = character(), indices = tidyr::tibble(), total_outliers = integer()) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
addition6a <- tidyr::tibble(variable = 'A', indices = c(4), total_outliers = 1) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
addition6b <- tidyr::tibble(variable = 'B', indices = c(30), total_outliers = 1) %>%
  dplyr::group_by(variable, total_outliers) %>%
  tidyr::nest()
df_answer6 <- dplyr::bind_rows(output, addition6a)
df_answer6 <- dplyr::bind_rows(df_answer6, addition6b) %>% dplyr::rename(indices = data)

########################

test_that("warning is raised for non-numerical data", {
  expect_warning(find_bad_apples(df_test1), 'Every column in your dataframe must be numeric.')
})

test_that("warning is raised for insufficient", {
  expect_warning(find_bad_apples(df_test2), 'Sorry, you don\'t have enough data. The dataframe needs to have at least 30 rows.')
})

test_that("positive and negative outliers are detected", {
  expect_equal(as.data.frame(find_bad_apples(df_test3)), as.data.frame(df_answer3))
})

test_that("empty output is returned when there are no outliers", {
  expect_true(dim(find_bad_apples(df_test4))[1] == 0)
})

test_that("correct output is returned for data with one column", {
  expect_equal(as.data.frame(find_bad_apples(df_test5)), as.data.frame(df_answer5))
})

test_that("correct output is returned for data with two columns", {
  expect_equal(as.data.frame(find_bad_apples(df_test6)), as.data.frame(df_answer6))
})

