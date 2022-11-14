# script to produce tables that can be copied and modified in latex

tab_list <- list()
models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd")
islands <- c("Comoros", "Galapagos", "Marquesas",
             "New_Caledonia", "SaoTome_Principe")

for (i in seq_along(islands)) {
  tab <- data.frame()
  for (model in models) {
    best_model <- choose_best_model(data_name = islands[i], model = model)
    if (model == "cr_dd") {
      best_model <- cbind(best_model, sd = NA_real_)
      best_model <-
        best_model[, c(
          "lambda_c", "mu", "K", "gamma", "lambda_a", "sd", "loglik", "bic"
        )]
    } else {
      rm_index <- which(colnames(best_model) %in% c("df", "conv"))
      best_model <- best_model[, -rm_index]
    }
    best_model <- cbind(model = model, best_model)
    tab <- rbind(tab, best_model)
  }
  tab_list[[i]] <- tab
}

canaries_models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_laa_dd")
tab <- data.frame()
for (model in canaries_models) {
  best_model <- choose_best_model(data_name = "Canaries", model = model)
  if (model == "cr_dd") {
    best_model <- cbind(best_model, sd = NA_real_)
    best_model <-
      best_model[, c(
        "lambda_c", "mu", "K", "gamma", "lambda_a", "sd", "loglik", "bic"
      )]
  } else {
    rm_index <- which(colnames(best_model) %in% c("df", "conv"))
    best_model <- best_model[, -rm_index]
  }
  best_model <- cbind(model = model, best_model)
  tab <- rbind(tab, best_model)
}
tab_list[[length(tab_list) + 1]] <- tab

hawaii_models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k")
tab <- data.frame()
for (model in hawaii_models) {
  best_model <- choose_best_model(data_name = "Hawaii", model = model)
  if (model == "cr_dd") {
    best_model <- cbind(best_model, sd = NA_real_)
    best_model <-
      best_model[, c(
        "lambda_c", "mu", "K", "gamma", "lambda_a", "sd", "loglik", "bic"
      )]
  } else {
    rm_index <- which(colnames(best_model) %in% c("df", "conv"))
    best_model <- best_model[, -rm_index]
  }
  best_model <- cbind(model = model, best_model)
  tab <- rbind(tab, best_model)
}
tab_list[[length(tab_list) + 1]] <- tab

islands <- c(islands, "Canaries", "Hawaii")
names(tab_list) <- islands

tab_list <- lapply(tab_list, \(x) {
  x$model <- toupper(x$model)
  x$model <- gsub(pattern = "CR", replacement = "HR", x = x$model)
  x$model <- gsub(pattern = "_", replacement = " ", x = x$model)
  x$model <- gsub(pattern = "LAC", replacement = "$\\\\lambda^c$", x = x$model)
  x$model <- gsub(pattern = "MU", replacement = "$\\\\mu$", x = x$model)
  x$model <- gsub(pattern = "LAA", replacement = "$\\\\lambda^a$", x = x$model)
  x$model <- gsub(pattern = "RR K", replacement = "RR $K'$", x = x$model)
  x$model <- gsub(pattern = "RR ", replacement = "RR", x = x$model)
  x
})

tab_list <- lapply(tab_list, \(x) {
  colnames(x) <- c("Model", "$\\lambda^c$", "$\\mu$", "$K'$", "$\\gamma$",
                   "$\\lambda^a$", "$\\sigma$", "loglik", "BIC")
  x
})

# add archipelago names to data frame
tab_list <- Map(
  f = function(x, arch) {
    cbind(Archipelago = replicate(expr = arch, n = nrow(x)), x)
  },
  tab_list,
  names(tab_list)
)

tab_list <- lapply(tab_list, \(x) {
  x$Archipelago[1] <- paste0(
    "\\multirow{", nrow(x), "}{*}{", x$Archipelago[1], "}"
  )
  x$Archipelago[2:nrow(x)] <- rep("", length(2:nrow(x)))
  x
})

for (i in seq_along(islands)) {
  print(
    xtable::xtable(
      tab_list[[i]],
      digits = c(
        3, # rownames
        3, # archipelago name
        3, # model name
        4, # cladogenesis
        4, # extincton
        5, # carrying capacity
        3, # colonisation
        4, # anagenesis
        6, # sd
        6, # loglik
        6  # BIC
      ),
      display = c("s", "s", rep("g", 9)),
      align = "ccccccccccc",
      caption = paste0(
        "Maximum likelihood results for the ", islands[i], " archipelago for ",
        "a selection of homogeneous-rate (HR) and relaxed-rate (RR) models. ",
        "Parameters estimated are: cladogenesis ($\\lambda^c$), extinction ",
        "($\\mu$), carrying capacity (\\textit{K}, colonisation ($\\gamma$), ",
        "anagenesis ($\\lambda^a$), standard deviation of relaxed parameter ",
        "($\\sigma$), as well as the models maximised log likelihood (loglik) ",
        "and Bayesian Information Criterion (BIC)."),
      label = paste0("tab:", islands[i], "_ml")
    ),
    size = "small",
    math.style.exponents = TRUE,
    NA.string = "NA",
    include.rownames = FALSE,
    hline.after = c(0, 0),
    sanitize.colnames.function = identity,
    sanitize.text.function = force
  )
}
