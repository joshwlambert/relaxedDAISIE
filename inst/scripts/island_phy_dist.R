# script to calculate the phylogenetic distance between the stem and crown ages
# between island community clades

# names are extracted from DAISIE data and cross-referenced to the Jetz et al.
# (2012) bird phylogeny and names are matched to the phylogeny. If the species
# is not present on the phylogeny the name of the closest sister species is used

bird_file <- file.choose()
bird_tree <- ape::read.nexus(file = bird_file)

data("Galapagos")
Galapagos
col_names <- unlist(lapply(Galapagos, "[[", "colonist_name"))
# get only genus name
split_col_names <- strsplit(col_names, " ")
genus_names <- lapply(split_col_names, \(x) {
  x[1:2]
  paste(x[1], x[2], sep = "_")
})

# fix typo
genus_names[[3]] <- "Camarhynchus_heliobates"

tree_index_list <- list()
for (i in seq_along(genus_names)) {
  tree_index_list[[i]] <- grep(
    pattern = genus_names[[i]],
    x = bird_tree$tip.label,
    ignore.case = TRUE
  )
}

# those that are not found in the tree are replaced by sister species that are
# found by manually inspecting the tree

genus_names[[6]] <- "Pyrocephalus_rubinus"
genus_names[[7]] <- "Myiarchus_tyrannulus"
genus_names[[8]] <- "Setophaga_ruticilla"

tree_index_list <- list()
for (i in seq_along(genus_names)) {
  tree_index_list[[i]] <- grep(
    pattern = genus_names[[i]],
    x = bird_tree$tip.label,
    ignore.case = TRUE
  )
}

island_tree <- ape::keep.tip(phy = bird_tree, tip = tree_index_list)
island_tree
plot(island_tree)

island_phy_dist <- sum(island_tree$edge.length)
island_phy_dist

norm_island_phy_dist <- island_phy_dist / island_tree$Nnode + 1
norm_island_phy_dist


