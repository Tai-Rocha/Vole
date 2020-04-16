
###############################################################
## Post-processing analysis for Microtus californicus ENMs 
## Author: Tainá Rocha
## DAte: 07 April 2020
## Last Update: 15 April 2020 
###############################################################

### Library pckgs

library(raster)
library(rgdal)


############################################# Loops

setwd("Vole_raw_mean_Present/")

sub <- list.dirs(full.names=TRUE, recursive=FALSE)

for(j in 1:length(sub)) {
  print(sub[j])
  
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  print(stack_present)
  
  binary_0.2 <- stack_present >=0.2
  
  f <- paste0(names(binary_0.2@data),"_bin.tif")
  
  
  # f <-paste0(sub[j],"/",strsplit(sub[j],"/")[[1]][2], "_bin.tif") 
  # f <- paste0(names(binary_0.2@data), "bin.tif") # Work well
  # f <- paste0(names(binary_0.2@data),strsplit(sub[j],"/")[[1]][2], "_bin.tif") # Work well with right names but still save in the same folder
  # f <- paste0(sub[j], "bin.tif") # Work well but save all in the same folder
  # writeRaster(binary_0.2, filename=f, bylayer=TRUE, overwrite=TRUE)
  
  writeRaster(binary_0.2, filename=f, paste0(sub[j],"/",strsplit(sub[j],"/")[[1]][2], ".tif"), overwrite=TRUE,  bylayer=TRUE)
}
  ####################################################

setwd("Vole_raw_mean_Present/")

dir <- list.dirs(recursive=FALSE)

for(j in 1:length(dir)){
  writeRaster(stack( list.files(path=dir[j], recursive=TRUE, full.names=TRUE, pattern='rain'))*2,
              paste0(dir[j],"/",strsplit(dir[j],"/")[[1]][2], "_new.tif"), overwrite=TRUE,  bylayer=TRUE )
}
