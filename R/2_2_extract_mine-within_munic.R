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

# extracting uf, municipality and zone informations ####
df.uf <- data.frame(munic$NOMEUF) # selecting uf
df.munic <- data.frame(munic$NOMEMUNIC) # selecting municipalities
df.reg <- data.frame(munic$NOMEMES) # selecting regions 
df.munic.reg.uf <- cbind(df.munic, df.reg, df.uf) # combining all

# Extracting munic, by regions ####
# JEQUITINHONHA
jec <- c("Angelândia", "Capelinha", "Itamarandiba", "Aricanduva", "Felício dos Santos", "Presidente Kubitschek") 
ext.jec <- munic[munic$NOMEMUNIC %in% jec,] 
writeOGR(ext.jec,"./outputs/clip_reg_shp", "ext.jec", driver = "ESRI Shapefile", overwrite_layer = TRUE)  

# VALE DO MUCURI
muc <- c("Setubinha", "Poté", "Malacacheta", "Frei Gaspar", "Franciscópolis")
ext.muc <- munic[munic$NOMEMUNIC %in% muc,]
writeOGR(ext.muc,"./outputs/clip_reg_shp", "ext.muc", driver = "ESRI Shapefile", overwrite_layer = TRUE) 

#  VALE DO RIO DOCE + subregions ####
vrd.aimores <- c("Conselheiro Pena", "Cuparaque", "Goiabeira", "Resplendor", "Itueta", "Alvarenga", "Santa Rita do Itueto", "Pocrane", "Ipanema", "Mutum", "Taparuba", "Aimorés", "Conceiç?o de Ipanema")
ext.vrd.aimores <- munic[munic$NOMEMUNIC %in% vrd.aimores,]
writeOGR(ext.muc,"./outputs/clip_reg_shp", "ext.vrd.aimores", driver = "ESRI Shapefile", overwrite_layer = TRUE) 






















############################################
#uf.munic <- cbind(df.munic, df.uf) # combining
es.munic <- c("Nova Venécia", "Barra de S?o Francisco", "Mantenópolis", "Vila Valério", "?guia Branca", "S?o Gabriel da Palha", "Sooretama", "Alto Rio Novo", "Pancas", "Linhares", "S?o Domingos do Norte", "Rio Bananal", "Colatina", "Baixo Guandu", "Marilândia", "Aracruz", "Itaguaçu", "S?o Roque do Cana?", "Jo?o Neiva", "Santa Teresa", "Ibiraçu", "Laranja da Terra", "Itarana", "Afonso Claúdio", "Brejetuba", "Santa Maria de Jetibá", "Domingos Martins", "Muniz Freire", "Iúna", "Ibatiba", "Conceiç?o do Castelo", "Irupi", "Venda Nova do Imigrante", "Ibitirama")

ext.es.munic <- munic[munic$NOMEMUNIC %in% es.munic ,] # extracting municipalities belonging ES from munic shp file atributes.
plot(munic, axes = TRUE)
plot(ext.es.munic, add = TRUE, col = "red", axes = TRUE)

#saving extracted shapefile ####
writeOGR(ext.es.munic,"./outputs/clip_shp", "es.munic", driver = "ESRI Shapefile", overwrite_layer = TRUE)

