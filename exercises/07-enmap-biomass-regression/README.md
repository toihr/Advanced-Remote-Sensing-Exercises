# 07 – EnMAP above-ground biomass regression

Report: [`biomass_regression.Rmd`](biomass_regression.Rmd) · [rendered HTML](https://toihr.github.io/Advanced-Remote-Sensing-Exercises/07-enmap-biomass-regression.html)

Simulated EnMAP imagery (195 valid bands) of Sonoma County, California, with field biomass plots:
- extraction of plot spectra and data cleaning (NA spectra),
- **random forest regression** (1000 trees) of above-ground biomass, variable importance, explained variance ≈ 73 %,
- wall-to-wall biomass map (`sonoma_rf.tif`),
- comparison with a narrow-band index (normalized difference 2160/1540 nm).

![Biomass map](../../docs/assets/enmap-biomass-rf.jpg)
