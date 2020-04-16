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
  
############ DAqui pra baixo não funciona
  
  continu <- binary_0.2*stack_present
  
  c <- paste0(names(binary_0.2@data),"_cont.tif")
  writeRaster(continu, filename=c, bylayer=TRUE, overwrite=TRUE)
 
}
##########  End
