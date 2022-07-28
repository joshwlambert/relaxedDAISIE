#' Calculates the difference in likelihood for a clade (single lineage or
#' radiation) across different standard deviations of gamma distribution of
#' the relaxed-rate DAISIE model.
#'
#' @param island_clade A list with information on a single island clade,
#' including clade name, branching times (including island age and colonisation
#' time), stac (status of colonist), number of missing species and type of
#' clade (either type 1 or 2)
#' @param relaxed_par A string defining which parameter to relaxed. Options are:
#' "cladogenesis", "extinction", "carrying_capacity", "immigration" or
#' "anagenesis"
#' @param sd A vector of numerics with the standard deviation to be used to
#' check the difference between the original DAISIE model and the relaxed-rate
#' DAISIE model
#' @param par_upper_bound A numeric which sets the upper bound to the
#' integration of the likelihood, can be infinite or finite.
#' @return A list of two numeric vectors
#' @export
#'
calc_rr_cr_diff <- function(island_clade,
                            relaxed_par,
                            sd,
                            par_upper_bound) {

  # get internal DAISIE functions to stop R CMD check giving note
  DAISIE_loglik <- utils::getFromNamespace("DAISIE_loglik", ns = "DAISIE")
  DAISIE_loglik_integrate <- utils::getFromNamespace(
    "DAISIE_loglik_integrate",
    ns = "DAISIE"
  )

  # create a valid DAISIE data set with the island clade provided
  island_clade <- list(
    list(island_age = 5, not_present = 995),
    island_clade
  )

  # calculate the MLE for the island clade
  cr <- DAISIE::DAISIE_ML_CS(
    datalist = island_clade,
    initparsopt = c(1, 1, 20, 0.01, 1),
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    ddmodel = 11,
    cond = 0,
    optimmethod = "simplex",
    CS_version = 1,
    jitter = 1e-5
  )

  # use the MLE values for testing the difference between cr and rr loglik
  pars1 <- c(cr$lambda_c, cr$mu, cr$K, cr$gamma, cr$lambda_a)

  # replace any values that are over 100 with 100 and under 1e-5 with 0.01 so
  # each relaxed parameter can be tested without weird issues when computing
  # the likelihood with values approximately or exactly infinite or zero
  pars1[which(pars1 > 100)] <- 100
  pars1[which(pars1 < 1e-5)] <- 0.01

  # default pars2 vector, no missing species, and default settings for
  # computing the likelihood
  pars2 <- c(1.0e+02, 1.1e+01, 0.0e+00, 0.0e+00, NA, 0.0e+00, 1.0e-04,
             1.0e-05, 1.0e-07, 3.0e+03, 9.5e-01, 9.8e-01)
  missnumspec <- 0
  methode <- "lsodes"
  abstolint <- 1e-16
  reltolint <- 1e-10
  verbose <- FALSE

  # calculate the original cr likelihood
  loglik <- DAISIE_loglik(
    pars1 = pars1,
    pars2 = pars2,
    brts = island_clade[[2]]$branching_times,
    stac = island_clade[[2]]$stac,
    missnumspec = missnumspec,
    methode = methode,
    abstolint = abstolint,
    reltolint = reltolint,
    verbose = verbose
  )

  # calculate the relaxed likelihood for a range of standard deviation values
  # for the gamma distribution
  loglik_integrated <- c()
  for (i in seq_along(sd)) {
    CS_version <- DAISIE::create_CS_version(
      model = 2,
      relaxed_par = relaxed_par,
      par_sd = sd[i],
      par_upper_bound = par_upper_bound
    )
    loglik_integrated[i] <- DAISIE_loglik_integrate(
      pars1 = pars1,
      pars2 = pars2,
      brts = island_clade[[2]]$branching_times,
      stac = island_clade[[2]]$stac,
      missnumspec = missnumspec,
      methode = methode,
      CS_version = CS_version,
      abstolint = abstolint,
      reltolint = reltolint,
      verbose = verbose
    )
  }

  # calculate the difference between the original cr loglik and the relaxed
  # loglik values calculated across a set of distribution SDs
  delta_loglik <- abs(loglik - loglik_integrated)

  # return data frame of results
  data.frame(
    sd = sd,
    delta_loglik = delta_loglik
  )
}
