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

