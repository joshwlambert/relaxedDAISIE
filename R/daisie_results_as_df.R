#' Reads and stores the results from raw DAISIE model output into a data frame
#'
#' @param islands A string or vector of strings defining which island data sets
#' should be read and returned
#'
#' @return Data frame
#' @export
#'
#' @examples
#' islands <- c("Canaries", "Comoros")
#' results_df <- daisie_results_as_df(islands)
daisie_results_as_df <- function(islands) {

  data_tbl <- data.frame()

  for (data_name in islands) {
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

    # add sd as NA for constant rate model
    results <- lapply(results, \(x) {
      if (length(x) == 9) {
        x <- cbind(x, sd = NA)
      } else {
        x
      }
    })

    results_tbl <- Reduce(rbind, results)
    island_model <- gsub(pattern = "_[0-9]+.rds$", replacement = "", x = files)
    island <- gsub("_rr.*", "", island_model)
    island <- gsub("_cr.*", "", island)
    model <- gsub(
      pattern = paste0(island[1], "_"),
      replacement = "",
      island_model
    )
    results_tbl$model <- model
    results_tbl$island <- island

    data_tbl <- rbind(data_tbl, results_tbl)
  }

  # return data_tbl
  data_tbl
}
