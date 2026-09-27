# 03 – Temperature vs. elevation

Combining point, polygon and raster data for Baden-Württemberg.

- [`exercise.R`](exercise.R): station table → point layer (GeoPackage), reprojection and clipping of
  municipal boundaries, zonal mean elevation per municipality.
- [`homework.R`](homework.R): extracts SRTM elevation at the weather stations, fits a linear model
  *temperature ~ elevation* (correlation, R²) and applies it to the DEM to interpolate a temperature map;
  mean height per municipality.
- `PlotMeanHeights.qgz`: QGIS map of the municipal mean heights (`areas_mean.gpkg`).

**Data:** station CSV and point layer are included; SRTM tile, municipality shapefile and
`areas_mean.gpkg` come from the release (`get_data.R`).
