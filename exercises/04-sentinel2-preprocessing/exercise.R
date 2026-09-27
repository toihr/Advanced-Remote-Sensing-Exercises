library(sen2r)
library(terra)
# Download the .SAFE product from https://dataspace.copernicus.eu/ into data/
file = s2_translate("data/S2B_MSIL2A_20230908T101559_N0509_R065_T32UQD_20230908T150051.SAFE")


img = rast(file)

plot(img[[4]], range= c(0,4000))
plotRGB(img, 4,3,2,stretch="lin")

subset <- ext(780000, 809000, 5800000, 5835000)
img.subset <- crop(img, subset)
plotRGB(img.subset, 6,3,2,stretch="lin")

writeRaster(img.subset, "sen2r_berlin_20230908_v2.tif", overwrite=TRUE)






















