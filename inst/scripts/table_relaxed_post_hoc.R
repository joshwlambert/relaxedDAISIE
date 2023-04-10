# script to produce post hoc tables that can be copied and modified in latex

tab_list <- list()
models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd")
islands <- c("Galapagos", "Hawaii", "Marquesas")

for (i in seq_along(islands)) {
  tab <- data.frame()
  for (model in models) {
    best_model <- choose_best_model(data_name = islands[i], model = model)
    if (model == "cr_dd") {
      best_model <- cbind(
        best_model, sd = NA_real_, lambda_c2 = NA_real_, mu2 = NA_real_,
        K2 = NA_real_
      )
      best_model <-
        best_model[, c(
          "lambda_c", "mu", "K", "gamma", "lambda_a", "lambda_c2", "mu2", "K2",
          "sd", "loglik", "bic"
        )]
    } else if (grepl("rr_", model)) {
      rm_index <- which(colnames(best_model) %in% c("df", "conv"))
      best_model <- best_model[, -rm_index]
      best_model <- cbind(
        best_model, lambda_c2 = NA_real_, mu2 = NA_real_, K2 = NA_real_
      )
      best_model <-
        best_model[, c(
          "lambda_c", "mu", "K", "gamma", "lambda_a", "lambda_c2", "mu2", "K2",
          "sd", "loglik", "bic"
        )]
    }
    best_model <- cbind(model = model, best_model)
    tab <- rbind(tab, best_model)
  }
  tab_list[[i]] <- tab
}

names(tab_list) <- islands

models <- c("cr_dd_2type_lac", "cr_dd_2type_mu", "cr_dd_2type_k",
            "cr_dd_2type_lac_mu", "cr_dd_2type_lac_k", "cr_dd_2type_mu_k",
            "cr_dd_2type_lac_mu_k")
islands <- c("Galapagos_2type", "Hawaii_2type", "Marquesas_2type")

for (i in seq_along(islands)) {
  tab <- tab_list[[i]]
  for (model in models) {
    best_model <- choose_best_model(data_name = islands[i], model = model)
    best_model <- cbind(best_model, sd = NA_real_)
    best_model <-
      best_model[, c(
        "lambda_c", "mu", "K", "gamma", "lambda_a", "lambda_c2", "mu2", "K2",
        "sd", "loglik", "bic"
      )]
    best_model <- cbind(model = model, best_model)
    tab <- rbind(tab, best_model)
  }
  tab_list[[i]] <- tab
}

tab_list <- lapply(tab_list, \(x) {
  x$model <- toupper(x$model)
  x$model <- gsub(pattern = "CR", replacement = "HR", x = x$model)
  x$model <- gsub(pattern = "_", replacement = " ", x = x$model)
  x$model <- gsub(pattern = "LAC", replacement = "$\\\\lambda^c$", x = x$model)
  x$model <- gsub(pattern = "MU", replacement = "$\\\\mu$", x = x$model)
  x$model <- gsub(pattern = "LAA", replacement = "$\\\\lambda^a$", x = x$model)
  x$model <- gsub(pattern = "RR ", replacement = "RR", x = x$model)
  x$model <- gsub(pattern = "2TYPE", replacement = "2T", x = x$model)
  x
})

tab_list <- lapply(tab_list, \(x) {
  colnames(x) <- c("Model", "$\\lambda^c$", "$\\mu$", "$K'$", "$\\gamma$",
                   "$\\lambda^a$", "$\\lambda^c_2$", "$\\mu_2$", "$K'_2$",
                   "$\\sigma$", "loglik", "BIC")
  x
})

# remove DD from model names
tab_list <- lapply(tab_list, \(x) {
  x$Model <- gsub(pattern = " DD", replacement = "", x = x$Model)
  x
})

for (i in seq_along(islands)) {
  print(
    xtable::xtable(
      tab_list[[i]],
      digits = c(
        3, # rownames
        3, # model name
        4, # cladogenesis
        4, # extincton
        5, # carrying capacity
        3, # colonisation
        4, # anagenesis
        4, # cladogenesis 2
        4, # extinction 2
        5, # carrying capacity 2
        6, # sd
        6, # loglik
        6  # BIC
      ),
      display = c("s", "s", rep("g", 11)),
      align = "ccccccccccccc",
      caption = paste0(
        "Maximum likelihood results for the ",
        gsub(pattern = "_2type", replacement = "", x = islands[i]),
        " archipelago for ",
        "a selection of homogeneous-rate (HR), relaxed-rate (RR) ",
        "and homogeneous-rate 2-type (HR 2T) models. In the 2-type models the ",
        "parameter which has two regimes is specified after 2T, this can be a ",
        "single parameter or multiple parameters. ",
        "Parameters estimated are: cladogenesis ($\\lambda^c$), extinction ",
        "($\\mu$), carrying capacity (\\textit{K}), colonisation ($\\gamma$), ",
        "anagenesis ($\\lambda^a$), standard deviation of relaxed parameter ",
        "($\\sigma$), as well as the models maximised log likelihood (loglik) ",
        "and Bayesian Information Criterion (BIC). The 2-type parameters are: ",
        "cladogenesis ($\\lambda^c_2$), extinction ($\\mu_2$), carrying ",
        "capacity ($K'_2$). When parameters are not estimated (e.g. $\\mu_2$ ",
        "in HR 2T $\\lambda^c$), they are fixed to be equal to the ",
        "corresponding parameter, in this case $\\mu_2$ = $\\mu$."),
      label = paste0("tab:", islands[i], "_ml")
    ),
    size = "small",
    math.style.exponents = TRUE,
    NA.string = "NA",
    include.rownames = FALSE,
    hline.after = c(0, 0),
    sanitize.colnames.function = identity,
    sanitize.text.function = force,
    floating.environment = "sidewaystable"
  )
}
