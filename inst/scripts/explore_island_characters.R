library(DAISIE)
data("archipelagos41")
focal_island_names <- c(
  "Canaries", "Comoros", "Galapagos", "Hawaii", "Marquesas",
  "New_Caledonia", "SaoTome_Principe"
)
island_names <- lapply(archipelagos41, \(x) x[[1]]$name)
island_index <- which(island_names %in% c(focal_island_names))
island_data <- archipelagos41[island_index]
island_metadata <- lapply(island_data, "[[", 1)

focal_island_names <- lapply(island_metadata, "[[", "name")
island_area <- lapply(island_metadata, "[[", "area")
names(island_area) <- focal_island_names
sort(unlist(island_area), decreasing = FALSE)

island_isolation <- lapply(island_metadata, "[[", "distance_continent")
names(island_isolation) <- focal_island_names
sort(unlist(island_isolation), decreasing = FALSE)

island_age <- lapply(island_metadata, "[[", "island_age")
names(island_age) <- focal_island_names
sort(unlist(island_age), decreasing = FALSE)
