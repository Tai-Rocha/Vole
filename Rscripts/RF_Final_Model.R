########################################
# Random Forest final model
# Author: Tainá Rocha
# 27/03/2020
########################################

#Library

library(maptools)
library(raster)
library(rgdal)
library(rgeos)

#########################################

RF_Partition_list <- list.files("./Vole_resultados_cru/All_vole/Past_ig/rf_allvole_past_partitions/", pattern = "tif", full.name = TRUE)

RF_Partition_Stack <- stack(RF_Partition_list)

RF_Final_Model <- mean(RF_Partition_Stack)

writeRaster(RF_Final_Model, filename = "/home/taina/Documentos/Vole/Vole_resultados_cru/All_vole/Past_ig/rf_mean_final_model.tif", pattern = "GTiff")

plot(RF_Final_Model)

######################################### end