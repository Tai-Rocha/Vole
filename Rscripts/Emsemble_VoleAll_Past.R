########################################
# Ensemble model 
# Species: Vole ALL
# Past Projection: Interglacial
# Author: Tainá Rocha
# 27/03/2020
########################################

#Library

library(maptools)
library(raster)
library(rgdal)
library(rgeos)

#########################################


partition_all <- list.files("Vole_resultados_cru/All_vole/Past_ig/partitions/", pattern = "tif", full.names = T)

partition_stack <- stack(partition_all)

ensemble <- mean(partition_stack)

writeRaster(ensemble, filename = "/home/taina/Documentos/Vole/Vole_resultados_cru/All_vole/Past_ig/ensemble_mean.tif", pattern = "GTiff")

plot(ensemble)

######################################## end
