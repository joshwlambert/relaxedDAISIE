# script to calculate the phylogenetic distance between the stem and crown ages
# between island community clades

# names are extracted from DAISIE data and cross-referenced to the Jetz et al.
# (2012) bird phylogeny and names are matched to the phylogeny. If the species
# is not present on the phylogeny the name of a closely-related species is used

# read in bird phylogeny
bird_tree <- ape::read.nexus(
  file = system.file(
    "extdata",
    "bird_mcc_tree",
    "bird_mcc_tree.nex",
    package = "relaxedDAISIE",
    mustWork = TRUE
  )
)

# create list to store results in
norm_island_phy_dist_list <- list()

# define function for getting standardised names from DAISIE data objects
colonist_names <- function(daisie_data) {
  # extract colonist names
  col_names <- unlist(lapply(daisie_data, "[[", "colonist_name"))
  # split names by space
  split_col_names <- strsplit(col_names, " ")
  # return genus_species name
  species_names <- lapply(split_col_names, \(x) {
    x[1:2]
    paste(x[1], x[2], sep = "_")
  })
  species_names
}

# define function for matching colonist names to tips in phylogeny
grep_tree <- function(tree, colonist_names) {
  tree_index_list <- lapply(
    colonist_names,
    grep,
    x = tree$tip.label,
    ignore.case = TRUE
  )
  tree_index_list
}

# Canaries

data("Canaries")
Canaries

col_names <- colonist_names(daisie_data = Canaries)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[2]] <- "Fringilla_teydea"
col_names[[4]] <- "Parus_caeruleus"
col_names[[10]] <- "Parus_cyanus"
col_names[[14]] <- "Fringilla_coelebs"
col_names[[18]] <- "Carduelis_chloris"
col_names[[24]] <- "Miliaria_calandra"
col_names[[25]] <- "Carduelis_sinica"
col_names[[26]] <- "Carduelis_ambigua"
col_names[[27]] <- "Emberiza_cabanisi"
col_names[[28]] <- "Erithacus_komadori"
col_names[[29]] <- "Fringilla_montifringilla"
col_names[[30]] <- "Turdus_pilaris"
col_names[[43]] <- "Serinus_canaria"
col_names[[44]] <- "Carduelis_cannabina"
col_names[[45]] <- "Parus_caeruleus"

# remove duplicate names to prevent under counting phylogenetic distance
col_names[[7]] <- "Erithacus_akahige"
col_names[[12]] <- "Regulus_madeirensis"
col_names[[21]] <- "Alauda_arvensis"
col_names[[33]] <- "Luscinia_sibilans"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree

plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$Canaries <- norm_island_phy_dist

# Comoros

data("Comoros")
Comoros

col_names <- colonist_names(daisie_data = Comoros)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[1]] <- "Nectarinia_humbloti"

col_names[[2]] <- "Muscicapa_caerulescens"
col_names[[6]] <- "Cyanolanius_madagascarinus"
col_names[[8]] <- "Nectarinia_coquerellii"
col_names[[9]] <- "Foudia_madagascariensis"
col_names[[11]] <- "Nesoenas_picturata"
col_names[[13]] <- "Zosterops_modestus"
col_names[[14]] <- "Hippolais_polyglotta"
col_names[[15]] <- "Coracopsis_nigra"
col_names[[16]] <- "Treron_australis"
col_names[[18]] <- "Saxicola_dacotiae"
col_names[[21]] <- "Columba_oenas"
col_names[[24]] <- "Alectroenas_madagascariensis"
col_names[[26]] <- "Terpsiphone_viridis"
col_names[[29]] <- "Turtur_chalcospilos"

# remove duplicate names to prevent under counting phylogenetic distance
col_names[[20]] <- "Hippolais_icterina"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$Comoros <- norm_island_phy_dist

# Galapagos

data("Galapagos")
Galapagos

col_names <- colonist_names(daisie_data = Galapagos)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[6]] <- "Pyrocephalus_rubinus"
col_names[[7]] <- "Myiarchus_tyrannulus"
col_names[[8]] <- "Dendroica_petechia"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$Galapagos <- norm_island_phy_dist

# Hawaii

data("Hawaii")
Hawaii

col_names <- colonist_names(daisie_data = Hawaii)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[1]] <- "Hypocolius_ampelinus"
col_names[[2]] <- "Hemignathus_kauaiensis"
col_names[[5]] <- "Chasiempis_sandwichensis"
col_names[[7]] <- "Corvus_coronoides"
col_names[[8]] <- "Corvus_nasicus"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$Hawaii <- norm_island_phy_dist

# Marquesas

data("Marquesas")
Marquesas

col_names <- colonist_names(daisie_data = Marquesas)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[1]] <- "Pomarea_iphis"
col_names[[2]] <- "Ptilinopus_richardsii"
col_names[[3]] <- "Ptilinopus_regina"
col_names[[4]] <- "Gallicolumba_jobiensis"
col_names[[5]] <- "Acrocephalus_atyphus"
col_names[[7]] <- "Gallicolumba_beccarii"
col_names[[8]] <- "Gallicolumba_tristigmata"
col_names[[9]] <- "Macropygia_mackinlayi"
col_names[[10]] <- "Myiagra_hebetior"
col_names[[11]] <- "Vini_australis"
col_names[[12]] <- "Phigys_solitarius"
col_names[[13]] <- "Charmosyna_rubronotata"
col_names[[14]] <- "Ducula_pacifica"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$Marquesas <- norm_island_phy_dist

# New Caledonia

data("New_Caledonia")
New_Caledonia

col_names <- colonist_names(daisie_data = New_Caledonia)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[1]] <- "Gymnomyza_samoensis"
col_names[[2]] <- "Microeca_flavigaster"
col_names[[3]] <- "Ducula_pinon"
col_names[[8]] <- "Ptiloprora_guisei"
col_names[[9]] <- "Myzomela_sanguinolenta"
col_names[[10]] <- "Philemon_buceroides"
col_names[[11]] <- "Corvus_orru"
col_names[[12]] <- "Cyanoramphus_novaezelandiae"
col_names[[13]] <- "Erythrura_tricolor"
col_names[[15]] <- "Zosterops_conspicillatus"
col_names[[16]] <- "Zosterops_rennellianus"
col_names[[19]] <- "Gallicolumba_beccarii"
col_names[[20]] <- "Aplonis_minor"
col_names[[21]] <- "Artamus_leucorynchus"
col_names[[22]] <- "Cacatua_sanguinea"
col_names[[23]] <- "Caloenas_nicobarica"
col_names[[24]] <- "Charmosyna_rubronotata"
col_names[[25]] <- "Gallicolumba_jobiensis"
col_names[[26]] <- "Cincloramphus_mathewsi"
col_names[[29]] <- "Rhipidura_diluta"
col_names[[32]] <- "Gerygone_mouki"
col_names[[35]] <- "Ptilinopus_superbus"
col_names[[40]] <- "Chrysococcyx_lucidus"
col_names[[42]] <- "Lichmera_indistincta"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$New_Caledonia <- norm_island_phy_dist

# Sao Tome and Principe

data("SaoTome_Principe")
SaoTome_Principe

col_names <- colonist_names(daisie_data = SaoTome_Principe)
tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

missing_species <- vapply(
  tree_index,
  \(x) ifelse(length(x) == 0, TRUE, FALSE),
  FUN.VALUE = logical(1)
)
col_names[missing_species]

# those that are not found in the tree (TRUE) are replaced by closely-related
# species that are found by manually inspecting the tree

col_names[[1]] <- "Nectarinia_verticalis"
col_names[[2]] <- "Nectarinia_minulla"
col_names[[4]] <- "Ploceus_bicolor"
col_names[[5]] <- "Sylvia_borin"
col_names[[7]] <- "Serinus_citrinelloides"
col_names[[8]] <- "Ploceus_capensis"
col_names[[9]] <- "Prinia_bairdii"
col_names[[10]] <- "Lanius_collaris"
col_names[[11]] <- "Oriolus_mellianus"
col_names[[12]] <- "Speirops_lugubris"
col_names[[14]] <- "Amaurocichla_bocagei"
col_names[[15]] <- "Poicephalus_rufiventris"
col_names[[17]] <- "Terpsiphone_viridis"
col_names[[18]] <- "Columba_junoniae"
col_names[[19]] <- "Columba_vitiensis"
col_names[[20]] <- "Quelea_quelea"
col_names[[27]] <- "Columba_pulchricollis"
col_names[[29]] <- "Treron_sieboldii"
col_names[[33]] <- "Streptopelia_bitorquata"
col_names[[35]] <- "Nectarinia_chloropygia"

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree

plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$SaoTome_Principe <- norm_island_phy_dist

# Calculate the BIC and AICc weights for each model

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

rr_ic_tbl <- subset(ic_tbl, ic_tbl$model != "cr_dd")
clado_ic_tbl <- subset(ic_tbl, ic_tbl$model == "rr_lac_dd")
island_bic_tbl <- aggregate(
  rr_ic_tbl$bic_weight,
  by = list(island = rr_ic_tbl$island),
  FUN = sum
)
colnames(island_bic_tbl) <- c("island", "rr_bic_weight")

island_aicc_tbl <- aggregate(
  rr_ic_tbl$aicc_weight,
  by = list(island = rr_ic_tbl$island),
  FUN = sum
)
colnames(island_aicc_tbl) <- c("island", "rr_aicc_weight")

island_bic_tbl <- cbind(
  island_bic_tbl,
  clado_bic_weight = clado_ic_tbl$bic_weight,
  norm_phy_dist = unlist(norm_island_phy_dist_list)
)

island_aicc_tbl <- cbind(
  island_aicc_tbl,
  clado_aicc_weight = clado_ic_tbl$aicc_weight,
  norm_phy_dist = unlist(norm_island_phy_dist_list)
)

# calculate kendall's correlation coefficient between sum of rr bic weights and
# normalised phylogenetic distance
cor(
  island_bic_tbl$rr_bic_weight,
  island_bic_tbl$norm_phy_dist,
  method = "kendall"
)

# calculate kendall's correlation coefficient between rr clado bic weights and
# normalised phylogenetic distance
cor(
  island_bic_tbl$clado_bic_weight,
  island_bic_tbl$norm_phy_dist,
  method = "kendall"
)

# calculate kendall's correlation coefficient between sum of rr aicc weights and
# normalised phylogenetic distance
cor(
  island_aicc_tbl$rr_aicc_weight,
  island_aicc_tbl$norm_phy_dist,
  method = "kendall"
)

# calculate kendall's correlation coefficient between rr clado aicc weights and
# normalised phylogenetic distance
cor(
  island_aicc_tbl$clado_aicc_weight,
  island_aicc_tbl$norm_phy_dist,
  method = "kendall"
)
