# Loading packages ####
library(rgdal)
library(raster)
library(rgeos) # clip

# Loading shp file ####
mg <-
  readOGR(dsn = "./outputs/reproj_shp",
          layer = "mg_mine_wgs84",
          encoding = 'UTF-8')
es <-
  readOGR(dsn = "./outputs/reproj_shp",
          layer = "es_mine_wgs84",
          encoding = 'UTF-8')
bhrd <-
  readOGR(dsn = "./outputs/reproj_shp",
          layer = "bhrd_lim_wgs84",
          encoding = 'UTF-8')
munic <-
  readOGR(dsn = "./outputs/reproj_shp",
          layer = "munic_wgs84",
          encoding = 'UTF-8')

###################################
# Need a loop

# extracting uf, municipality and zone informations ####
df.uf <- data.frame(munic$NOMEUF) # selecting uf
df.munic <- data.frame(munic$NOMEMUNIC) # selecting municipalities
df.reg <- data.frame(munic$NOMEMES) # selecting regions 
df.munic.reg.uf <- cbind(df.munic, df.reg, df.uf) # combining all

# Extracting munic ####
# example: Colatina - ES
col <- c("Colatina") 
ext.col <- munic[munic$NOMEMUNIC %in% col,] 
writeOGR(ext.col,"./outputs/clip_reg_shp", "ext.col", driver = "ESRI Shapefile", overwrite_layer = TRUE) 

# plots ####
plot(munic, axes = TRUE)
plot(ext.col, add = TRUE, col = "red", axes = TRUE)

# jeito 1 - corte exato ####
crop_col <- crop(es, ext.col)

# plots ####
plot(munic, axes = TRUE)
plot(crop_col, add = TRUE, col = "red", axes = TRUE)

# jeito 2 - corte nao exato: mantém minas dentro e fora dos limites do munic. ####
crop_col_B <- es[ext.col, ]

par(mfrow = c(2, 2), mar = c(5, 5, 4, 1))
plot(crop_col , axes = TRUE, xlab = "crop1")
plot(crop_col_B, axes = TRUE, xlab = "crop2")
dev.off()

#calculando a diferença das áreas - ####
crop_col$AREA_HA <- area(crop_col)
crop_col$dif_area <- (area(crop_col_B) - area(crop_col)) 

#saving new (clipped) shapefiles ####
writeOGR(crop_col,"./outputs", "crop_col", driver = "ESRI Shapefile", overwrite_layer = TRUE)
###################################
