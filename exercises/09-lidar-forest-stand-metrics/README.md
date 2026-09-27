# 09 – LiDAR metrics vs. forest-stand inventory

Report: [`forest_stand_metrics.Rmd`](forest_stand_metrics.Rmd)

Linking ALS point clouds with the Berlin forest-stand inventory:
- ground classification with the **Cloth Simulation Filter**, DTM/CHM for two 500 × 500 m tiles,
- overlay of CHM and stand polygons (main species, height, age, mixture),
- **area-based metrics** (`pixel_metrics`, 4 m and 20 m) aggregated per stand and compared by species,
- **tree-level metrics** (`crown_metrics`) after individual tree segmentation.

**Data:** the LAS tiles (same as exercise 08) and the stand shapefile (`forst.zip`) via `get_data.R`.
