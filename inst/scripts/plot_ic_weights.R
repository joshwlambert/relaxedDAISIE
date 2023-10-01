# script to collate all the DAISIE maximum likelihood parameter estimates for
# each island

data("Canaries")
data("Comoros")
data("Galapagos")
data("Hawaii")
data("Marquesas")
data("New_Caledonia")
data("SaoTome_Principe")

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

canaries_best_model <- lapply(
  canaries_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Canaries"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Canaries"))
    )
    canaries_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(canaries_best_model)
  }
)

comoros_best_model <- lapply(
  comoros_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "Comoros"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "Comoros"))
    )
    comoros_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(comoros_best_model)
  }
)

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

new_caledonia_best_model <- lapply(
  new_caledonia_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "New_Caledonia"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "New_Caledonia"))
    )
    new_caledonia_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(new_caledonia_best_model)
  }
)

saotome_principe_best_model <- lapply(
  saotome_principe_best_model, \(x) {
    aic <- calc_aic(
      results = x,
      daisie_data = eval(parse(text = "SaoTome_Principe"))
    )
    aicc <- calc_aicc(
      results = x,
      daisie_data = eval(parse(text = "SaoTome_Principe"))
    )
    saotome_principe_best_model <- cbind(x, aic = aic, aicc = aicc)
    return(saotome_principe_best_model)
  }
)

canaries_best_ic <- sapply(canaries_best_model, "[", c("bic", "aic", "aicc"))
comoros_best_ic <- sapply(comoros_best_model, "[", c("bic", "aic", "aicc"))
galapagos_best_ic <- sapply(galapagos_best_model, "[", c("bic", "aic", "aicc"))
hawaii_best_ic <- sapply(hawaii_best_model, "[", c("bic", "aic", "aicc"))
marquesas_best_ic <- sapply(marquesas_best_model, "[", c("bic", "aic", "aicc"))
new_caledonia_best_ic <- sapply(
  new_caledonia_best_model, "[", c("bic", "aic", "aicc")
)
saotome_principe_best_ic <- sapply(
  saotome_principe_best_model, "[", c("bic", "aic", "aicc")
)

canaries_ic_tbl <- data.frame(
  island = "canaries",
  model = colnames(canaries_best_ic),
  bic = unlist(canaries_best_ic["bic", ]),
  delta_bic = unlist(canaries_best_ic["bic", ]) -
    min(unlist(canaries_best_ic["bic", ])),
  delta_aic = unlist(canaries_best_ic["aic", ]) -
    min(unlist(canaries_best_ic["aic", ])),
  delta_aicc = unlist(canaries_best_ic["aicc", ]) -
    min(unlist(canaries_best_ic["aicc", ]))
)
comoros_ic_tbl <- data.frame(
  island = "comoros",
  model = colnames(comoros_best_ic),
  bic = unlist(comoros_best_ic["bic", ]),
  delta_bic = unlist(comoros_best_ic["bic", ]) -
    min(unlist(comoros_best_ic["bic", ])),
  delta_aic = unlist(comoros_best_ic["aic", ]) -
    min(unlist(comoros_best_ic["aic", ])),
  delta_aicc = unlist(comoros_best_ic["aicc", ]) -
    min(unlist(comoros_best_ic["aicc", ]))
)
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
new_caledonia_ic_tbl <- data.frame(
  island = "new_caledonia",
  model = colnames(new_caledonia_best_ic),
  bic = unlist(new_caledonia_best_ic["bic", ]),
  delta_bic = unlist(new_caledonia_best_ic["bic", ]) -
    min(unlist(new_caledonia_best_ic["bic", ])),
  delta_aic = unlist(new_caledonia_best_ic["aic", ]) -
    min(unlist(new_caledonia_best_ic["aic", ])),
  delta_aicc = unlist(new_caledonia_best_ic["aicc", ]) -
    min(unlist(new_caledonia_best_ic["aicc", ]))
)
saotome_principe_ic_tbl <- data.frame(
  island = "saotome_principe",
  model = colnames(saotome_principe_best_ic),
  bic = unlist(saotome_principe_best_ic["bic", ]),
  delta_bic = unlist(saotome_principe_best_ic["bic", ]) -
    min(unlist(saotome_principe_best_ic["bic", ])),
  delta_aic = unlist(saotome_principe_best_ic["aic", ]) -
    min(unlist(saotome_principe_best_ic["aic", ])),
  delta_aicc = unlist(saotome_principe_best_ic["aicc", ]) -
    min(unlist(saotome_principe_best_ic["aicc", ]))
)

# canaries BIC weight
rel_lik <- exp(
  -0.5 * canaries_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
canaries_ic_tbl <- cbind(canaries_ic_tbl, rel_lik)
# tranpose for col-by division and transpose back
ic_weights <- t(
  t(canaries_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(canaries_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")])
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
canaries_ic_tbl <- cbind(canaries_ic_tbl, ic_weights)

# comoros BIC weight
rel_lik <- exp(
  -0.5 * comoros_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
comoros_ic_tbl <- cbind(comoros_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(comoros_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(comoros_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")])
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
comoros_ic_tbl <- cbind(comoros_ic_tbl, ic_weights)

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

# New Caledonia BIC weight
rel_lik <- exp(
  -0.5 * new_caledonia_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
new_caledonia_ic_tbl <- cbind(new_caledonia_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(new_caledonia_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(
      new_caledonia_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]
    )
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
new_caledonia_ic_tbl <- cbind(new_caledonia_ic_tbl, ic_weights)

# Sao Tome and Principe BIC weight
rel_lik <- exp(
  -0.5 * saotome_principe_ic_tbl[, c("delta_bic", "delta_aic", "delta_aicc")]
)
colnames(rel_lik) <- c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")
saotome_principe_ic_tbl <- cbind(saotome_principe_ic_tbl, rel_lik)
# transpose for col-by division and transpose back
ic_weights <- t(
  t(saotome_principe_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]) /
    colSums(
      saotome_principe_ic_tbl[c("bic_rel_lik", "aic_rel_lik", "aicc_rel_lik")]
    )
)
colnames(ic_weights) <- c("bic_weight", "aic_weight", "aicc_weight")
saotome_principe_ic_tbl <- cbind(saotome_principe_ic_tbl, ic_weights)

ic_tbl <- rbind(canaries_ic_tbl,
                comoros_ic_tbl,
                galapagos_ic_tbl,
                hawaii_ic_tbl,
                marquesas_ic_tbl,
                new_caledonia_ic_tbl,
                saotome_principe_ic_tbl
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
ic_tbl <- rbind(
  ic_tbl,
  data.frame(
    island = unique(ic_tbl$island),
    model = "Relaxed-rate",
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
  ggplot2::scale_y_continuous(name = "AIC Weight") +
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
  ggplot2::scale_y_continuous(name = "AICc Weight") +
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

ic_plot <- cowplot::plot_grid(ic_plot, legend, rel_widths = c(3, .4))

ggplot2::ggsave(
  plot = ic_plot,
  filename = file.path("inst", "plots", "ic_weights.png"),
  device = "png",
  width = 350,
  height = 150,
  units = "mm",
  dpi = 300
)
