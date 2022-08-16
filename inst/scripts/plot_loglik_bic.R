islands <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas",
             "New_Caledonia", "SaoTome_Principe")

results_tbl <- daisie_results_as_df(islands = islands)

# plot
ggplot2::ggplot(data = results_tbl) +
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
