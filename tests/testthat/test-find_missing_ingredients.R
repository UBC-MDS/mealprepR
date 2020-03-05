testthat::test_that("find_fruits_veg has the following behaviour:
     1. If the function find_missing_ingredients returns a string if there are no missing values
     2. If the function find_missing_ingredients returns a data frame with the correct dimensions
     3. If the function find_missing_ingredients returns a data frame with the correct column names
     4. If the function find_missing_ingredients returns a data frame with the correct NA counts
     5. If the function find_missing_ingredients returns a data frame with the correct NA proportions, {
  tb1 = tibble("letters" = c("a","b","c"),"numbers" = c(1,2,3))
  tb2 = tibble("letters" = c(NA,"b"),"numbers" = c(NA,NA))
  fn_result = find_missing_ingredients(tb2)
  exp_result = tibble("Column_name"=c("letters","numbers"),"NA_count"=c(1,2),"NA_proportion"=as.factor(percent(c(.50,1))))
  testthat::expect_equal(find_missing_ingredients(tb1), "There are no missing values")
  testthat::expect_equal(dim(fn_result), dim(exp_result))
  testthat::expect_equal(names(fn_result), names(exp_result))
  testthat::expect_equal(fn_result$NA_count, exp_result$NA_count)  
  testthat::expect_equal(fn_result$NA_proportion, exp_result$NA_proportion)
})
