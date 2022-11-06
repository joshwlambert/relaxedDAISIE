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
tab_list[[length(tab_list) + 1]] <- tab

hawaii_models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k")
tab <- data.frame()
for (model in hawaii_models) {
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
tab_list[[length(tab_list) + 1]] <- tab

islands <- c(islands, "Canaries", "Hawaii")
names(tab_list) <- islands

tab_list <- lapply(tab_list, \(x) {
  colnames(x) <- c("Model", "$\\lambda^a$", "$\\mu$", "$K'$", "$\\gamma$",
                   "$\\lambda^a$", "$\\sigma$", "loglik", "BIC")
  x
})


print(
  xtable(
    tab_list[[1]], digits = 3),
  math.style.exponents = TRUE,
  NA.string = "NA",
  include.rownames = FALSE,
  hline.after = c(0, 0),
  sanitize.colnames.function = identity
)
