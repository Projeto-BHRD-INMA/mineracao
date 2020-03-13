# Reading mining data 

# loading pck
library(rgdal) #shape 
library(maptools)

# ES mining data ####
es_mine <- readOGR(dsn = "./data/ES_dnmp_9mar20", layer = "ES") 
writePolyShape(es_mine, "./outputs/es_mine.shp") #saved
plot(es_mine)

# MG mining data ####
mg_mine <- readOGR(dsn = "./data/MG_dnmp_9mar20", layer = "MG")
writePolyShape(mg_mine, "./outputs/mg_mine.shp") #saved
plot(mg_mine)
