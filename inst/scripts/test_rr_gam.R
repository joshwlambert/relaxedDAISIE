# Script to test the behaviour of the relaxed-rate colonisation DAISIE model

# the Galapagos data is chosen as this is one of the archipelagos that showed
# unpredictable behaviour in the likelihood (see plot_loglik_dist script for
# plot of the behaviour of the optimised likelihood for the different starting
# conditions).
data("Galapagos")

# read in results for the Galapagos
results_tbl <- daisie_results_as_df(islands = "Galapagos")

# subset to only relaxed-rate colonisation model
results_tbl <- results_tbl[which(results_tbl$model == "rr_gam_dd"), ]

# determine whether the likelihood calculation is consistent for the same
# starting parameters, using MLE parameters from the results

pars <- unlist(
  results_tbl[1, c("lambda_c", "mu", "K", "gamma", "lambda_a", "sd")]
)

lik <- DAISIE:::DAISIE_loglik_all(
  pars1 = pars[1:5],
  pars2 = DAISIEutils::setup_std_pars2(cond = 6),
  datalist = Galapagos,
  methode = "lsodes",
  CS_version = list(
    model = 2,
    relaxed_par = "immigration",
    par_sd = pars[6],
    par_upper_bound = 1
  )
)

lik_res <- DAISIE::DAISIE_ML(
  datalist = Galapagos,
  initparsopt = c(
    lac = 0.5310173,
    mu = 0.7442478,
    k = 157.2853363,
    gam = 0.0908217,
    laa = 0.8865595,
    sd = 0.9085507
  ),
  idparsnoshift = c(6, 7, 8, 9, 10),
  idparsopt = c(lac = 1, mu = 2, k = 3, gam = 4, laa = 5, sd = 6),
  parsfix = NULL,
  idparsfix = NULL,
  res = 100,
  ddmodel = 11,
  cond = 6,
  methode = "lsodes",
  optimmethod = "simplex",
  CS_version = list(
    model = 2,
    relaxed_par = "immigration",
    par_sd = 0,
    par_upper_bound = 1
  )
)
