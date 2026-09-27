# Install all R packages used in the exercises.
# Run once:  Rscript install_packages.R

pkgs <- c(
  "terra",        # raster / vector processing (all exercises)
  "sen2r",        # Sentinel-2 SAFE -> GeoTIFF conversion (04)
  "e1071",        # support vector machines (06)
  "randomForest", # random forest classification / regression (06, 07)
  "ggplot2",      # plotting (07-09)
  "tidyterra",    # ggplot2 geoms for terra objects (07-09)
  "lidR",         # airborne LiDAR processing (08, 09)
  "gridExtra",    # multi-panel plots (09)
  "rmarkdown"     # render the .Rmd reports
)

missing <- setdiff(pkgs, rownames(installed.packages()))
if (length(missing)) install.packages(missing) else message("All packages already installed.")
