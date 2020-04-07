#################################################################
## Ecological niche models analysis for Microtus californicus 
## Author: Tainá Rocha
## LAste update: MArch 2020
## Ps.: This analisys were performed trought INCT EcoEvol Cluster 
#################################################################

### Library pckgs

library(dismo)
library(kernlab)
library(modleR)
library(raster)
library(rJava)
library(rgdal)
library(doParallel)
library(parallel)

###### Using cores 

cl <- parallel::makeCluster(4, outfile="./taina.log")
registerDoParallel(cl)
getDoParWorkers()

## Read and load the occurrence data 

vole_all <- read.csv(file= "./vole_all.csv", sep = ",", dec = ".")

## Read and load the .shp file to use as a buffer and M BAM area
vole_masc <- readOGR("./data/shapefile/Vole_Movement_Area.shp")

### All bioclimatic variables from worldclim List and stack rescpectively

predictos <- list.files(path = './data/layers/present',
                        pattern = 'asc',
                        full.names = T)

predictors <- stack(predictos)

plot(predictors)

################################# Modler SetupSDMdata ###############################

especies <- unique(vole_all$sp)
foreach(i = 1:length(especies), .packages = c("dismo", "kernlab", "modleR", "raster", "rJava", "rgdal")) %dopar% {
        especie <- especies[i]
        occs <- vole_all[vole_all$sp == especie, c("lon", "lat")]
        setup_sdmdata(species_name = especie,
                             occurrences = occs,
                             predictors = predictors,
                             models_dir = "./results",
                             partition_type = "crossvalidation",
                             cv_partitions = 5,
                             cv_n = 5,
                             seed = 512,
                             buffer_type = "user",
                             buffer_shape = vole_masc,
                             plot_sdmdata = T,
                             n_back = 1000,
                             clean_dupl = T,
                             clean_uni = T,
                             clean_nas = T,
                             geo_filt = F, 
                             select_variables = F)

}
############################ Modler _do_many ########################################

foreach(i = 1:length(especies), .packages = c("dismo", "kernlab", "modleR", "raster", "rJava")) %dopar% {
        especie <- especies[i]
        do_many(species_name = especie,
        predictors = predictors,
        models_dir = "./results",
        write_png = T,
        write_bin_cut = T,
        bioclim = F,
        domain = F, 
        glm = F,
        svmk = F,
        svme = F, 
        maxent = F,
        rf = F,
        mahal = F, 
        brt = T, 
        equalize = F,
        project_model = T,
        proj_data_folder = "./data/layers/")

}
######################### Final Model ########################

foreach(i = 1:length(especies), .packages = c("dismo", "kernlab", "modleR", "raster", "rJava", "maptools")) %dopar% {
#for (i in 1:length(especies)){
        especie <- especies[i]
        final_model(species_name = especie,
            algorithms = c("bioclim", "brt", "glm", "maxent", "rf"),
            select_partitions = TRUE,
            select_par = "TSSmax", 
            select_par_val = 0,
            weight_par = NULL ,
            cut_level = c("spec_sens"),
            scale_models = FALSE,
            consensus_level = 0, 
            models_dir = "./results",
            final_dir = "final_models",
            proj_dir = "past_ig",
            which_models = c("raw_mean"),
            uncertainty = T,
            write_png = T,
            write_final = T,
            overwrite= T)
}

###### Ensemble Present

foreach(i = 1:length(especies), .packages = c("dismo", "kernlab", "modleR", "raster", "rJava", "maptools")) %dopar% {
#for (i in 1:length(especies)){
  especie <- especies[i]
  occs <- vole_all[vole_all$sp == especie, c("lon", "lat")]
        ensemble_model(species_name = especie,
        occurrences = occs,
        models_dir = "./results",
        final_dir = "final_models",
        ensemble_dir = "ensemble",
        proj_dir = "present",
        which_models = "raw_mean",
        consensus = T,
        consensus_level = 0.5,
        write_ensemble = T,
        write_occs = T,
        write_map = T,
        scale_models = TRUE
        )
}
###### Ensemble Lig

foreach(i = 1:length(especies), .packages = c("dismo", "kernlab", "modleR", "raster", "rJava", "maptools")) %dopar% {
  #for (i in 1:length(especies)){
  especie <- especies[i]
  occs <- vole_all[vole_all$sp == especie, c("lon", "lat")]
  ensemble_model(species_name = especie,
                 occurrences = occs,
                 models_dir = "./results",
                 final_dir = "final_models",
                 ensemble_dir = "ensemble",
                 proj_dir = "past_ig",
                 which_models = "raw_mean",
                 consensus = T,
                 consensus_level = 0.5,
                 write_ensemble = T,
                 write_occs = T,
                 write_map = T,
                 scale_models = TRUE
  )
}
######################################### End