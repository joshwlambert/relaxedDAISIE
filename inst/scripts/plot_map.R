library(rgdal)
library(ggplot2)
library(rnaturalearth)

archipelagos <- readRDS(
  file = system.file(
    "extdata",
    "plotting_data",
    "archipelagos.rds",
    package = "relaxedDAISIE"
  ))

# read shapefile
wmap <- ne_countries(scale = "small")
# convert to dataframe
wmap_df <- fortify(wmap)
# reproject from longlat to robinson
wmap_robin <- spTransform(wmap, CRS("+proj=robin"))
wmap_df_robin <- fortify(wmap_robin)


setwd(file.path("inst", "extdata", "plotting_data"))
bbox <- readOGR("ne_110m_graticules_all", layer = "ne_110m_wgs84_bounding_box")
setwd(here::here())
bbox_df <- fortify(bbox)
bbox_robin <- spTransform(bbox, CRS("+proj=robin"))  # reproject bounding box
bbox_robin_df <- fortify(bbox_robin)

map <- ggplot(
  data = bbox_robin_df,
  mapping = ggplot2::aes(
    long,
    lat,
    group = group
  )
) +
  geom_polygon(fill = "white") +
  geom_polygon(
    data = wmap_df_robin,
    ggplot2::aes(
      x = long,
      y = lat,
      group = group,
      fill = hole
    )
  ) +
  geom_point(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = LONGITUDE,
      y = LATITUDE,
      group = NULL,
      fill = NULL,
      size = Total_species,
      colour = "red"
    ),
    alpha = 0.5
  ) +
  coord_equal() +
  scale_fill_manual(values = c("black", "white")) +
  guides(colour = "none", fill = "none") +
  scale_size_continuous(
    name = "Island Species Diversity",
    range = c(4, 15)
  ) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_blank(),
        plot.background = element_rect(fill = "#e6e8ed"),
        panel.border = element_blank(),
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.background = element_blank()
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -9033944.7,
    y = -934750.96,
    label = "1*",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -13542344.1,
    y = -1283957.73,
    label = "2*",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = 5061221.4,
    y = -414813.45,
    label = "3",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -2518597.9,
    y = 2048108.46,
    label = "4",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -15625005.4,
    y = 1292515.27,
    label = "5*",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = 16061.1,
    y = -1208340.23,
    label = "6",
    size = 3
  ) +
  ggplot2::annotate(
    geom = "text",
    x = 15950262.5,
    y = -1099469.51,
    label = "7",
    size = 3
  )


ggplot2::ggsave(
  plot = map,
  filename = file.path("inst", "plots", "map.png"),
  device = "png",
  width = 300,
  height = 150,
  units = "mm",
  dpi = 300
)
