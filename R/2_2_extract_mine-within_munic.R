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
df.uf <- data.frame(munic$NOMEUF) # selecting uf
df.munic <- data.frame(munic$NOMEMUNIC) # selecting municipalities
uf.munic <- cbind(df.munic, df.uf) # combining
es.munic <- c("Nova Venécia", "Barra de S?o Francisco", "Mantenópolis", "Vila Valério", "?guia Branca", "S?o Gabriel da Palha", "Sooretama", "Alto Rio Novo", "Pancas", "Linhares", "S?o Domingos do Norte", "Rio Bananal", "Colatina", "Baixo Guandu", "Marilândia", "Aracruz", "Itaguaçu", " S?o Roque do Cana?", "Jo?o Neiva", "Santa Teresa", "Ibiraçu", " Laranja da Terra", "Itarana", "Afonso Claúdio", "Brejetuba", "Santa Maria de Jetibá", "Domingos Martins", "Muniz Freire", "Iúna", "Ibatiba", "Conceiç?o do Castelo", "Irupi", "Venda Nova do Imigrante", "Ibitirama") # municipalities belonging to ES ## but, fail some municipalities...

ext.es.munic <- munic[munic$NOMEMUNIC %in% es.munic ,] # extracting municipalities belonging ES from munic shp file atributes.
plot(munic, axes = TRUE)
plot(ext.es.munic, add = TRUE, col = "red", axes = TRUE)

#saving extracted shapefile ####
writeOGR(ext.es.munic,"./outputs/clip_shp", "es.munic", driver = "ESRI Shapefile", overwrite_layer = TRUE)


