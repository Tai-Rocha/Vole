###################################
## Enviromental inputs prepare 
## For Humboldt package analysis
## Author: Tainá Rocha
###################################

library(raster)
library(humboldt)
library(tcltk)

## Data Prepare for Humboldt analysis Tijuca


envs_list <- list.files("./data/All_ENV_1_2/", pattern = ".tif", full.names = T)

envs <-stack(envs_list)


vals_envs <- values(envs)

coord_envs<-xyFromCell(envs,1:ncell(envs))

combine_envs<-cbind(coord_envs,vals_envs)

## remove NAs and make sure all variables are imported as numbers

env1n2<-humboldt.scrub.env(combine_envs)

write.table(env1n2,"envs_vole.txt", dec = ".") 


