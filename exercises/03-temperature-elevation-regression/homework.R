#Homework Tom Martin Ihro

#loading important library
library(terra)

###Part 1

#Read Temperature Data and DEM data
temp <- read.csv2("data/stations_bawue_montly_temp.csv")
DEM <- rast("data/n48_e008_1arc_v3.tif")

#1 Extract the data
temp.point <- vect(temp, geom=c("Lon","Lat"), crs="+proj=longlat +datum=WGS84")
DEM.point <- extract(DEM, temp.point)

#2 Save the Values in extra variables
temp_2016_1 <- temp$X2016_1
height <- DEM.point$n48_e008_1arc_v3

#3 Plot the height vs the temperature
plot(height,temp_2016_1)

#4 calculate the Corelation and the R^2 factor
DEM_TEMP.cor <- cor(height,temp_2016_1, use = "complete.obs")
DEM_TEMP.R2 <-  DEM_TEMP.cor^2


#5 Fiting Data
DEM_temp.lm = lm(temp_2016_1 ~ height) #Gain and offset can be obtained by DEM_temp.lm$coefficients


#Add the Data to line
plot(height,temp_2016_1)
abline(coef = DEM_temp.lm$coefficients,col = "#ff4030")

#Summary
summary(DEM_temp.lm)


#Plotting Interpolation
#writing a small function that can be used to calculate the interpolation on vector data.
interpol <- function(height){
  temp <- height*DEM_temp.lm$coefficients["height"] + DEM_temp.lm$coefficients["(Intercept)"]
  
  return(temp)
}

DEM.temp = interpol(DEM)

#Plot the Interpolated Temperature Data
plot(DEM.temp,main = "Temperature Profile")


###############################################

###Part 2

#open shape file
areas <- vect("data/AX_KommunalesGebiet.shp")

areas_WGS = project(areas, DEM)

#creating empty vector, can be indexed continuouslys
height.mean = numeric()

for(i in 1:length(areas_WGS)){
  pixels = extract(DEM,areas_WGS[i,]) #extracting the pixels of specified polygon
  height.mean[i] = mean(pixels[,2]) #calculating the mean of the extracted pixels
}

values(areas_WGS) <- data.frame(values(areas_WGS), height.mean=height.mean)

#Plot using continuous color bar
plot(areas_WGS,"height.mean",type="continuous",col = terrain.colors(255), main = "Mean Heights of Areas")
