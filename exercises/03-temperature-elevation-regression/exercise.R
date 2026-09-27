library(terra)

# Read in the data
DEM <- rast("data/n48_e008_1arc_v3.tif")

#Plot the Data
plot(DEM, main="Digital Elevation Model (SRTM)", col=terrain.colors(25))


# library(rasterVis)
# library(raster)
# 
# levelplot(DEM)
# 
# # Convert raster from "SpatRaster" (the terra format) to "RasterLayer" (the raster format; the package raster will not be maintained in # the future)
# DEM.raster <- raster(DEM)
# plot3D(DEM.raster)
# 
# # we may detach packages if we do not require them anymore
# detach(package:rasterVis)
# detach(package:raster)

######################################################


temp <- read.csv2("data/stations_bawue_montly_temp.csv")

x = temp$Lon
y = temp$Lat

#create vector layer
temp.point <- vect(temp, geom=c("Lon","Lat"), crs="+proj=longlat +datum=WGS84")

# save as GeoPackage (single file, no field-name limits unlike shapefiles)
writeVector(temp.point,"temp_points.gpkg",layer = "points_temp", overwrite = TRUE)


plot(DEM, main="Digital Elevation Model (DEM)", col=terrain.colors(25))
plot(temp.point, add=TRUE, pch=19, cex=1)

#Open the shapefile
poly <- vect("data/AX_KommunalesGebiet.shp")

# plot(poly[5,])
# plot(poly[poly$NAME == "Neuenstein"])


####
#first reproject then plot
poly.latlon <- terra::project(poly,crs(DEM))
#and crop it otherwise to big
poly.clip <- crop(poly.latlon, DEM)

plot(DEM, main="Digital Elevation Model (DEM)", col=terrain.colors(25))
plot(temp.point, add=TRUE, pch=19, cex=0.5)
plot(poly.clip, add= TRUE,pch = 19, cex=1.5, border="red") # polygons only need a border, pch/cex have no effect here

#only display the clips that are containing a temp.point
poly.stations <- poly.clip[temp.point,]

plot(poly.stations)
plot(temp.point,add = T)


####

DEM.poly <- extract(DEM, poly.stations)

DEM.poly.mean <- extract(DEM, poly.stations, fun=mean, na.rm=TRUE)
values(poly.stations) <- data.frame(values(poly.stations), hoehe=DEM.poly.mean[,2])


plot(poly.stations$hoehe) 
plot(poly.stations[poly.stations$hoehe < 700,], col ="black")
plot(poly.stations[poly.stations$hoehe > 700,], col ="red", add=TRUE)


writeVector(poly.stations, "poly_hoehe.gpkg", overwrite=TRUE)
