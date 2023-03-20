# script to tally the number of models that successfully ran

model_success <- data.frame()

model <- c(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_gam_dd", "rr_laa_dd"
)

data_name <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas", "New_Caledonia", "SaoTome_Principe")

for (i in seq_along(data_name)) {

  # get the files names
  files <- list.files(
    system.file(
      "extdata",
      "raw_daisie_output",
      data_name[i],
      package = "relaxedDAISIE",
      mustWork = TRUE
    )
  )

  for (j in seq_along(model)) {
    # get which files for the model
    num_files <- length(grep(pattern = paste(model[j], "[0-9]", sep = "_"), x = files))

    df <- data.frame(Archipelago = data_name[i], Model = model[j], Success = num_files)
    model_success <- rbind(model_success, df)
  }
}

# format table

model_success$Archipelago <- gsub(pattern = "_", replacement = " ", x = model_success$Archipelago)
model_success$Model <- toupper(model_success$Model)
model_success$Model <- gsub(pattern = "CR", replacement = "HR", x = model_success$Model)
model_success$Model <- gsub(pattern = "_", replacement = " ", x = model_success$Model)
model_success$Model <- gsub(pattern = "LAC", replacement = "$\\\\lambda^c$", x = model_success$Model)
model_success$Model <- gsub(pattern = "MU", replacement = "$\\\\mu$", x = model_success$Model)
model_success$Model <- gsub(pattern = "LAA", replacement = "$\\\\lambda^a$", x = model_success$Model)
model_success$Model <- gsub(pattern = "RR K", replacement = "RR $K'$", x = model_success$Model)
model_success$Model <- gsub(pattern = "RR ", replacement = "RR", x = model_success$Model)

model_success$Success <- paste0(model_success$Success, "/10")

print(
  xtable::xtable(
    model_success,
    display = c("s", "s", rep("g", 9)),
    align = "ccc",
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


