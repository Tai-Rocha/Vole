### Library pck

library(dismo)
library(kernlab)
library(modleR)
library(raster)
library(rJava)
## Read and load the occurrence data 

vole_all <- read.csv(file= "./data/vole_all.csv", sep = ",", dec = ".")

## Read and load the .shp file to use as a buffer and M BAM area
vole_masc <- readShapePoly("./data/shapefile/Vole_Movement_Area.shp")

### All bioclimatic variables from worldclim List and stack rescpectively

predictos <- list.files(path = 'D:/git_GITHUB/Vole/data/layers/pres',
                        pattern = 'asc',
                        full.names = T)

predictors <- stack(predictos)

################################# Modler SetupSDMdata ###############################

sdmdata_vole_all <- setup_sdmdata(species_name = unique(vole_all[1]),
                             occurrences = vole_all[2:3],
                             predictors = predictors,
                             models_dir = "./results/setupsdmdata",
                             partition_type = "crossvalidation",
                             cv_partitions = 5,
                             cv_n = 1,
                             seed = 512,
                             buffer_type = "user",
                             buffer_shape = vole_masc,
                             plot_sdmdata = T,
                             n_back = 1000,
                             clean_dupl = T,
                             clean_uni = T,
                             clean_nas = T,
                             geo_filt = T, 
                             geo_filt_dist = 1,
                             select_variables = T, 
                             percent = 0.7,
                             cutoff = 0.7)


############################ Modler _do_many ########################################

do_many(species_name = unique(vole_all[1]),
        sdmdata = sdmdata_vole_all,
        occurrences = vole_all[2:3],
        predictors = predictors,
        plot_sdmdata = T,
        models_dir = "./results/setupsdmdata",
        write_png = T,
        write_bin_cut = T,
        bioclim = T,
        domain = T, 
        glm = T,
        svmk = T,
        svme = T, 
        maxent = T,
        maxnet = F,
        rf = T,
        mahal = T, 
        brt = T, 
        equalize = F,
        project_model = T,
        proj_data_folder = "./data/layers/")


######################### Final Model ########################

final_model(species_name = unique(vole_all[1]), 
            algorithms = NULL,
            weight_par = "TSS",
            select_partitions = TRUE, 
            threshold = c("spec_sens"),
            scale_models = TRUE,
            select_par = "TSS", 
            select_par_val = 0.7,
            consensus_level = 0.5, 
            models_dir = "./results/setupsdmdata",
            final_dir = "final_models",
            proj_dir = "lig",
            which_models = c("raw_mean"),
            uncertainty = F,
            write_png = T)



###### Ensemble

