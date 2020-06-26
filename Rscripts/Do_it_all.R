## 


env1 <- read.csv("./data/Humboldt_Inputs/env_noth_vole_xyvalues.csv", sep = ",", dec = ".")

env2 <- read.csv("./data/Humboldt_Inputs/env_south_vole_xyvalues.csv", sep = ",", dec = ".")

occ.sp1 <- read.csv("./data/Humboldt_Inputs/North_Vole.csv", sep = ",", dec = ".")

occ.sp2 <- read.csv("./data/Humboldt_Inputs/South_Vole.csv", sep = ",", dec = ".")
##humboldt do it all

humboldt.doitall(inname = "DoItAll",
                 env1= env1, 
                 env2= env2, 
                 sp1 = occ.sp1,
                 sp2= occ.sp2,
                 rarefy.dist = 0.5, 
                 rarefy.units = "km", 
                 env.reso = 0.00833, 
                 reduce.env = 0,
                 reductype = "PCA", 
                 non.analogous.environments = "NO",
                 nae.window = 2,
                 env.trim = T, 
                 env.trim.type = "MCP", 
                 trim.mask1,
                 trim.mask2, 
                 trim.buffer.sp1 = 200, 
                 trim.buffer.sp2 = 200,
                 color.ramp = 1, 
                 correct.env = T, 
                 pcx = 1, 
                 pcy = 2,
                 col.env = e.var,
                 e.var=(3:25), 
                 R = 50, 
                 kern.smooth = 1, 
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
