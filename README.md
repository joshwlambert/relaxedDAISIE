
# relaxedDAISIE

<!-- badges: start -->
[![R-CMD-check](https://github.com/joshwlambert/relaxedDAISIE/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/joshwlambert/relaxedDAISIE/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/joshwlambert/relaxedDAISIE/branch/main/graph/badge.svg)](https://app.codecov.io/gh/joshwlambert/relaxedDAISIE?branch=main)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7703102.svg)](https://doi.org/10.5281/zenodo.7703102)
<!-- badges: end -->

The goal of relaxedDAISIE is to reproduce the analysis and plots of Lambert et
al. (in prep).

## Installation

You can install the development version of relaxedDAISIE like so:

``` r
remotes::install_github("joshwlambert/relaxedDAISIE")
```

The structure of the package is:

- /data: all datasets used in the paper are stored in /data and therefore can
be read into R using `data()` and documentation can be read by querying the 
data (e.g. `?Galapagos`). All data originally derived from Valente et al. (2020)
<https://doi.org/10.1038/s41586-020-2022-5>. See the `create_island.R` script in
/data-raw for how the original Valente et al. (2020) data (stored in the 
`{DAISIE}` R package) is subsetted to the data used in this repository.

- /bash: the analysis in Lambert et al. (in prep) uses the High Performance Cluster
Computer (HPCC) Peregrine at the University of Groningen; /bash contains the 
bash script to submit the jobs to the HPCC, as well as an installation script
to make sure all the correct packages and versions are loaded (with the use of
`{renv}`).

- /extdata: this folder contains the data that is not used in the primary analysis.
Including the maximum clade credibility tree from Jetz et al. (2012) 
<https://doi.org/10.1038/nature11631>, data for plotting the world map (in /extdata/plotting_data),
and the output of the DAISIE analysis (in /extdata/raw_daisie_output).

- /plot: all of the plots in the paper are stored in this folder and can be reproduced
from scripts also stored in the repository.

- /scripts: all of the R scripts required to reproduce the analysis and plots are stored
in this folder. There are also scripts to produce tables for TeX.

There are few functions in the `{relaxedDAISIE}` namespace (found in /R) which are
used in the scripts. However, the main purpose of the package is to reproduce the paper
which primarily uses functions from other packages (e.g. `{DAISIE}`, `{DAISIEutils}`, `{ggplot2}`, etc.)

The package uses `{renv}` to manage which dependencies are used in the hope that this
aid reproducibility by providing a list of required dependencies and their versions in
order to rerun the code.

### Warning

This repository requires the DAISIE R package version 4.3.1. This package can be installed from a remote source (GitHub) but requires compilation of compiled code (fortran and C++). This may cause issues on certain operating system and require certain tool chains to be installed on a system. 




