#Distance to coast
#Prior to doing any kind of distance work, need to project everything to GDA94
CAZ_var_ras_proj <- projectRaster(CAZ_var_ras, res = 5000, crs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
CAZ_wgt_var_ras_proj <- projectRaster(CAZ_wgt_var_ras, res = 5000, crs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
CAZ_area_var_ras_proj <- projectRaster(CAZ_area_var_ras, res = 5000, crs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
CAZ_area_wgt_var_ras_proj <- projectRaster(CAZ_area_wgt_var_ras, res = 5000, crs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

#For each variant, produce plot and calculate correlation, between top fraction sites and distance to coast
#load distance raster
dist_coast <- raster(file.path("SpatialData", "Raster", "dist_aus_coast.tif"))
dist_coast <- projectRaster(dist_coast, res = 5000, crs = "+proj=aea +lat_1=-18 +lat_2=-36 +lat_0=0 +lon_0=132 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
dists <- values(dist_coast)

#extract site priority at each distance
dist_coord <- as.data.frame(coordinates(dist_coast))
pri.list <- list(CAZ_var_ras_proj, CAZ_wgt_var_ras_proj, CAZ_area_var_ras_proj, CAZ_area_wgt_var_ras_proj)
priority_dist <- data.frame(lapply(pri.list, function(i){
  priority <- raster::extract(i, dist_coord)
  priority <- squeeze(priority)
  names(priority) <- names(i)
  return(priority)
}), dist_coord)
colnames(priority_dist) <- c("species_CAZ","species_wgt_CAZ", "species_area_CAZ", "species_area_wgt_CAZ", "longitude", "latitude")