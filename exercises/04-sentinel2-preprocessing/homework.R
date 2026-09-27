library(sen2r)
library(terra)

# Download the .SAFE product from https://dataspace.copernicus.eu/ into data/
file = s2_translate("data/S2B_MSIL1C_20231017T022659_N0509_R046_T53VMD_20231017T041239.SAFE")

img = rast(file)

subset <- ext(399960+50000, 509760, 6290220+70000, 6400020)
img.subset <- crop(img, subset)

writeRaster(img.subset, "Kondjor.tif", overwrite=TRUE)

