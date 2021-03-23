install.packages("remotes")
remotes::install_github("tylermorganwall/rayshader")
library(rayshader)

#This is code from Tyler Morgan's twitter post about world maps with terrain textures

#' you need to download the rasters from:
#' https://www.ngdc.noaa.gov/mgg/global/
#' Output will be a global map with terrain features

matval = raster_to_matrix(raster::raster("~/Downloads/ETOPO1_Ice_g_geotiff.tif"))
smallmat = resize_matrix(matval, 0.25)
water_palette = colorRampPalette(c("darkblue", "dodgerblue", "lightblue"))(200)
bathysmall = height_shade(smallmat,range = c(min(smallmat),0) ,texture = water_palette)
smallmat %>%
  height_shade(range = c(0,max(smallmat))) %>%
  add_overlay(generate_altitude_overlay(bathysmall, smallmat, start_transition = 0)) %>%
  add_shadow(lamb_shade(smallmat, zscale = 500), 0) %>%
  add_shadow(texture_shade(smallmat, contrast = 8, brightness =6), 0.5) %>%
  plot_map()
