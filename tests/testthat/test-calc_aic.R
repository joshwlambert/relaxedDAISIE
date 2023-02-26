test_that("calc_aic works as expected", {
  data("Comoros")
  best_model <- choose_best_model(data_name = "Comoros", model = "cr_dd")
  aic <- calc_aic(results = best_model, daisie_data = Comoros)
  expect_type(aic, "double")
  expect_length(aic, 1)
  expect_equal(aic, 474.6302, tolerance = 1e-3)
})

test_that("calc_aicc works as expected", {
  data("Comoros")
  best_model <- choose_best_model(data_name = "Comoros", model = "cr_dd")
  aicc <- calc_aicc(results = best_model, daisie_data = Comoros)
  expect_type(aicc, "double")
  expect_length(aicc, 1)
  expect_equal(aicc, 468.6902, tolerance = 1e-3)
})
