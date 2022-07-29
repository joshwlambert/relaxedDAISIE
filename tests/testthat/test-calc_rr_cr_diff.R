test_that("calc_rr_cr_diff works with infinite upper bound", {
  utils::data("Galapagos")

  # Cladogenesis non-endemic singleton lineage
  suppressMessages(invisible(capture.output(
    res <- calc_rr_cr_diff(
      island_clade = Galapagos[[6]],
      relaxed_par = "cladogenesis",
      sd = seq(0.1, 0.5, 0.1),
      par_upper_bound = Inf
    )
  )))
  expect_true(is.data.frame(res))
  expect_equal(colnames(res), c("sd", "delta_loglik"))
  expect_length(res$sd, 5)
  expect_length(res$delta_loglik, 5)
  expect_equal(res$sd, seq(0.1, 0.5, 0.1))
  expect_equal(
    res$delta_loglik,
    c(0.0153674379906, 0.0577798617692, 0.1183728818772,
      0.1874744710988, 0.2576194260618),
    tolerance = 1e-5
  )
})

test_that("calc_rr_cr_diff works with finite upper bound", {
  utils::data("Galapagos")

  # Cladogenesis non-endemic singleton lineage
  suppressMessages(invisible(capture.output(
    res <- calc_rr_cr_diff(
      island_clade = Galapagos[[6]],
      relaxed_par = "cladogenesis",
      sd = seq(0.1, 0.5, 0.1),
      par_upper_bound = 100
    )
  )))
  expect_true(is.data.frame(res))
  expect_equal(colnames(res), c("sd", "delta_loglik"))
  expect_length(res$sd, 5)
  expect_length(res$delta_loglik, 5)
  expect_equal(res$sd, seq(0.1, 0.5, 0.1))
  expect_equal(
    res$delta_loglik,
    c(0.0153674379906, 0.0577798617692, 0.1183728818772,
      0.1874744710988, 0.2576194260618),
    tolerance = 1e-5
  )
})
