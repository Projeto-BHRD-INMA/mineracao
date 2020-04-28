#########################################
# SPATIAL EXTRATION IN R 
# extracting mine information to each municipality
# Kele R. Firmiano 
# Date: 20/04/2020                  
########################################

# Loading packages ####
library(rgdal)
library(raster)
library(rgeos) # clip

# Loading shp file ####
munic <-
  readOGR(dsn = "./outputs/reproj_shp",
          layer = "munic_wgs84",
          encoding = 'UTF-8')
mg_bhrd_munic <-
  readOGR(dsn = "./outputs/clip_shp",
          layer = "crop_mg_bhrd_munic",
          encoding = 'UTF-8')
es_bhrd_munic <-
  readOGR(dsn = "./outputs/clip_shp",
          layer = "crop_es_bhrd_munic",
          encoding = 'UTF-8')

# Checking coordinate system ####
crs(munic) 
crs(mg_bhrd_munic) 
crs(es_bhrd_munic) 

# simple plots
plot(munic, axes = TRUE, xlab = "cities within bhrd")

par(mfrow = c(1, 2), mar = c(5, 5, 4, 1))
plot(mg_bhrd_munic, axes = TRUE, xlab = "mg_bhrd_munic")
plot(es_bhrd_munic, axes = TRUE, xlab = "es_bhrd_munic")
dev.off()

# extracting specific polygons in a shp
n.munic <- c("Abre Campo", "Mariana")
ext.munic <- munic[munic$NOMEMUNIC %in% n.munic ,]
plot(munic, axes = TRUE)
plot(ext.munic, add = TRUE, col = "red", axes = TRUE)


