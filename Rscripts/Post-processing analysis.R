
###############################################################
## Post-processing analysis for Microtus californicus ENMs 
## Author: Tainá Rocha
## DAte: 07 April 2020
## Last Update: 10 April 2020 
###############################################################

### Library pckgs
library(raster)
library(rgdal)

## List raw mean raster final models (5 algorithms) and stack (out all layers together)

list_5 <-list.files("./Vole_raw_mean/All_vole/Present/final_models/raw_mean_models/", pattern = "tif", full.names = T)

stack_5 <- stack(list_5)
plot(stack_5)

### Apllying 0.2 treshold

Binary <- stack_5 >= 0.2
plot(Binary)

### Return continuous values just in area cuted by threshold

Continuous_Final <- stack_5 * Binary 
plot(Continuous_Final)

###########################################################

setwd("Vole_raw_mean_Present/")

sub <- list.dirs(full.names=FALSE, recursive=FALSE)

for(j in 1:length(sub)) {
  print(sub[j])
  
  h <- list.files(path=sub[j], recursive=TRUE, full.names=TRUE,  pattern='.tif')
  print(h)
  
  stack_present <- stack(h)
  
  binary_0.2 <- stack_present >=0.2
  
  #binary <- stackApply(h, indices =  rep(1,nlayers(h)), fun = "mean", na.rm = T)
  
  writeRaster(binary_0.2, filename=paste0(sub[j], "_bin.tif"), overwrite=TRUE)
}

plot(binary_0.2)

###########################################################################

#setwd("~/Desktop/CMORPH/Levant-Clip/200001")

##dir.output <- './Desktop/CMORPH/Levant-Clip/200001' ### change as needed to give output location
path <- list.files("Vole_raw_mean_Present/",pattern=".tif", full.names=T, recursive=T)
raster_list = list()
for (i in 1:length(path)) {
  files = tifile(path[i], "rb")
  data <- readBin(files,what="double",endian = "little", n = 4948*1649, size=4) #Mode of the vector to be read
  data[data == -999] <- NA #covert missing data from -999(CMORPH notation) to NAs
  y<-matrix((data=data), ncol=1649, nrow=4948)
  r <- raster(y)
  if (i == 1) {
    e <- extent(-180, 180, -90, 83.6236) ### choose the extent based on the netcdf file info 
    
  }
  tr <- t(r) #transpose 
  re <- setExtent(tr,extent(e)) ### set the extent to the raster
  ry <- flip(re, direction = 'y')
  projection(ry) <- "+proj=longlat +datum=WGS84 +ellps=WGS84"
  C_Lev <- crop(ry, Levant) ### Clip to Levant
  M_C_Lev<-mask(C_Lev, Levant)
  raster_list[[i]] = M_C_Lev
}
# 

rasstk <- stack(raster_list, quick = TRUE) # OR rasstk <- brick(raster_list, quick = TRUE)
avg200001<-mean(rasstk)
writeRaster(avg200001, paste(dir.output, basename(path[i]), sep = ''), format = 'GTiff', overwrite = T) ###the basename allows the file to be named the same as the original