islands <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas",
             "New_Caledonia", "SaoTome_Principe")

results_tbl <- daisie_results_as_df(islands = islands)

ggplot2::ggplot(data = results_tbl) +
  ggplot2::geom_boxplot(
    mapping = ggplot2::aes(
      x = model,
      y = loglik,
      fill = model
    )
  ) +
  ggplot2::facet_wrap(
    facets = "island", scales = "free",
    strip.position = "bottom",
    labeller = ggplot2::labeller("island" = c(
      "Canaries" = "Canaries",
      "Comoros" = "Comoros",
      "Galapagos" = "Galápagos",
      "Hawaii" = "Hawai'i",
      "Marquesas" = "Marquesas",
      "New_Caledonia" = "New Caledonia",
      "SaoTome_Principe" = "São Tomé & Príncipe"
    ))
  ) +
  ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
  ggplot2::scale_y_continuous(name = "DAISIE loglikelihood") +
  ggplot2::scale_x_discrete(
    name = "Relaxed-rate DAISIE model",
    labels = c(
      "cr_dd" = "HR",
      "rr_gam_dd" = "Col",
      "rr_k" = "K'",
      "rr_laa_dd" = "Ana",
      "rr_lac_dd" = "Clado",
      "rr_mu_dd" = "Ext"
    )
  ) +
  ggplot2::scale_fill_brewer(
    palette = "Set3",
    name = "Model",
    breaks = c(
      "cr_dd", "rr_gam_dd", "rr_k", "rr_laa_dd", "rr_lac_dd", "rr_mu_dd"
    ),
    labels = c(
      "HR",
      "Colonisation",
      "Carrying Capacity",
      "Anagenesis",
      "Cladogenesis",
      "Extinction"
    )
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(
    strip.background = ggplot2::element_blank(),
    strip.text = ggplot2::element_text(size = 12),
    strip.placement = "outside"
  )
