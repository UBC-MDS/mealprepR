testthat::test_that("find_missing_ingredients has the following behaviour:
     1. If the function find_missing_ingredients returns a string if there are no missing values
     2. If the function find_missing_ingredients returns a data frame with the correct dimensions
     3. If the function find_missing_ingredients returns a data frame with the correct column names
     4. If the function find_missing_ingredients returns a data frame with the correct NA counts
     5. If the function find_missing_ingredients returns a data frame with the correct NA proportions", {
   
  # Creating example data frames         
  tb1 <- data.frame("letters" = c("a","b","c"),"numbers" = c(1,2,3))
  tb2 <- data.frame("letters" = c(NA,"b"),"numbers" = c(NA,NA))
  
  # Creating expected function output
  fn_result <- find_missing_ingredients(tb2)

  temp_result <- data.frame("Column_name"=c("letters","numbers"),
                          "NA_count"=c(1,2),
                          "NA_proportion"=as.factor(scales::percent(c(.50,1))))
  indices_result <- data.frame("NA_indices"= tidyr::tibble(1)) %>%
    tidyr::nest(data = tidyr::everything())
  
  addition_ind <- data.frame("NA_indices"= tidyr::tibble(1,2)) %>%
    tidyr::nest(data = tidyr::everything())
  
  indices_result <- dplyr::bind_rows(indices_result, addition_ind)
  
  temp_result$NA_indices <- indices_result$data
  
  exp_result <- temp_result
  
  
  testthat::expect_equal(find_missing_ingredients(tb1), "There are no missing values")
  testthat::expect_equal(dim(fn_result), dim(exp_result))
  testthat::expect_equal(names(fn_result), names(exp_result))
  testthat::expect_equal(fn_result$NA_count, exp_result$NA_count)  
  testthat::expect_equal(fn_result$NA_proportion, exp_result$NA_proportion)
})
