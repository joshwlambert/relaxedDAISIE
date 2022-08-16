test_that("daisie_results_as_df works", {
  tbl <- daisie_results_as_df(islands = "Canaries")
  expect_equal(nrow(tbl), 25)
  expect_equal(ncol(tbl), 12)
  expect_equal(
    colnames(tbl),
    c("lambda_c", "mu", "K", "gamma", "lambda_a", "loglik", "df", "conv", "bic",
      "sd", "model", "island")
  )
  expect_true(is.numeric(tbl$lambda_c))
  expect_true(is.numeric(tbl$mu))
  expect_true(is.numeric(tbl$K))
  expect_true(is.numeric(tbl$gamma))
  expect_true(is.numeric(tbl$lambda_a))
  expect_true(is.numeric(tbl$loglik))
  expect_true(is.numeric(tbl$df))
  expect_true(is.numeric(tbl$conv))
  expect_true(is.numeric(tbl$bic))
  expect_true(is.numeric(tbl$sd))
  expect_true(is.character(tbl$model))
  expect_true(is.character(tbl$island))
})
