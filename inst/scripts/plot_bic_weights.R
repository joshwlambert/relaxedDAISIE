# script to collate all the DAISIE maximum likelihood parameter estimates for
# each island

# Canaries

# canaries does not have results for relaxed carrying capacity so requires a
# different set of models

model_list <- list(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd"
)
canaries_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Canaries"
)
comoros_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Comoros"
)
galapagos_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Galapagos"
)
hawaii_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Hawaii"
)
marquesas_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "Marquesas"
)
new_caledonia_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "New_Caledonia"
)
saotome_principe_best_model <- lapply(
  model_list,
  relaxedDAISIE::choose_best_model,
  data_name = "SaoTome_Principe"
)
names(canaries_best_model) <- model_list
names(comoros_best_model) <- model_list
names(galapagos_best_model) <- model_list
names(hawaii_best_model) <- model_list
names(marquesas_best_model) <- model_list
names(new_caledonia_best_model) <- model_list
names(saotome_principe_best_model) <- model_list

canaries_best_bic <- sapply(canaries_best_model, "[[", "bic")
comoros_best_bic <- sapply(comoros_best_model, "[[", "bic")
galapagos_best_bic <- sapply(galapagos_best_model, "[[", "bic")
hawaii_best_bic <- sapply(hawaii_best_model, "[[", "bic")
marquesas_best_bic <- sapply(marquesas_best_model, "[[", "bic")
new_caledonia_best_bic <- sapply(new_caledonia_best_model, "[[", "bic")
saotome_principe_best_bic <- sapply(saotome_principe_best_model, "[[", "bic")

canaries_bic_tbl <- data.frame(
  island = "canaries",
  model = names(canaries_best_bic),
  bic = canaries_best_bic,
  delta_bic = canaries_best_bic - min(canaries_best_bic)
)
comoros_bic_tbl <- data.frame(
  island = "comoros",
  model = names(comoros_best_bic),
  bic = comoros_best_bic,
  delta_bic = comoros_best_bic - min(comoros_best_bic)
)
galapagos_bic_tbl <- data.frame(
  island = "galapagos",
  model = names(galapagos_best_bic),
  bic = galapagos_best_bic,
  delta_bic = galapagos_best_bic - min(galapagos_best_bic)
)
hawaii_bic_tbl <- data.frame(
  island = "hawaii",
  model = names(hawaii_best_bic),
  bic = hawaii_best_bic,
  delta_bic = hawaii_best_bic - min(hawaii_best_bic)
)
marquesas_bic_tbl <- data.frame(
  island = "marquesas",
  model = names(marquesas_best_bic),
  bic = marquesas_best_bic,
  delta_bic = marquesas_best_bic - min(marquesas_best_bic)
)
new_caledonia_bic_tbl <- data.frame(
  island = "new_caledonia",
  model = names(new_caledonia_best_bic),
  bic = new_caledonia_best_bic,
  delta_bic = new_caledonia_best_bic - min(new_caledonia_best_bic)
)
saotome_principe_bic_tbl <- data.frame(
  island = "saotome_principe",
  model = names(saotome_principe_best_bic),
  bic = saotome_principe_best_bic,
  delta_bic = saotome_principe_best_bic - min(saotome_principe_best_bic)
)

# canaries BIC weight
canaries_bic_tbl$rel_lik <- exp(-0.5 * canaries_bic_tbl$delta_bic)
canaries_bic_tbl$bic_weight <- canaries_bic_tbl$rel_lik /
  sum(canaries_bic_tbl$rel_lik)

# comoros BIC weight
comoros_bic_tbl$rel_lik <- exp(-0.5 * comoros_bic_tbl$delta_bic)
comoros_bic_tbl$bic_weight <- comoros_bic_tbl$rel_lik /
  sum(comoros_bic_tbl$rel_lik)

# Galapagos BIC weight
galapagos_bic_tbl$rel_lik <- exp(-0.5 * galapagos_bic_tbl$delta_bic)
galapagos_bic_tbl$bic_weight <- galapagos_bic_tbl$rel_lik /
  sum(galapagos_bic_tbl$rel_lik)

# Hawaii BIC weight
hawaii_bic_tbl$rel_lik <- exp(-0.5 * hawaii_bic_tbl$delta_bic)
hawaii_bic_tbl$bic_weight <- hawaii_bic_tbl$rel_lik /
  sum(hawaii_bic_tbl$rel_lik)

# Marquesas BIC weight
marquesas_bic_tbl$rel_lik <- exp(-0.5 * marquesas_bic_tbl$delta_bic)
marquesas_bic_tbl$bic_weight <- marquesas_bic_tbl$rel_lik /
  sum(marquesas_bic_tbl$rel_lik)

# New Caledonia BIC weight
new_caledonia_bic_tbl$rel_lik <- exp(-0.5 * new_caledonia_bic_tbl$delta_bic)
new_caledonia_bic_tbl$bic_weight <- new_caledonia_bic_tbl$rel_lik /
  sum(new_caledonia_bic_tbl$rel_lik)

# Sao Tome and Principe BIC weight
saotome_principe_bic_tbl$rel_lik <-
  exp(-0.5 * saotome_principe_bic_tbl$delta_bic)
saotome_principe_bic_tbl$bic_weight <- saotome_principe_bic_tbl$rel_lik /
  sum(saotome_principe_bic_tbl$rel_lik)

bic_tbl <- rbind(canaries_bic_tbl,
                 comoros_bic_tbl,
                 galapagos_bic_tbl,
                 hawaii_bic_tbl,
                 marquesas_bic_tbl,
                 new_caledonia_bic_tbl,
                 saotome_principe_bic_tbl
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
      "cr_dd", "rr_k", "rr_laa_dd", "rr_lac_dd", "rr_mu_dd"
    ),
    labels = c(
      "HR",
      "Carrying Capacity",
      "Anagenesis",
      "Cladogenesis",
      "Extinction"
    ),
    values = c("#8DD3C7", "#BEBADA", "#FB8072", "#80B1D3", "#FDB462")
  ) +
  ggplot2::scale_y_continuous(name = "BIC Weight") +
  ggplot2::scale_x_discrete(
  name = "Archipelago",
  labels = c(
    "canaries" = "Canaries",
    "comoros" = "Comoros",
    "galapagos" = "Galápagos",
    "hawaii" = "Hawaii",
    "marquesas" = "Marquesas",
    "new_caledonia" = "New Caledonia",
    "saotome_principe" = "São Tomé & Príncipe"
  )
)

# add rows to create legend subheading
bic_tbl <- rbind(
  bic_tbl,
  data.frame(
    island = unique(bic_tbl$island),
    model = "Relaxed-rate",
    bic = 0,
    delta_bic = 0,
    rel_lik = 0,
    bic_weight = 1e-10
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
      "cr_dd", "Relaxed-rate", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd"
    ),
    labels = c(
      "Homogeneous-rate",
      "**Relaxed-rate**",
      "Cladogenesis",
      "Extinction",
      "Carrying Capacity",
      "Anagenesis"
    ),
    values = colour <- c(
      "#8DD3C7", "white", "#80B1D3", "#FDB462", "#BEBADA", "#FB8072"
    )
  ) +
  ggplot2::scale_y_continuous(name = "BIC Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "canaries" = "Canaries",
      "comoros" = "Comoros",
      "galapagos" = "Galápagos",
      "hawaii" = "Hawaii",
      "marquesas" = "Marquesas",
      "new_caledonia" = "New Caledonia",
      "saotome_principe" = "São Tomé & Príncipe"
    )
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.text = ggtext::element_markdown())

ggplot2::ggsave(
  plot = bic_weights,
  filename = file.path("inst", "plots", "bic_weights.png"),
  device = "png",
  width = 250,
  height = 150,
  units = "mm",
  dpi = 300
)
