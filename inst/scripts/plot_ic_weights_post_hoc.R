# script to collate all the DAISIE maximum likelihood parameter estimates for
# each island

data("Galapagos")
data("Galapagos_2type")
data("Hawaii")
data("Hawaii_2type")
data("Marquesas")
data("Marquesas_2type")

model_list <- list(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd"
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
names(galapagos_best_model) <- model_list
names(hawaii_best_model) <- model_list
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

galapagos_best_model <- lapply(
  galapagos_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Galapagos"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Galapagos"))
    )
    galapagos_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(galapagos_best_model)
  }
)

galapagos_best_2type_model <- lapply(
  galapagos_best_2type_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Galapagos_2type"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Galapagos_2type"))
    )
    galapagos_best_2type_model <- cbind(x, aic = aic, aicc = aicc)
    return(galapagos_best_2type_model)
  }
)

hawaii_best_model <- lapply(
  hawaii_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Hawaii"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Hawaii"))
    )
    hawaii_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(hawaii_best_model)
  }
)

hawaii_best_2type_model <- lapply(
  hawaii_best_2type_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Hawaii_2type"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Hawaii_2type"))
    )
    hawaii_best_2type_model <- cbind(x, aic = aic, aicc = aicc)
    return(hawaii_best_2type_model)
  }
)

marquesas_best_model <- lapply(
  marquesas_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Marquesas"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Marquesas"))
    )
    marquesas_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(marquesas_best_model)
  }
)

marquesas_best_2type_model <- lapply(
  marquesas_best_2type_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Marquesas_2type"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Marquesas_2type"))
    )
    marquesas_best_2type_model <- cbind(x, aic = aic, aicc = aicc)
    return(marquesas_best_2type_model)
  }
)

galapagos_best_ic <- sapply(galapagos_best_model, "[", c("bic", "aic", "aicc"))
galapagos_best_2type_ic <- sapply(
  galapagos_best_2type_model, "[", c("bic", "aic", "aicc")
)
hawaii_best_ic <- sapply(hawaii_best_model, "[", c("bic", "aic", "aicc"))
hawaii_best_2type_ic <- sapply(
  hawaii_best_2type_model, "[", c("bic", "aic", "aicc")
)
marquesas_best_ic <- sapply(marquesas_best_model, "[", c("bic", "aic", "aicc"))
marquesas_best_2type_ic <- sapply(
  marquesas_best_2type_model, "[", c("bic", "aic", "aicc")
)

galapagos_best_ic <- cbind(galapagos_best_ic, galapagos_best_2type_ic)
hawaii_best_ic <- cbind(hawaii_best_ic, hawaii_best_2type_ic)
marquesas_best_ic <- cbind(marquesas_best_ic, marquesas_best_2type_ic)

galapagos_ic_tbl <- data.frame(
  island = "galapagos",
  model = colnames(galapagos_best_ic),
  bic = unlist(galapagos_best_ic["bic", ]),
  delta_bic = unlist(galapagos_best_ic["bic", ]) -
    min(unlist(galapagos_best_ic["bic", ])),
  delta_aic = unlist(galapagos_best_ic["aic", ]) -
    min(unlist(galapagos_best_ic["aic", ])),
  delta_aicc = unlist(galapagos_best_ic["aicc", ]) -
    min(unlist(galapagos_best_ic["aicc", ]))
)
hawaii_ic_tbl <- data.frame(
  island = "hawaii",
  model = colnames(hawaii_best_ic),
  bic = unlist(hawaii_best_ic["bic", ]),
  delta_bic = unlist(hawaii_best_ic["bic", ]) -
    min(unlist(hawaii_best_ic["bic", ])),
  delta_aic = unlist(hawaii_best_ic["aic", ]) -
    min(unlist(hawaii_best_ic["aic", ])),
  delta_aicc = unlist(hawaii_best_ic["aicc", ]) -
    min(unlist(hawaii_best_ic["aicc", ]))
)
marquesas_ic_tbl <- data.frame(
  island = "marquesas",
  model = colnames(marquesas_best_ic),
  bic = unlist(marquesas_best_ic["bic", ]),
  delta_bic = unlist(marquesas_best_ic["bic", ]) -
    min(unlist(marquesas_best_ic["bic", ])),
  delta_aic = unlist(marquesas_best_ic["aic", ]) -
    min(unlist(marquesas_best_ic["aic", ])),
  delta_aicc = unlist(marquesas_best_ic["aicc", ]) -
    min(unlist(marquesas_best_ic["aicc", ]))
)

# Galapagos BIC weight
rel_lik <- exp(
  -0.5 * galapagos_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
galapagos_ic_tbl <- cbind(galapagos_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(galapagos_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(galapagos_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")])
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
galapagos_ic_tbl <- cbind(galapagos_ic_tbl, ic_weights)

# Hawaii BIC weight
rel_lik <- exp(
  -0.5 * hawaii_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
hawaii_ic_tbl <- cbind(hawaii_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(hawaii_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(hawaii_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")])
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
hawaii_ic_tbl <- cbind(hawaii_ic_tbl, ic_weights)

# Marquesas BIC weight
rel_lik <- exp(
  -0.5 * marquesas_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
marquesas_ic_tbl <- cbind(marquesas_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(marquesas_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(marquesas_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")])
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
marquesas_ic_tbl <- cbind(marquesas_ic_tbl, ic_weights)


ic_tbl <- rbind(galapagos_ic_tbl,
                hawaii_ic_tbl,
                marquesas_ic_tbl
)
rownames(ic_tbl) <- NULL

ggplot2::ggplot(data = ic_tbl) +
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
      "hawaii" = "Hawaii",
      "marquesas" = "Marquesas"
    )
  )

# add rows to create legend subheading
ic_tbl <- rbind(
  ic_tbl,
  data.frame(
    island = unique(ic_tbl$island),
    model = c(rep("Relaxed-rate", 3), rep("Two-type", 3)),
    bic = 0,
    delta_bic = 0,
    delta_aic = 0,
    delta_aicc = 0,
    bic_rel_lik = 0,
    aic_rel_lik = 0,
    aicc_rel_lik = 0,
    bic_weight = 1e-10,
    aic_weight = 1e-10,
    aicc_weight = 1e-10
  )
)

bic_weights <- ggplot2::ggplot(data = ic_tbl) +
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
      "cr_dd", "Relaxed-rate", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd",
      "Two-type", "cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k",
      "cr_dd_2type_lac_mu", "cr_dd_2type_lac_k", "cr_dd_2type_mu_k",
      "cr_dd_2type_lac_mu_k"
    ),
    labels = c(
      "Homogeneous-rate",
      "**Relaxed-rate**",
      "Cladogenesis",
      "Extinction",
      "Carrying Capacity",
      "Anagenesis",
      "**Two-type**",
      "HR 2type Cladogenesis",
      "HR 2type Extinction",
      "HR 2type Carrying Capacity",
      "HR 2type Cladogenesis Extinction",
      "HR 2type Cladogenesis Carrying Capacity",
      "HR 2type Extinction Carrying Capacity",
      "HR 2type Cladogenesis Extinction Carrying Capacity"
    ),
    values = c("#708090", "white", "#FCAE91", "#FB6A4A", "#DE2D26", "#A50F15",
               "white", "#BAE4B3", "#74C476", "#238B45", "#BDD7E7", "#6BAED6",
               "#3182BD", "#08519C")
  ) +
  ggplot2::scale_y_continuous(name = "BIC Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "galapagos" = "Galápagos",
      "hawaii" = "Hawaii",
      "marquesas" = "Marquesas"
    )
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.text = ggtext::element_markdown())

aic_weights <- ggplot2::ggplot(data = ic_tbl) +
  ggplot2::geom_bar(
    mapping = ggplot2::aes(
      x = island,
      y = aic_weight,
      fill = model
    ),
    stat = "identity"
  ) +
  ggplot2::scale_fill_manual(
    name = "Model",
    breaks = c(
      "cr_dd", "Relaxed-rate", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd",
      "Two-type", "cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k",
      "cr_dd_2type_lac_mu", "cr_dd_2type_lac_k", "cr_dd_2type_mu_k",
      "cr_dd_2type_lac_mu_k"
    ),
    labels = c(
      "Homogeneous-rate",
      "**Relaxed-rate**",
      "Cladogenesis",
      "Extinction",
      "Carrying Capacity",
      "Anagenesis",
      "**Two-type**",
      "HR 2type Cladogenesis",
      "HR 2type Extinction",
      "HR 2type Carrying Capacity",
      "HR 2type Cladogenesis Extinction",
      "HR 2type Cladogenesis Carrying Capacity",
      "HR 2type Extinction Carrying Capacity",
      "HR 2type Cladogenesis Extinction Carrying Capacity"
    ),
    values = c("#708090", "white", "#FCAE91", "#FB6A4A", "#DE2D26", "#A50F15",
               "white", "#BAE4B3", "#74C476", "#238B45", "#BDD7E7", "#6BAED6",
               "#3182BD", "#08519C")
  ) +
  ggplot2::scale_y_continuous(name = "AIC Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "galapagos" = "Galápagos",
      "hawaii" = "Hawaii",
      "marquesas" = "Marquesas"
    )
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.text = ggtext::element_markdown())

aicc_weights <- ggplot2::ggplot(data = ic_tbl) +
  ggplot2::geom_bar(
    mapping = ggplot2::aes(
      x = island,
      y = aicc_weight,
      fill = model
    ),
    stat = "identity"
  ) +
  ggplot2::scale_fill_manual(
    name = "Model",
    breaks = c(
      "cr_dd", "Relaxed-rate", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd",
      "Two-type", "cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k",
      "cr_dd_2type_lac_mu", "cr_dd_2type_lac_k", "cr_dd_2type_mu_k",
      "cr_dd_2type_lac_mu_k"
    ),
    labels = c(
      "Homogeneous-rate",
      "**Relaxed-rate**",
      "Cladogenesis",
      "Extinction",
      "Carrying Capacity",
      "Anagenesis",
      "**Two-type**",
      "HR 2type Cladogenesis",
      "HR 2type Extinction",
      "HR 2type Carrying Capacity",
      "HR 2type Cladogenesis Extinction",
      "HR 2type Cladogenesis Carrying Capacity",
      "HR 2type Extinction Carrying Capacity",
      "HR 2type Cladogenesis Extinction Carrying Capacity"
    ),
    values = c("#708090", "white", "#FCAE91", "#FB6A4A", "#DE2D26", "#A50F15",
               "white", "#BAE4B3", "#74C476", "#238B45", "#BDD7E7", "#6BAED6",
               "#3182BD", "#08519C")
  ) +
  ggplot2::scale_y_continuous(name = "AICc Weight") +
  ggplot2::scale_x_discrete(
    name = "Archipelago",
    labels = c(
      "galapagos" = "Galápagos",
      "hawaii" = "Hawaii",
      "marquesas" = "Marquesas"
    )
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.text = ggtext::element_markdown())

# create combined plot
ic_plot <- cowplot::plot_grid(
  bic_weights + ggplot2::theme(
    legend.position = "none",
    axis.text.x = ggplot2::element_text(angle = 30, hjust = 1)
  ),
  aicc_weights + ggplot2::theme(
    legend.position = "none",
    axis.text.x = ggplot2::element_text(angle = 30, hjust = 1)
  ),
  align = "vh",
  labels = c("A", "B"),
  nrow = 1
)

# extract the legend from one of the plots
legend <- cowplot::get_legend(
  bic_weights + ggplot2::theme(legend.box.margin = ggplot2::margin(0, 0, 0, 12))
)

ic_plot <- cowplot::plot_grid(ic_plot, legend, rel_widths = c(1.75, .75))

ggplot2::ggsave(
  plot = ic_plot,
  filename = file.path("inst", "plots", "ic_weights_post_hoc.png"),
  device = "png",
  width = 350,
  height = 150,
  units = "mm",
  dpi = 300
)

ggplot2::ggsave(
  plot = ic_plot,
  filename = file.path("inst", "plots", "ic_weights_post_hoc.svg"),
  device = "svg",
  width = 350,
  height = 150,
  units = "mm",
  dpi = 300
)
