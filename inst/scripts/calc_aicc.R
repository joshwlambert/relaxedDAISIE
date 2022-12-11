# load data
data("Canaries")
data("Comoros")
data("Galapagos")
data("Hawaii")
data("Marquesas")
data("New_Caledonia")
data("SaoTome_Principe")

# get best models for each model and island

tab_list <- list()
models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_laa_dd")
islands <- c("Comoros", "Galapagos", "Marquesas",
             "New_Caledonia", "SaoTome_Principe")

for (i in seq_along(islands)) {
  tab <- data.frame()
  for (model in models) {
    best_model <- choose_best_model(data_name = islands[i], model = model)
    best_model <- best_model[, c("loglik", "df", "bic")]
    best_model <- cbind(model = model, best_model)
    tab <- rbind(tab, best_model)
  }
  tab_list[[i]] <- tab
}

canaries_models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_laa_dd")
tab <- data.frame()
for (model in canaries_models) {
  best_model <- choose_best_model(data_name = "Canaries", model = model)
  best_model <- best_model[, c("loglik", "df", "bic")]
  best_model <- cbind(model = model, best_model)
  tab <- rbind(tab, best_model)
}
tab_list[[length(tab_list) + 1]] <- tab

hawaii_models <- c("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k")
tab <- data.frame()
for (model in hawaii_models) {
  best_model <- choose_best_model(data_name = "Hawaii", model = model)
  best_model <- best_model[, c("loglik", "df", "bic")]
  best_model <- cbind(model = model, best_model)
  tab <- rbind(tab, best_model)
}
tab_list[[length(tab_list) + 1]] <- tab

islands <- c(islands, "Canaries", "Hawaii")
names(tab_list) <- islands

# calculate AICc for each model for each island
for (i in seq_along(tab_list)) {
  tab_list[[i]] <- cbind(tab_list[[i]], aic = NaN, aicc = NaN)
  for (j in seq_len(nrow(tab_list[[1]]))) {
    tab_list[[i]][j, "aic"] <- calc_aic(
      results = tab_list[[i]][j, ],
      daisie_data = parse(names(tab_list[i]))
    )
    tab_list[[i]][j, "aicc"] <- calc_aicc(
      results = tab_list[[i]][j, ],
      daisie_data = parse(names(tab_list[i]))
    )
  }
}


