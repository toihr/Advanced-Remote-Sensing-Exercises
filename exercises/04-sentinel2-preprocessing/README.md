# 04 – Sentinel-2 preprocessing

Converting raw Sentinel-2 products (`.SAFE`) into analysis-ready GeoTIFFs with `sen2r` and `terra`.

- [`exercise.R`](exercise.R): L2A scene of 8 Sep 2023 (tile 32UQD) → subset around Berlin, true- and false-colour composites.
- [`homework.R`](homework.R): L1C scene of 17 Oct 2023 (tile 53VMD) → subset of the **Kondyor massif**
  (Khabarovsk Krai, Russia), a near-perfectly circular ultramafic intrusion.
- [`homework_plot.R`](homework_plot.R) / `Kondjor.qgz`: false-colour visualisation (SWIR/NIR/red).

**Data:** the original `.SAFE` scenes (several GB) are not included – download them from the
[Copernicus Data Space](https://dataspace.copernicus.eu/) into `data/` if you want to rerun the conversion.
The resulting subsets `sen2r_berlin_20230908_v2.tif` and `Kondjor.tif` are available via `get_data.R`.
