data <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas", "New_Caledonia", "SaoTome_Principe")

data_tbl <- data.frame()

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

  # get which files for the model
  files <- files[-grep(pattern = "cr_dd", x = files)]

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


  results_tbl <- Reduce(rbind, results)
  island_model <- gsub(pattern = "_[0-9]+.rds$", replacement = "", x = files)
  island <- gsub("_rr.*","",island_model)
  model <- gsub(pattern = paste0(island[1], "_"), replacement = "", island_model)
  results_tbl$model <- model
  results_tbl$island <- island

  data_tbl <- rbind(data_tbl, results_tbl)
}


ggplot2::ggplot(data = data_tbl) +
  ggplot2::geom_boxplot(
    mapping = ggplot2::aes(
      x = model,
      y = loglik,
      fill = model
    )
  ) +
  ggplot2::facet_wrap(
    facets = "island", scales = "free", strip.position = "bottom"
  ) +
  ggplot2::geom_hline(yintercept = 0, linetype = "dashed") +
  ggplot2::scale_y_continuous(name = "DAISIE loglikelihood") +
  ggplot2::scale_x_discrete(
    name = "Relaxed-rate DAISIE model",
    labels = c(
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
    breaks = c("rr_gam_dd", "rr_k", "rr_laa_dd", "rr_lac_dd", "rr_mu_dd"),
    labels = c("Colonisation", "Carrying Capacity", "Anagenesis", "Cladogenesis", "Extinction")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(
    strip.background = ggplot2::element_blank(),
    strip.text = ggplot2::element_text(size = 12),
    strip.placement = "outside"
  )

#labeller = ggplot2::labeller(list(
#  "Canaries" = "Canaries",
#  "Comoros" = "Comoros",
#  "Galapagos" = "Galapagos",
#  "Hawaii" = "Hawaii",
#  "Marquesas" = "Marquesas",
#  "New_Caledonia" = "New Caledonia",
#  "SaoTome_Principe" = "Sao Tome & Principe"
#))
