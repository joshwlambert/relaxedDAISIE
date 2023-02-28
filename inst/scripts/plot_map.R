library(rgdal)
library(ggplot2)
library(rnaturalearth)
library(wesanderson)

pal <- c("#b9404d", "#33707f", "#e0824b")

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
      size = 10
    ),
    alpha = 0.5, colour = "#245354"
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
        legend.background = element_blank(),
        legend.position = "none"
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -9033944,
    y = 1000000,
    label = "1*",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -13542344.1,
    y = -100000,
    label = "2*",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = 5061221.4,
    y = -414813.45,
    label = "3",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -2018597.9,
    y = 4048108.46,
    label = "4",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -15625005.4,
    y = 2592515.27,
    label = "5*",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = -200000,
    y = 200000,
    label = "6",
    size = 5
  ) +
  ggplot2::annotate(
    geom = "text",
    x = 15950262.5,
    y = -1099469.51,
    label = "7",
    size = 5
  ) +
  ggrepel::geom_label_repel(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = LONGITUDE,
      y = LATITUDE
    ),
    label = archipelagos$Total_species,
    fill = pal[1],
    colour = "white",
    fontface = "bold",
    nudge_x = -3000000,
    nudge_y = -1000000,
    segment.color = "black",
    inherit.aes = FALSE
  ) +
  ggrepel::geom_label_repel(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = LONGITUDE,
      y = LATITUDE
    ),

    label = archipelagos$Number_colonisations,
    fill = pal[2],
    colour = "white",
    fontface = "bold",
    nudge_x = -2000000,
    nudge_y = -1000000,
    segment.color = "black",
    inherit.aes = FALSE
  ) +
  ggrepel::geom_label_repel(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = LONGITUDE,
      y = LATITUDE
    ),
    label = archipelagos$Cladogenetic_spp,
    fill = pal[3],
    colour = "white",
    fontface = "bold",
    nudge_x = -1000000,
    nudge_y = -1000000,
    segment.color = "black",
    inherit.aes = FALSE
  ) +
  ggplot2::geom_label(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = -16250000,
      y = -5000000
    ),
    label = "Total Species",
    fill = pal[1],
    colour = "white",
    inherit.aes = FALSE
  ) +
  ggplot2::geom_label(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = -15000000,
      y = -6000000
    ),
    label = "Number of Colonisations",
    fill = pal[2],
    colour = "white",
    inherit.aes = FALSE
  ) +
  ggplot2::geom_label(
    data = archipelagos,
    mapping = ggplot2::aes(
      x = -14000000,
      y = -7000000
    ),
    label = "Number of Cladogenetic Species",
    fill = pal[3],
    colour = "white",
    inherit.aes = FALSE
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
