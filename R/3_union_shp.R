#########################################
# SPATIAL UNION IN R 
# Danielle de Oliveira Moreira
# Date: 31/03/2020                  
# Modified by Kele R. Firmiano in 01/04/20
########################################

# Loading packages ####
library(rgdal)
library(raster)
library(maptools)
library(rgeos)

# Loading shp file ####
mg_bhrd_lim <- readOGR(dsn = "./outputs/clip", layer = "clip_mg_bhrd_lim")
es_bhrd_lim <- readOGR(dsn = "./outputs/clip", layer = "clip_es_bhrd_lim")
mg_bhrd_munic <- readOGR(dsn = "./outputs/clip", layer = "clip_mg_bhrd_munic")
es_bhrd_munic <- readOGR(dsn = "./outputs/clip", layer = "clip_es_bhrd_munic")

# Checking coordinate system ####
crs(mg_bhrd_lim) 
crs(es_bhrd_lim) 
crs(mg_bhrd_munic) 
crs(es_bhrd_munic) 

# simple plots
par(mfrow = c(2, 2), mar = c(5, 5, 4, 1))
plot(mg_bhrd_lim , axes = TRUE, xlab = "clip_mg_bhrd_lim")
plot(es_bhrd_lim, axes = TRUE, xlab = "clip_es_bhrd_lim")
plot(mg_bhrd_munic, axes = TRUE, xlab = "clip_mg_bhrd_munic")
plot(es_bhrd_munic, axes = TRUE, xlab = "clip_es_bhrd_munic")
dev.off()
  
# Union shp #### 
union_bhrd_mine_lim <- union(mg_bhrd_lim, es_bhrd_lim)
union_bhrd_mine_munic <- union(mg_bhrd_munic, es_bhrd_munic)

# check union
plot(union_bhrd_mine_lim, col = 'brown', xlab = "union_bhrd_mine_lim", axes = TRUE)

plot(union_bhrd_mine_munic, col = 'brown', xlab = "union_bhrd_mine_minic", axes = TRUE)

# Saving the new shp ####
writeOGR(union_bhrd_mine_lim, "./outputs", "union_shp", driver = "ESRI Shapefile", overwrite_layer = TRUE)

writeOGR(union_bhrd_mine_munic, "./outputs", "union_shp", driver = "ESRI Shapefile", overwrite_layer = TRUE)

# Remove unecessary files ####
# good to get more space if you'll continue the analysis in the sequence
rm(mg_bhrd_lim)
rm(es_bhrd_lim) 
rm(mg_bhrd_munic) 
rm(es_bhrd_munic) 