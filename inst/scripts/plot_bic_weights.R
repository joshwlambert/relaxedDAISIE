# script to collate all the DAISIE maximum likelihood parameter estimates for
# each island

# Canaries

# canaries does not have results for relaxed carrying capacity so requires a different set of models

model_list <- list("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_gam_dd", "rr_laa_dd")
comoros_best_model <- lapply(model_list, relaxedDAISIE::choose_best_model, data_name = "Comoros")
galapagos_best_model <- lapply(model_list, relaxedDAISIE::choose_best_model, data_name = "Galapagos")
marquesas_best_model <- lapply(model_list, relaxedDAISIE::choose_best_model, data_name = "Marquesas")
new_caledonia_best_model <- lapply(model_list, relaxedDAISIE::choose_best_model, data_name = "New_Caledonia")
saotome_principe_best_model <- lapply(model_list, relaxedDAISIE::choose_best_model, data_name = "SaoTome_Principe")
names(comoros_best_model) <- model_list
names(galapagos_best_model) <- model_list
names(marquesas_best_model) <- model_list
names(new_caledonia_best_model) <- model_list
names(saotome_principe_best_model) <- model_list


canaries_model_list <- list("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_gam_dd", "rr_laa_dd")
canaries_best_model <- lapply(canaries_model_list, relaxedDAISIE::choose_best_model, data_name = "Canaries")
names(canaries_best_model) <- canaries_model_list

hawaii_model_list <- list("cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_gam_dd")
hawaii_best_model <- lapply(hawaii_model_list, relaxedDAISIE::choose_best_model, data_name = "Hawaii")
names(hawaii_best_model) <- hawaii_model_list

canaries_best_bic <- lapply(canaries_best_model, "[[", "bic")
comoros_best_bic <- lapply(comoros_best_model, "[[", "bic")
galapagos_best_bic <- lapply(galapagos_best_model, "[[", "bic")
hawaii_best_bic <- lapply(hawaii_best_model, "[[", "bic")
marquesas_best_bic <- lapply(marquesas_best_model, "[[", "bic")
new_caledonia_best_bic <- lapply(new_caledonia_best_model, "[[", "bic")
saotome_principe_best_bic <- lapply(saotome_principe_best_model, "[[", "bic")

model_lists <- list(model_list, model_list, model_list, model_list, model_list, canaries_model_list, hawaii_model_list)
bic_list <- list(canaries_best_bic,
                 comoros_best_bic,
                 galapagos_best_bic,
                 hawaii_best_bic,
                 marquesas_best_bic,
                 new_caledonia_best_bic,
                 saotome_principe_best_bic)

canaries_bic_tbl <- data.frame(island = "canaries", model = unlist(canaries_model_list), bic = unlist(canaries_best_bic))
comoros_bic_tbl <- data.frame(island = factor("comoros"), model = unlist(model_list), bic = unlist(comoros_best_bic))
galapagos_bic_tbl <- data.frame(island = factor("galapagos"), model = unlist(model_list), bic = unlist(galapagos_best_bic))
hawaii_bic_tbl <- data.frame(island = factor("hawaii"), model = unlist(hawaii_model_list), bic = unlist(hawaii_best_bic))
marquesas_bic_tbl <- data.frame(island = factor("marquesas"), model = unlist(model_list), bic = unlist(marquesas_best_bic))
new_caledonia_bic_tbl <- data.frame(island = factor("new_caledonia"), model = unlist(model_list), bic = unlist(new_caledonia_best_bic))
saotome_principe_bic_tbl <- data.frame(island = factor("saotome_principe"), model = unlist(model_list), bic = unlist(saotome_principe_best_bic))

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
  ggplot2::geom_bar(mapping = ggplot2::aes(x = island, y = bic, fill = model), stat = "identity", position = "fill")

ggplot(mtcars, aes(factor(cyl), fill = factor(vs))) +
  geom_bar()
