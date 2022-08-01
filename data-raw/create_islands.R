## code to prepare island dataset goes here
## The data sets selected and saved in this script have passed a set of
## criteria to be used in the analysis
## Criterion 1) the island must have at least 6 colonisation events
## Criterion 2) the island must have at least 50% phylogenetic sampling
## Criterion 3) the island must have variation in clade size (i.e.
## some clades have radiated while others have not)

  # load data of all 41 islands/archipelagos stored in the DAISIE package
  utils::data(archipelagos41, package = "DAISIE")

  # loop through all 41 islands and assign them to their own object
  for (i in seq_along(archipelagos41)) {
    assign(paste(archipelagos41[[i]][[1]]$name), archipelagos41[[i]])
  }

  # Canaries

  # remove superfluous meta data
  Canaries[[1]] <- list(island_age = Canaries[[1]]$island_age, #nolint
                        not_present = Canaries[[1]]$not_present)

  # save island data
  usethis::use_data(Canaries, overwrite = TRUE)

  # Comoros

  # remove superfluous meta data
  Comoros[[1]] <- list(island_age = Comoros[[1]]$island_age, #nolint
                       not_present = Comoros[[1]]$not_present)

  # save island data
  usethis::use_data(Comoros, overwrite = TRUE)

  # Galapagos

  # remove superfluous meta data
  Galapagos[[1]] <- list(island_age = Galapagos[[1]]$island_age, #nolint
                         not_present = Galapagos[[1]]$not_present)

  # save island data
  usethis::use_data(Galapagos, overwrite = TRUE)

  # Galapagos 2 type

  lGalapagos_2type <- Galapagos #nolint
  Galapagos_2type[[1]] <- list(island_age = Galapagos[[1]]$island_age, #nolint
                               not_present_type1 = 830,
                               not_present_type2 = 162)
  Galapagos_2type[[4]]$type1or2 <- 2 #nolint

  # save island data
  usethis::use_data(Galapagos_2type, overwrite = TRUE)


  # Hawaii

  # remove superfluous meta data
  Hawaii[[1]] <- list(island_age = Hawaii[[1]]$island_age, #nolint
                      not_present = Hawaii[[1]]$not_present)

  # save island data
  usethis::use_data(Hawaii, overwrite = TRUE)

  # Hawaii 2 type

  Hawaii_2type <- Hawaii #nolint
  Hawaii_2type[[1]] <- list(island_age = Hawaii[[1]]$island_age, #nolint
                            not_present_type1 = 793,
                            not_present_type2 = 199)
  Hawaii_2type[[3]]$type1or2 <- 2 #nolint

  # save island data
  usethis::use_data(Hawaii_2type, overwrite = TRUE)

  # Marquesas

  # remove superfluous meta data
  Marquesas[[1]] <- list(island_age = Marquesas[[1]]$island_age, #nolint
                         not_present = Marquesas[[1]]$not_present)

  # save island data
  usethis::use_data(Marquesas, overwrite = TRUE)

  # Marquesas 2 type

  Marquesas_2type <- Marquesas #nolint
  Marquesas_2type[[1]] <- list(island_age = Marquesas[[1]]$island_age, #nolint
                               not_present_type1 = 887,
                               not_present_type2 = 99)
  Marquesas_2type[[2]]$type1or2 <- 2 #nolint

  # save island data
  usethis::use_data(Marquesas_2type, overwrite = TRUE)

  # New Caledonia

  # remove superfluous meta data
  New_Caledonia[[1]] <- list(island_age = New_Caledonia[[1]]$island_age, #nolint
                             not_present = New_Caledonia[[1]]$not_present)

  # save island data
  usethis::use_data(New_Caledonia, overwrite = TRUE)


  # Sao Tome and Principe

  # remove superfluous meta data
  SaoTome_Principe[[1]] <- list(island_age = SaoTome_Principe[[1]]$island_age, #nolint
                                not_present = SaoTome_Principe[[1]]$not_present)

  # save island data
  usethis::use_data(SaoTome_Principe, overwrite = TRUE)
