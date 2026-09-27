library(terra)

DEM = rast("data/n48_e008_1arc_v3.tif")

DEM <- setMinMax(DEM)
plot(DEM)

x1 = 8.4
x2 = 8.8
y1 = 48.3
y2 = 48.5
cropsub = c(x1,x2,y1,y2)

rect(x1,x2,y1,y2, border = "white",lwd = 3)

DEM.sub = crop(DEM,cropsub)
#plot(DEM.sub)

DEM.min = global(DEM,min)
DEM.max = global(DEM,max)
DEM.avg = global(DEM,mean)
DEM.range = global(DEM,range)
DEM.std = global(DEM,sd)

q = global(DEM,quantile)
#q10 = global(DEM,quantile,probs = seq(0,1,0.1))

#hist(DEM, main="Distribution of elevation values", col= "blue",  maxcell=22000000)

#boxplot(DEM)

mycols <- colorRampPalette(c("blue", "orange", "white"))

plot(DEM.sub, 
     plg=list(title="Elevation (m)"),
     main="Digital Elevation Model of Black Forest",
     xlab="Longitude",
     ylab="Latitude",
     col=mycols(255))

contour(DEM.sub, add=TRUE)

brk <- c(0, 500, 650, 800, 1000)

#plot(DEM.sub, 
#     plg=list(title="Elevation (m)"),
#     main="Digital Elevation Model of Black Forest",
#     xlab="Longitude",
#     ylab="Latitude",
#     col=mycols(4),
#     breaks = brk,
#     legend = FALSE)
#
#legend('topright', title='DEM Classes',
#       legend=c("<500 m", "[500 m, 650m]", "[650 m, 800 m]", ">=800 m"),
#       fill=mycols(4), bg='white', inset=c(0,))

#################################
DEM_class<-DEM.sub
DEM_class[DEM.sub<500]<-1
DEM_class[DEM.sub>=500 & DEM.sub<650]<-2
DEM_class[DEM.sub>=650 & DEM.sub<800]<-3
DEM_class[DEM.sub>=800]<-4

DEM_class
global(DEM_class, range)

plot(DEM_class, col=mycols(4), legend=FALSE)
legend('topright', title='DEM Classes',
       legend=c("<500 m", "[500 m, 650m]", "[650 m, 800 m]", ">=800 m"),
       fill=mycols(4), bg='white', inset=c(0.,0.1),cex = 0.5)

north(xy=c(8.42, 48.46), type=3, col="black", cex = 1.0)
sbar(d= 5, xy=c(8.44, 48.315), type="bar", divs=2, lonlat=TRUE, below="km", cex=1, col="black")