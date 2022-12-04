# script to calculate the phylogenetic distance between the stem and crown ages
# between island community clades

# names are extracted from DAISIE data and cross-referenced to the Jetz et al.
# (2012) bird phylogeny and names are matched to the phylogeny. If the species
# is not present on the phylogeny the name of the closest sister species is used

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

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
col_names[[45]] <- "Parus_major"

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

col_names[[6]] <- "Pyrocephalus_rubinus"
col_names[[7]] <- "Myiarchus_tyrannulus"
col_names[[8]] <- "Setophaga_ruticilla"

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

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

# those that are not found in the tree (TRUE) are replaced by sister species
# that are found by manually inspecting the tree

col_names[[1]] <- "Gymnomyza_samoensis"
col_names[[2]] <- "Microeca_flavigaster"
col_names[[3]] <- "Ducula_pinon"
col_names[[8]] <- "Ptiloprora_guisei"
col_names[[9]] <- "Myzomela_sanguinolenta"
col_names[[10]] <- "Philemon_buceroides"
col_names[[11]] <- "Corvus_orru"
col_names[[12]] <- "Cyanoramphus_novaezelandiae"
col_names[[13]] <- "Erythrura_trichroa"
col_names[[15]] <- "Zosterops_conspicillatus"
col_names[[16]] <- "Zosterops_rennellianus"
col_names[[19]] <- "Gallicolumba_beccarii"
col_names[[20]] <- "Aplonis_minor"
col_names[[21]] <- "Artamus_leucorynchus"
col_names[[22]] <- "Cacatua_sanguinea"
col_names[[23]] <- "Caloenas_nicobarica"
col_names[[24]] <- ""
col_names[[25]] <- ""
col_names[[26]] <- ""
col_names[[29]] <- ""
col_names[[32]] <- ""
col_names[[35]] <- ""
col_names[[40]] <- ""
col_names[[42]] <- ""

# remove duplicate names to prevent under counting phylogenetic distance

col_names[[]] <- ""

tree_index <- grep_tree(tree = bird_tree, colonist_names = col_names)

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist

norm_island_phy_dist_list$New_Caledonia <- norm_island_phy_dist
