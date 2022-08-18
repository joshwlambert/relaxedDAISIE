# script to collate all the DAISIE maximum likelihood parameter estimates for
# each island

# Canaries

# canaries does not have results for relaxed carrying capacity so requires a
# different set of models

model_list <- list(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd"
)

galapagos_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Galapagos"
)
marquesas_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Marquesas"
)
names(galapagos_best_model) <- model_list
names(marquesas_best_model) <- model_list

model_list_2type <- list(
  "cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k", "cr_dd_2type_lac_mu",
  "cr_dd_2type_lac_k", "cr_dd_2type_mu_k", "cr_dd_2type_lac_mu_k"
)

galapagos_best_2type_model <- lapply(
  model_list_2type,
  relaxedDAISIE::choose_best_model,
  data_name = "Galapagos_2type"
)
marquesas_best_2type_model <- lapply(
  model_list_2type,
  relaxedDAISIE::choose_best_model,
  data_name = "Marquesas_2type"
)
hawaii_best_2type_model <- lapply(
  model_list_2type,
  relaxedDAISIE::choose_best_model,
  data_name = "Hawaii_2type"
)


names(galapagos_best_2type_model) <- model_list_2type
names(marquesas_best_2type_model) <- model_list_2type
names(hawaii_best_2type_model) <- model_list_2type

hawaii_model_list <- list(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k"
)
hawaii_best_model <- lapply(
  hawaii_model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Hawaii"
)
names(hawaii_best_model) <- hawaii_model_list

galapagos_best_bic <- sapply(galapagos_best_model, "[[", "bic")
galapagos_best_2type_bic <- sapply(galapagos_best_2type_model, "[[", "bic")
hawaii_best_bic <- sapply(hawaii_best_model, "[[", "bic")
hawaii_best_2type_bic <- sapply(hawaii_best_2type_model, "[[", "bic")
marquesas_best_bic <- sapply(marquesas_best_model, "[[", "bic")
marquesas_best_2type_bic <- sapply(marquesas_best_2type_model, "[[", "bic")

galapagos_best_bic <- c(galapagos_best_bic, galapagos_best_2type_bic)
hawaii_best_bic <- c(hawaii_best_bic, hawaii_best_2type_bic)
marquesas_best_bic <- c(marquesas_best_bic, marquesas_best_2type_bic)


galapagos_bic_tbl <- data.frame(
  island = "galapagos",
  model = names(galapagos_best_bic),
  bic = galapagos_best_bic,
  delta_bic = galapagos_best_bic - min(galapagos_best_bic, na.rm = TRUE)
)
hawaii_bic_tbl <- data.frame(
  island = "hawaii",
  model = names(hawaii_best_bic),
  bic = hawaii_best_bic,
  delta_bic = hawaii_best_bic - min(hawaii_best_bic, na.rm = TRUE)
)
marquesas_bic_tbl <- data.frame(
  island = "marquesas",
  model = names(marquesas_best_bic),
  bic = marquesas_best_bic,
  delta_bic = marquesas_best_bic - min(marquesas_best_bic, na.rm = TRUE)
)

# Galapagos BIC weight
galapagos_bic_tbl$rel_lik <- exp(-0.5 * galapagos_bic_tbl$delta_bic)
galapagos_bic_tbl$bic_weight <- galapagos_bic_tbl$rel_lik /
  sum(galapagos_bic_tbl$rel_lik, na.rm = TRUE)

# Hawaii BIC weight
hawaii_bic_tbl$rel_lik <- exp(-0.5 * hawaii_bic_tbl$delta_bic)
hawaii_bic_tbl$bic_weight <- hawaii_bic_tbl$rel_lik /
  sum(hawaii_bic_tbl$rel_lik, na.rm = TRUE)

# Marquesas BIC weight
marquesas_bic_tbl$rel_lik <- exp(-0.5 * marquesas_bic_tbl$delta_bic)
marquesas_bic_tbl$bic_weight <- marquesas_bic_tbl$rel_lik /
  sum(marquesas_bic_tbl$rel_lik, na.rm = TRUE)


bic_tbl <- rbind(galapagos_bic_tbl,
                 hawaii_bic_tbl,
                 marquesas_bic_tbl
)
rownames(bic_tbl) <- NULL

ggplot2::ggplot(data = bic_tbl) +
  ggplot2::geom_bar(
    mapping = ggplot2::aes(
      x = island,
      y = bic,
      fill = model
    ),
    stat = "identity",
    position = "fill"
  ) +
  ggplot2::scale_fill_manual(
    name = "Model",
    breaks = c(
      "cr_dd", "rr_k", "rr_laa_dd", "rr_lac_dd", "rr_mu_dd", "cr_dd_2type_lac",
      "cr_dd_2type_mu", "cr_dd_2type_k", "cr_dd_2type_lac_mu",
      "cr_dd_2type_lac_k", "cr_dd_2type_mu_k", "cr_dd_2type_lac_mu_k"
    ),
    labels = c(
      "HR",
      "Carrying Capacity",
      "Anagenesis",
      "Cladogenesis",
      "Extinction",
      "HR 2type Cladogenesis",
      "HR 2type Extinction",
      "HR 2type Carrying_Capacity",
      "HR 2type Cladogenesis Extinction",
      "HR 2type Cladogenesis Carrying Capacity",
      "HR 2type Extinction_Carrying_Capacity",
      "HR 2type Cladogenesis Extinction Carrying Capacity"
    ),
    values = c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462",
               "#B3DE69", "#FCCDE5", "#D9D9D9", "#BC80BD", "#CCEBC5", "#FFED6F")
  ) +
  ggplot2::scale_y_continuous(name = "BIC Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "galapagos" = "Galápagos",
      "hawaii" = "Hawai'i",
      "marquesas" = "Marquesas"
    )
  )


bic_weights <- ggplot2::ggplot(data = bic_tbl) +
  ggplot2::geom_bar(
    mapping = ggplot2::aes(
      x = island,
      y = bic_weight,
      fill = model
    ),
    stat = "identity"
  ) +
  ggplot2::scale_fill_manual(
    name = "Model",
    breaks = c(
      "cr_dd", "rr_k", "rr_laa_dd", "rr_lac_dd", "rr_mu_dd", "cr_dd_2type_lac",
      "cr_dd_2type_mu", "cr_dd_2type_k", "cr_dd_2type_lac_mu",
      "cr_dd_2type_lac_k", "cr_dd_2type_mu_k", "cr_dd_2type_lac_mu_k"
    ),
    labels = c(
      "HR",
      "Carrying Capacity",
      "Anagenesis",
      "Cladogenesis",
      "Extinction",
      "HR 2type Cladogenesis",
      "HR 2type Extinction",
      "HR 2type Carrying_Capacity",
      "HR 2type Cladogenesis Extinction",
      "HR 2type Cladogenesis Carrying Capacity",
      "HR 2type Extinction Carrying Capacity",
      "HR 2type Cladogenesis Extinction Carrying Capacity"
    ),
    values = c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462",
               "#B3DE69", "#e3e339", "#439c53", "#BC80BD", "#2f2ff7", "#f52f46")
  ) +
  ggplot2::scale_y_continuous(name = "BIC Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "galapagos" = "Galápagos",
      "hawaii" = "Hawai'i",
      "marquesas" = "Marquesas"
    )
  )

ggplot2::ggsave(
  plot = bic_weights,
  filename = file.path("inst", "plots", "bic_weights_post_hoc.png"),
  device = "png",
  width = 250,
  height = 150,
  units = "mm",
  dpi = 300
)
