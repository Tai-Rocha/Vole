###############################################################
## Post-processing analysis for Microtus californicus ENMs 
## Author: Tainá Rocha
## DAte: 07 April 2020
## Last Update: 15 April 2020 
###############################################################

### Library pckgs

library(raster)
library(rgdal)

########## Present 
setwd("Vole_raw_mean_Present/")

sub <- list.dirs(full.names=TRUE, recursive=FALSE)

for(j in 1:length(sub)) {
  print(sub[j])
  
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  print(stack_present)
  
  binary_0.2 <- stack_present >=0.2
  
  b <- paste0(names(binary_0.2@data),"_bin.tif")
  
  writeRaster(binary_0.2, filename=b, bylayer=TRUE, overwrite=TRUE)
} 
############ DAqui pra baixo não funciona

# Crie uma pasta para os novos resultados pos processados
  
bin_list <- list.files(path = "/home/taina/Documentos/Vole/Postprocessing/", recursive=TRUE, full.names=TRUE,  pattern='.tif') 
stack_bin<- stack(bin_list)
names(stack_bin)
continu <-  stack_bin*stack_present
writeRaster(continu, filename=paste0(names(stack_bin),"_cont.tif"), bylayer=TRUE, overwrite=TRUE)
 

##########  End
