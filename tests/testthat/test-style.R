test_that("follow Tidyverse style", {
  skip_on_ci()
  lintr::expect_lint_free()
})
