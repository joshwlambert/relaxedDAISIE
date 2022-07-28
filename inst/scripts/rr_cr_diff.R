# load Galapagos data
utils::data("Galapagos")

# set up data for singleton non-endemic lineage from the Galapagos
island_clade <- Galapagos[[6]]
sd <- seq(0.1, 5, 0.1)
par_upper_bound <- Inf

# Cladogenesis non-endemic singleton lineage
clado_lineage <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "cladogenesis",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Extinction non-endemic singleton lineage
ext_lineage <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "extinction",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Carrying capacity non-endemic singleton lineage
k_lineage <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "carrying_capacity",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Immigration non-endemic singleton lineage
immig_lineage <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "immigration",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Anagenesis non-endemic singleton lineage
ana_lineage <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "anagenesis",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# set up data for endemic radiation from the Galapagos
island_clade <- Galapagos[[4]]

# Cladogenesis endemic radiation
clado_radiation <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "cladogenesis",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Extinction endemic radiation
ext_radiation <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "extinction",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Carrying capacity endemic radiation
k_radiation <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "carrying_capacity",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Immigration endemic radiation radiation
immig_radiation <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "immigration",
  sd = sd,
  par_upper_bound = par_upper_bound
)

# Anagenesis endemic radiation radiation
ana_radiation <- calc_rr_cr_diff(
  island_clade = island_clade,
  relaxed_par = "anagenesis",
  sd = sd,
  par_upper_bound = par_upper_bound
)

clado_lineage_plot <- ggplot2::ggplot(data = clado_lineage) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Cladogenesis (non-endemic lineage)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

ext_lineage_plot <- ggplot2::ggplot(data = ext_lineage) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Extinction (non-endemic lineage)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

k_lineage_plot <- ggplot2::ggplot(data = k_lineage) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Carrying capacity (non-endemic lineage)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

immig_lineage_plot <- ggplot2::ggplot(data = immig_lineage) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Colonisation (non-endemic lineage)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

ana_lineage_plot <- ggplot2::ggplot(data = ana_lineage) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Anagenesis (non-endemic lineage)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

clado_radiation_plot <- ggplot2::ggplot(data = clado_radiation) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Cladogenesis (endemic radiation)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

ext_radiation_plot <- ggplot2::ggplot(data = ext_radiation) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Extinction (endemic radiation)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

k_radiation_plot <- ggplot2::ggplot(data = k_radiation) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Carrying Capacity (endemic radiation)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

immig_radiation_plot <- ggplot2::ggplot(data = immig_radiation) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Colonisation (endemic radiation)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

ana_radiation_plot <- ggplot2::ggplot(data = ana_radiation) +
  ggplot2::geom_point(
    mapping = ggplot2::aes(
      x = sd,
      y = delta_loglik
    ),
    shape = 1,
    size = 2,
    stroke = 1
  ) +
  ggplot2::scale_y_continuous(name = "Delta log likelihood") +
  ggplot2::scale_x_continuous(name = "Prior Distribution Standard deviation") +
  ggplot2::ggtitle("Relaxed Anagenesis (endemic radiation)") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

facet_plot <- cowplot::plot_grid(
  clado_lineage_plot, clado_radiation_plot,
  ext_lineage_plot, ext_radiation_plot,
  k_lineage_plot, k_radiation_plot,
  immig_lineage_plot, immig_radiation_plot,
  ana_lineage_plot, ana_radiation_plot,
  ncol = 2, align = "vh"
)

ggplot2::ggsave(
  plot = facet_plot,
  filename = file.path("inst", "plots", "rr_cr_diff.png"),
  device = "png",
  width = 200,
  height = 250,
  units = "mm",
  dpi = 600
)
