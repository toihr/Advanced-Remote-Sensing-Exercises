library(terra)

# Run from the exercise folder (open the .Rproj); get the data with source("get_data.R")

#1
#Downloaded the Data this is DEM data from the eye of the sahara also known as Guelb er Richat
DEM = rast("data/n21_w012_1arc_v3.tif")
setMinMax(DEM)

#Cropping out so that we are focused on the Guelb er Richat 
cropsub = c(-12.0,-10.99,21,21.5)

DEM_eye = crop(DEM,cropsub)
plot(DEM_eye, col = terrain.colors(255))

#3
#Calculating the slope and aspect of the DEM
DEM_eye.slope = terrain(DEM_eye, v = "slope", unit ="degrees")
DEM_eye.aspect = terrain(DEM_eye, v = "aspect", unit ="degrees")

#4
#We calculate the 10th quantile of the slope.
q10 = global(DEM_eye.slope, quantile,probs = seq(0,1,0.1),na.rm=TRUE)
plot(DEM_eye.slope, breaks = q10,main = "Quantiles of Slope")

#5
#just using the breaks = 10 parameter in the plotting function should result in 10 equivalently spaced classes
plot(DEM_eye.aspect, breaks = 10, main = "Aspect 10 equal Intervals")

#6

#Using the aspect data we can define the cardinal directions N,E,S,W
aspect.cl <- DEM_eye.aspect
aspect.cl[DEM_eye.aspect > 315 | DEM_eye.aspect <= 45] <- 1
aspect.cl[DEM_eye.aspect > 45 & DEM_eye.aspect <= 135] <- 2
aspect.cl[DEM_eye.aspect > 135 & DEM_eye.aspect <= 225] <- 3
aspect.cl[DEM_eye.aspect > 225 & DEM_eye.aspect <= 315] <- 4

global(aspect.cl, range)#reset the range

#custom color palette from color brewer
mycol1 = colorRampPalette(c('#a6cee3','#1f78b4','#b2df8a','#33a02c'))

plot(aspect.cl, col= mycol1(4),legend = FALSE, main = "Aspect Classified")
legend('right', title='DEM Classes',
       legend=c("North", "East", "South", "West"),
       fill=mycol1(4),bg='white',cex = 0.4)
#north(xy=c(-11.15, 21.05), type=3, col="black", cex = 0.8)
#sbar(d= 5, xy=c(-11.1, 21.05), type="bar", divs=2, lonlat=TRUE, below="km", cex=0.5, col="black")


#7
mycol2 = colorRampPalette(c('#a6cee3','#1f78b4','#b2df8a','#33a02c',"white"))

aspect.cl[DEM_eye.slope < 5] <- 5
plot(aspect.cl, col= mycol2(5),legend = FALSE, main = "Aspect Classified with Slope")
legend('right', title='DEM Classes',
       legend=c("North", "East", "South", "West","Flat"),
       fill=mycol2(5),bg='white',cex = 0.4)

#north(xy=c(-11.15, 21.05), type=3, col="black", cex = 0.8)
#sbar(d= 5, xy=c(-11.1, 21.05), type="bar", divs=2, lonlat=TRUE, below="km", cex=0.5, col="black")


