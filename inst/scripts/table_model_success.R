# script to tally the number of models that successfully ran

model_success <- data.frame()

model <- c(
  "cr_dd", "rr_lac_dd", "rr_mu_dd", "rr_k", "rr_gam_dd", "rr_laa_dd"
)

data_name <- c("Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas",
               "New_Caledonia", "SaoTome_Principe")

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
    num_files <- length(grep(
      pattern = paste(model[j], "[0-9]", sep = "_"),
      x = files
    ))

    df <- data.frame(
      Archipelago = data_name[i],
      Model = model[j],
      Success = num_files
    )
    model_success <- rbind(model_success, df)
  }
}

# format table

model_success$Archipelago <- gsub(
  pattern = "_", replacement = " ", x = model_success$Archipelago
)
model_success$Model <- toupper(model_success$Model)
model_success$Model <- gsub(
  pattern = "CR", replacement = "HR", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "_", replacement = " ", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "LAC", replacement = "$\\\\lambda^c$", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "MU", replacement = "$\\\\mu$", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "LAA", replacement = "$\\\\lambda^a$", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "RR K", replacement = "RR $K'$", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "GAM", replacement = "$\\\\gamma$", x = model_success$Model
)
model_success$Model <- gsub(
  pattern = "RR ", replacement = "RR", x = model_success$Model
)

model_success$Success <- paste0(model_success$Success, "/10")

model_success$Model <- gsub(
  pattern = " DD",
  replacement = "",
  x = model_success$Model
)


for (i in seq_len(nrow(model_success))) {
  if (i %in% seq(from = 1, to = nrow(model_success), by = 6)) {
    model_success$Archipelago[i] <- paste0(
      "\\multirow{", 6, "}{*}{", model_success$Archipelago[i], "}"
    )
  } else {
    model_success$Archipelago[i] <- ""
  }
}


print(
  xtable::xtable(
    model_success,
    display = c("s", "s", "s", "s"),
    align = "cccc",
    caption = paste0(
      "Success rate of optimisation of the models used in this study. Models ",
      "failed most often because the numerical integration of the likelihood ",
      "became unstable and crashed."
    ),
    label = "tab:success_rate"
  ),
  size = "small",
  math.style.exponents = TRUE,
  NA.string = "NA",
  include.rownames = FALSE,
  hline.after = sort(rep(seq(from = 0, to = nrow(model_success), by = 6), 2)),
  sanitize.colnames.function = identity,
  sanitize.text.function = force
)
