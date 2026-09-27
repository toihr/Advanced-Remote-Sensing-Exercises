library(terra)

img = rast("Kondjor.tif")


plotRGB(img, 6,4,3,stretch="lin")