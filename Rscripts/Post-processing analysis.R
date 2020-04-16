
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

sub <- list.dirs(full.names=FALSE, recursive=FALSE)

for(j in 1:length(sub)) {
  print(sub[j])
  
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  print(stack_present)
  
  binary_0.2 <- stack_present >=0.2
  
  f <- paste0(sub[j], "bin.tif")
  writeRaster(binary_0.2, filename=f, bylayer=TRUE, overwrite=TRUE)
}
#bin <- unstack(binary_0.2)

#binary <- paste(seq_along(bin), ".tif",sep="")
#for(i in seq_along(bin)){writeRaster(bin[[i]], overwrite=TRUE, file=binary[i]) }

#binary <- stackApply(h, indices =  rep(1,nlayers(h)), fun = "mean", na.rm = T)
