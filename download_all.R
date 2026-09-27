# Download the input data for all exercises from the GitHub release.
# Run from the repository root:  Rscript download_all.R
# (Single exercise: open its .Rproj and run get_data.R)

source(file.path("tools", "download_helpers.R"))

for (dir in list.dirs("exercises", recursive = FALSE)) {
  message("\n== ", basename(dir))
  download_exercise_data(dir)
}
