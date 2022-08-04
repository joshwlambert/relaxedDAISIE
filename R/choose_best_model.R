#' Picks the best model from multiple initial conditions for the optimisation
#' to ensure the result is not from a local likelihood optima and is from the
#' global likelihood optima
#'
#' @param data_name Character string with the name of the island data set
#' @param model Character string with the name of the model fit to the data
#'
#' @return Data frame
#' @export
#'
#' @examples
#' choose_best_model(data_name = "Canaries", model = "cr_dd")
choose_best_model <- function(data_name,
                              model) {

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
  files <- files[grep(pattern = model, x = files)]

  # read in the data
  results <- lapply(
    as.list(
      file.path(
        "inst",
        "extdata",
        "raw_daisie_output",
        data_name,
        files
      )
    ),
    readRDS
  )

  # get the parameter set that has the best loglik
  best_model <- DAISIEutils::choose_best_model(
    model_lik_res = results
  )

  # return best model
  best_model
}
