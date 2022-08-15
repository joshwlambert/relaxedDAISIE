data <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas", "New_Caledonia", "SaoTome_Principe")

# before outliers are removed

model_fit_tbl <- data.frame()

for (data_name in data) {
  # get the files names
  files <- list.files(
    system.file(
      "extdata",
      "raw_daisie_output",
      data_name,
      package = "relaxedDAISIE",
      mustWork = TRUE
    )
  )

  # read in the data
  results <- lapply(
    as.list(
      system.file(
        "extdata",
        "raw_daisie_output",
        data_name,
        files,
        package = "relaxedDAISIE",
        mustWork = TRUE
      )
    ),
    readRDS
  )

  model_fit <- lapply(results, \(x) {
    x[c("loglik", "bic")]
  })

  temp_model_fit_tbl <- Reduce(rbind, model_fit)

  temp_model_fit_tbl$island <- rep(data_name, nrow(temp_model_fit_tbl))

  model_fit_tbl <- rbind(model_fit_tbl, temp_model_fit_tbl)
}

# plot
ggplot2::ggplot(data = model_fit_tbl) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = loglik,
      y = bic,
      colour = island),
    size = 4,
    alpha = 0.5
  )

# explode the points vertically to see the groupings
ggplot2::ggplot(data = model_fit_tbl) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = loglik,
      y = bic,
      colour = island
    ),
    size = 4,
    alpha = 0.5,
    position = ggplot2::position_jitter(height = 100)
  )

#plot the individual islands
island <- "Comoros"

ggplot2::ggplot(data = dplyr::filter(model_fit_tbl, island == island)) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = loglik,
      y = bic
    ),
    size = 4,
    alpha = 0.5
  )


# after outliers are removed
