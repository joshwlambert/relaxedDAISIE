test_that("choose_best_model works", {
  best_model <- choose_best_model(data_name = "Canaries", model = "cr_dd")
  expect_true(is.data.frame(best_model))
  expect_true(all(
    c("lambda_c", "mu", "K", "gamma", "lambda_a",
      "loglik", "df", "conv", "bic") %in% colnames(best_model)
  ))
})
