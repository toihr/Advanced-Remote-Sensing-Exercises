# 10 – Terrestrial laser scanning: stem detection with 3DFin

Tools: [CloudCompare](https://www.cloudcompare.org/) with the [3DFin](https://github.com/3DFin/3DFin) plugin.

A terrestrial laser scan of a pine stand (~1.7 million points, 152 m²) was cleaned and clipped in CloudCompare
and processed with 3DFin to detect stems and derive **tree height** and **diameter at breast height (DBH)**
from fitted stem sections.

| File | Content |
|---|---|
| `pine_stand.las.clone_config.ini` | 3DFin parameters used |
| `pine_stand.las.clone.xlsx` | 3DFin output: height, DBH, position and section diameters |
| `capture.jpeg` | Screenshot of the point cloud (height-coloured) |

**Data:** `pine_stand.las` and `pine_standClip.las` via `get_data.R` or `tools/download_data.*`.

![TLS pine stand](capture.jpeg)
