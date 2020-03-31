#########################################
# SPATIAL EXTRATION AND UNION IN R 
# Danielle de Oliveira Moreira
# Data: 30/03/2020        
# Modified by Kele R. Firmiano in 31/03/20
########################################

# Loading packages ####
library(rgdal)
library(raster)
library(maptools)
library(rgeos)

# Loading shp file ####
mg_mine <- readOGR(dsn = "./data/MG_dnmp_9mar20", layer = "MG") 
es_mine <- readOGR(dsn = "./data/ES_dnmp_9mar20", layer = "ES")
bhrd_lim <- readOGR(dsn = "./data/BHRD_limites", layer = "bhrd_sirgas_dissol")
munic <- readOGR(dsn = "./data/BHRD_municipios", layer = "munic_BHRD_albers")

# Checking coordinate system ####
crs(mg_mine)
crs(es_mine)
crs(bhrd_lim)

crs(munic) # need reproject. don't use it
proj4string(munic) # no ok yet. don't use it

# simple plots ####
par(mfrow = c(1, 3), mar = c(5, 5, 4, 1))
plot(mg_mine, axes = TRUE)
plot(es_mine, axes = TRUE)
plot(bhrd_lim, axes = TRUE)
dev.off()

# other reprojections ####
# For coordinate system with "NA", use this. Here we are seting for Albers
#largepol <- CRS("+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs")
#crs(largepol)

# If it has already a different coordinate system, we need to transform the file to Albers
#largepol.albers <- spTransform(poligono, CRS("+proj=aea +lat_1=-5 +lat_2=-42 +lat_0=-32 +lon_0=-60 +x_0=0 +y_0=0 +ellps=aust_SA +units=m +no_defs "))
#crs(largepol.albers)

# Clipping the large polygon to the small polygon ####
clip_mg <- gIntersection(mg_mine, bhrd_lim, byid = TRUE, drop_lower_td = TRUE)
clip_es <- gIntersection(es_mine, bhrd_lim, byid = TRUE, drop_lower_td = TRUE)

# Plot clipps ####
plot(clip_mg)
plot(clip_es, add = TRUE, axes = TRUE)

# other clipp possibility ####
# Another possible way to do the clip. But here, wasn't so efficient.
#clip2 <- poligono[molde, ]
#crs(clip2)
#plot(clip2)

#plot(molde)
#plot(clip2, add = TRUE)

# Saving the new shp ####
# not ok yet
writeOGR(clip1,".", "mu_es", driver = "ESRI Shapefile", overwrite_layer = TRUE)
#writeOGR(clip_mg, "./outputs", "clip_mg_bhrd", overwrite_layer = TRUE)
#writePolyShape(clip_mg, "./outputs/gm_mine.shp")

#?writeOGR
es_mu <- readOGR(dsn = ".", layer = "mu_es")
plot(es_mu)
