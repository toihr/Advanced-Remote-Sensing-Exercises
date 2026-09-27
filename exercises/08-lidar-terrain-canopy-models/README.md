# 08 – Airborne LiDAR: terrain, canopy & single trees

Report: [`lidar_canopy_models.Rmd`](lidar_canopy_models.Rmd)

Airborne laser scanning tile from Berlin (Geoportal Berlin), processed with `lidR`:
- clipping, 3-D visualisation, voxelisation and a vertical transect,
- **DTM** (TIN) + hillshade, **DSM** and height-normalised **CHM**,
- tree-top detection with a local-maximum filter and **Dalponte (2016)** crown segmentation.

**Data:** two LAS tiles (~1.6 GB) via `get_data.R`.
