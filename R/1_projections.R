######################################################
# PCI INMA 1º product
# exploratory analyses DNPM mine data
# Kele Rocha Firmiano
######################################################

# standardizing the projection to WGS 84

# loading pck ####
library(rgdal) 
#library(ggmap) 
library(rgeos) 
library(maptools) 
#library(dplyr) 
#library(tidyr) 
#library(tmap)
library(sp)

# ES mining data ####
es_mine <- readOGR(dsn = "./data/ES_dnmp_9mar20", layer = "ES")
summary(es_mine)
es_mine_wgs84 <- spTransform(es_mine, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
plot(es_mine_wgs84, axes = T)
writePolyShape(es_mine, "./outputs/es_mine_wgs84.shp") #saved


# MG mining data ####
mg_mine <- readOGR(dsn = "./data/MG_dnmp_9mar20", layer = "MG")
#writePolyShape(mg_mine, "./outputs/mg_mine.shp") #saved
sapply(mg_mine@data, class) # checking data class
mg_mine@proj4string # checking projection

# BHRD OTTO 6 ####
bhrd <- readOGR(dsn = "./data/BHRD_otto6") 
#writePolyShape(bhrd, "./outputs/bhrd.shp") #saved
sapply(bhrd@data, class) # checking data class
bhrd@proj4string # checking projection

# BHRD mucipios ####
munic <- readOGR(dsn = "./data/BHRD_municipios") 
#writePolyShape(bhrd, "./outputs/bhrd.shp") #saved
sapply(munic@data, class) # checking data class
munic@proj4string # checking projection

# BHRD limites ####
limites <- readOGR(dsn = "./data/BHRD_limites") 
#writePolyShape(bhrd, "./outputs/bhrd.shp") #saved
sapply(limites@data, class) # checking data class
limites@proj4string # checking projection

# simple plots ####
par(mfrow = c(1, 2), mar = c(5, 5, 4, 1))
plot(mg_mine)
plot(es_mine) 
dev.off()

plot(bhrd)
plot(munic)
plot(limites)

# reprojections ####
# ES 
proj4string(es_mine) <- NA_character_ # remove CRS information 
proj4string(es_mine) <- CRS("+init=epsg:4674") # assign a new CRS
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code
es_mine84 <- spTransform(es_mine, CRS("+init=epsg:4326")) # reproject (spTransform)
saveRDS(object = es_mine84, file = "./outputs/es_mine_wgs84.Rds") # reproject file save as df RDS

# MG 
proj4string(mg_mine) <- NA_character_ # remove CRS information 
proj4string(mg_mine) <- CRS("+init=epsg:4674") # assign a new CRS
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code
mg_mine84 <- spTransform(mg_mine, CRS("+init=epsg:4326")) # reproject (spTransform)
saveRDS(object = mg_mine84, file = "./outputs/mg_mine_wgs84.Rds") # reproject file save as df RDS
rm(mg_mine84) # remove unnecessary file

# BHRD municípios
proj4string(munic) <- NA_character_ # remove CRS information 
proj4string(munic) <- CRS("+init=epsg:29168") # assign a new CRS
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code
munic84 <- spTransform(munic, CRS("+init=epsg:4326")) # reproject (spTransform)
saveRDS(object = munic84, file = "./outputs/municipios_wgs84.Rds") # reproject file save as df RDS
rm(munic84) # remove unnecessary file

# BHRD limites
proj4string(limites) <- NA_character_ # remove CRS information 
proj4string(limites) <- CRS("+init=epsg:4674") # assign a new CRS
EPSG <- make_EPSG() # create data frame of available EPSG codes
EPSG[grepl("WGS 84$", EPSG$note), ] # search for WGS 84 code
limites84 <- spTransform(limites, CRS("+init=epsg:4326")) # reproject (spTransform)
saveRDS(object = limites84, file = "./outputs/limites_wgs84.Rds") # reproject file save as df RDS
rm(limites84) # remove unnecessary file

