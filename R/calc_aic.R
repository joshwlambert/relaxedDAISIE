#' Calculates Akaike's information criterion for a maximum likelihood output
#' of the DAISIE model
#'
#' @param results The maximum likelihood parameter estimates and associated log
#' likelihood and free parameters (degrees of freedom)
#' @param daisie_data The data the DAISIE model was fit to
#'
#' @return A numeric
#' @export
#'
#' @examples
#' data("Comoros")
#' best_model <- choose_best_model(data_name = "Comoros", model = "cr_dd")
#' calc_aic(results = best_model, daisie_data = Comoros)
calc_aic <- function(results, daisie_data) {
  k <- results$df
  aic <- -2 * results$loglik + 2 * k
  aic
}

#' Calculates the bias-corrected (second-order) Akaike's information criterion
#' for a maximum likelihood output of the DAISIE model
#'
#' @inheritParams calc_aic
#'
#' @return A numeric
#' @export
#'
#' @examples
#' data("Comoros")
#' best_model <- choose_best_model(data_name = "Comoros", model = "cr_dd")
#' calc_aicc(results = best_model, daisie_data = Comoros)
calc_aicc <- function(results, daisie_data) {
  k <- results$df
  aic <- -2 * results$loglik + 2 * k
  if (any(grepl(pattern = "type", x = names(daisie_data[[1]])))) {
    not_present_idx <- grep(
      pattern = "not_present",
      x = names(daisie_data[[1]])
    )
    m <- sum(unlist(daisie_data[[1]])[not_present_idx])
  } else {
    m <- daisie_data[[1]]$not_present + length(daisie_data) - 1
  }
  aicc <- aic + 2 * k * (k + 1) / m - k - 1
  aicc
}
