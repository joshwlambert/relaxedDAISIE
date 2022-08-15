data_name <- "Galapagos"

# get the files names
files <- list.files(
  system.file(
    "extdata",
    "raw_daisie_output",
    data_name,
    package = "relaxedDAISIE",
    mustWork = TRUE
  )
)

# get which files for the model
files <- files[-grep(pattern = "cr_dd", x = files)]

# read in the data
results <- lapply(
  as.list(
    system.file(
      "extdata",
      "raw_daisie_output",
      data_name,
      files,
      package = "relaxedDAISIE",
      mustWork = TRUE
    )
  ),
  readRDS
)

results_tbl <- Reduce(rbind, results)
results_tbl$file <- files

results_tbl
