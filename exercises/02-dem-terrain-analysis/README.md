# 02 – DEM terrain analysis

Terrain analysis with SRTM 1-arc-second elevation data in `terra`.

| Script | Content |
|---|---|
| [`guelb_er_richat_terrain.R`](guelb_er_richat_terrain.R) | Self-chosen area: the *Eye of the Sahara* (Guelb er Richat, Mauritania). Slope and aspect, quantile-based slope classes, aspect classified into N/E/S/W plus a "flat" class (slope < 5°). |
| [`black_forest_dem.R`](black_forest_dem.R) | Black Forest DEM: descriptive statistics, custom colour ramp, contour lines, elevation classes, north arrow and scale bar. |

**Data:** `get_data.R` downloads the two SRTM tiles into `data/`.
