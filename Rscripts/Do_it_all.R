###################################
## Niche simality analysis 
## Humboldt package analysis
## Author: Tainá Rocha
###################################

library(raster)
library(humboldt)
library(tcltk)

####################################

## Load enviromental a sp data


env1 <- read.table("./data/Envs_Final_Humboldt_All_Variables/envs_vole.txt", sep = " ", dec = ".")

env2 <- read.table("./data/Envs_Final_Humboldt_All_Variables/envs_vole.txt", sep = " ", dec = ".")

occ.sp1 <- read.csv("./data/planilhas_antigas/North_vole.csv", sep = ",", dec = ".")

occ.sp2 <- read.csv("./data/planilhas_antigas/South_vole.csv", sep = ",", dec = ".")




##humboldt do it all funciotion 

humboldt.doitall(inname = "DoItAll",
                 env1= env1, 
                 env2= env2, 
                 sp1 = occ.sp1,
                 sp2= occ.sp2,
                 rarefy.dist = 1, 
                 rarefy.units = "km", 
                 env.reso = 0.00833, 
                 reduce.env = 2,
                 reductype = "PCA", 
                 non.analogous.environments = "YES",
                 nae.window = 5,
                 env.trim = T, 
                 env.trim.type = "MCP", 
                 #trim.mask1,
                 #trim.mask2, 
                 trim.buffer.sp1 = 30, 
                 trim.buffer.sp2 = 30,
                 color.ramp = 1, 
                 correct.env = T, 
                 pcx = 1, 
                 pcy = 2,
                 #col.env = e.var,
                 e.var=(3:21), 
                 R = 200, 
                 kern.smooth = 3, 
                 e.reps = 100,
                 b.reps = 100, 
                 b.force.equal.sample = F, 
                 nae = "YES",
                 thresh.espace.z = 0.001, 
                 p.overlap = T, 
                 p.boxplot = T,
                 p.scatter = T, 
                 run.silent = T, 
                 ncores = 1)

################################################### END