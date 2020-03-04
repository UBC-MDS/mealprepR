testthat::test_that("find_fruits_veg has the following behaviour:
     1. If the find_fruits_veg find numerical column correctly
     2. If the find_fruits_veg find categorical column correctly
     3. If the find_fruits_veg can handle dataframe with NAs.
     4. If the find_fruits_veg can handle empty dataframe.", {
  df1 = data.frame(a =c(1:4, NA), b =c(1, NA, 3:5))
  df2 = data.frame(a =c(1, NA), b =c(NA, 3))

  testthat::expect_equal(find_fruits_veg(iris, 'num'), c(1,2,3,4))
  testthat::expect_equal(find_fruits_veg(iris, 'categ'), c(5))
  testthat::expect_equal(find_fruits_veg(df1, 'num'), c(1,2))
  testthat::expect_equal(find_fruits_veg(df2, 'num'), 'It is a empty data frame or too many missing data')
})
