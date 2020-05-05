##########################################
# Niche equivalence teste with Phyloclim 
# Ps.: organizar o planilha, o  input adequado
##########################################
## Library 

library(phyloclim)
library(raster)

###
maxent.exe <- paste(system.file(package="dismo"),
                    "/java/maxent.jar", sep = "")

# testing against 9 permutations of the data
reps <- 9


##
tables_voles <- read.csv("./data/vole_all.csv", sep = "," , dec = ".")

species
voles_points <- as.data.frame(tables_voles)

layers_list <- list.files("./data/layers/present_proj/", pattern = ".asc", full.names = T)
layers <- stack(layers_list)
plot(layers)

if (file.exists(maxent.exe)){
  net <- niche.equivalency.test(voles_points, layers, reps, maxent.exe)
  net; plot(net)
} else {
  message("get a copy of MAXENT (see Details)")
}
