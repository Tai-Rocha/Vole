library(raster)
library(humboldt)


## Data Prepare for Humboldt analysis Tijuca


env_north_list <- list.files("./data/North_layers_Humboldt/", pattern = ".tif", full.names = T)

env_north <-stack(env_north_list)


vals_north <- values(env_north)

coord_north <- xyFromCell(env_north,1:ncell(env_north))

combine_north <- cbind(coord_north,vals_north)

## remove NAs and make sure all variables are imported as numbers

env1<-humboldt.scrub.env(combine_north)

write.csv(env1,"env_noth_vole_xyvalues.csv", sep = ",", dec = ".") 


#############################################################################


## Data Prepare for Humboldt analysis Pedra Bonita Gávea


env_south_list <- list.files("./data/South_layers_Humboldt/", pattern = ".tif", full.names = T)

env_south <-stack(env_south_list)


vals_south <- values(env_south)

coord_south <- xyFromCell(env_south,1:ncell(env_south))

combine_south <- cbind(coord_south,vals_south)

## remove NAs and make sure all variables are imported as numbers

env2<-humboldt.scrub.env(combine_south)


write.csv(env2,"env_south_vole_xyvalues.csv", sep = ",", dec = ".") 
