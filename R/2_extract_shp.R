#########################################
# SPATIAL EXTRATION IN R 
# Danielle de Oliveira Moreira
# Date: 31/03/2020                  
# Modified by Kele R. Firmiano in 01/04/20
########################################

# Loading packages ####
library(rgdal)
library(raster)
library(maptools)
library(rgeos) # clip

# Loading shp file ####
mg <- readOGR(dsn = "./outputs/reproj_shp", layer = "mg_mine_wgs84")
es <- readOGR(dsn = "./outputs/reproj_shp", layer = "es_mine_wgs84")
bhrd <- readOGR(dsn = "./outputs/reproj_shp", layer = "bhrd_lim_wgs84")
munic <- readOGR(dsn = "./outputs/reproj_shp", layer = "munic_wgs84")

# Checking coordinate system ####
crs(mg) 
crs(es) 
crs(bhrd) 
crs(munic) 

# simple plots
par(mfrow = c(2, 2), mar = c(5, 5, 4, 1))
plot(mg , axes = TRUE, xlab = "mg_mine_wgs84")
plot(es, axes = TRUE, xlab = "es_mine_wgs84")
plot(bhrd, axes = TRUE, xlab = "bhrd_lim_wgs84")
plot(munic, axes = TRUE, xlab = "munic_wgs84")
dev.off()

plot(mg, col = 'blue')
plot(es, add = TRUE, col = 'red', axes = TRUE)

# Step 1: Clipping polygons
# clipping 
clip_mg_bhrd_lim <- gIntersection(mg, bhrd, byid = TRUE, drop_lower_td = TRUE)
clip_es_bhrd_lim <- gIntersection(es, bhrd, byid = TRUE, drop_lower_td = TRUE)
clip_mg_bhrd_munic <- gIntersection(mg, munic, byid = TRUE, drop_lower_td = TRUE)
clip_es_bhrd_munic <- gIntersection(es, munic, byid = TRUE, drop_lower_td = TRUE)

# check clip 
plot(clip_mg_bhrd_lim, col = 'blue')
plot(clip_es_bhrd_lim, add = TRUE, col = 'red', axes = TRUE)
plot(clip_mg_bhrd_munic, col = 'green')
plot(clip_es_bhrd_munic, add = TRUE, col = 'orange', axes = TRUE)

# save new shp ####
# Test
writeOGR(clip_mg_bhrd_lim, dsn = "./outputs", layer = "clip_mg_bhrd_lim", driver = "ESRI Shapefile", overwrite_layer = TRUE)

writeOGR(clip_mg_bhrd_lim, dsn = "./outputs", layer = "clip", driver = "ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(clip_es_bhrd_lim, dsn = "./outputs", layer = "clip", driver = "ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(clip_mg_bhrd_munic, dsn = "./outputs", layer = "clip", driver = "ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(clip_es_bhrd_munic, dsn = "./outputs", layer = "clip", driver = "ESRI Shapefile", overwrite_layer = TRUE)

# Remove unecessary files ####
# good to get more space if you'll continue the analysis in the sequence
rm(mg)
rm(es)
rm(bhrd)
rm(munic)







