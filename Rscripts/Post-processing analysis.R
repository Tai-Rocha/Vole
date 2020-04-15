
###############################################################
## Post-processing analysis for Microtus californicus ENMs 
## Author: Tainá Rocha
## DAte: 07 April 2020
## Last Update: 10 April 2020 
###############################################################

### Library pckgs
library(raster)
library(rgdal)


########################################################### Loops

## List raw mean raster final models (5 algorithms) and stack (out all layers together)

list_all <-list.files("./Vole_raw_mean_Present/All_vole/Present/final_models/raw_mean_models/", pattern = "tif", full.names = T)

stack_all <- stack(list_all)
plot(stack_all)







setwd("Vole_raw_mean_Present/")

sub <- list.dirs(full.names=FALSE, recursive=FALSE)

for(j in 1:length(sub)) {
  print(sub[j])
  
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  
  binary_0.2 <- stack_present >=0.2
  
  writeRaster(binary_0.2, filename=paste0(sub[j], bylayer = T, suffix = "_bin.tif"), overwrite=TRUE)
  
}
#bin <- unstack(binary_0.2)

#binary <- paste(seq_along(bin), ".tif",sep="")
#for(i in seq_along(bin)){writeRaster(bin[[i]], overwrite=TRUE, file=binary[i]) }

#binary <- stackApply(h, indices =  rep(1,nlayers(h)), fun = "mean", na.rm = T)

