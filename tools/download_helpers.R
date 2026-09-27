# Helpers to fetch the large input data of an exercise from the GitHub release.
#
# Every exercise folder contains a `data-manifest.csv` with the columns
#   asset  - file name of the release asset
#   md5    - MD5 checksum of the asset (integrity check)
#   path   - target path relative to the exercise folder
#            (for .zip assets: the folder the archive is extracted into)
#
# Only base R is used, so no extra packages are required.

DATA_REPO    <- "toihr/Advanced-Remote-Sensing-Exercises"
DATA_RELEASE <- "data-v1.0"

release_asset_url <- function(asset) {
  sprintf("https://github.com/%s/releases/download/%s/%s", DATA_REPO, DATA_RELEASE, asset)
}

# Download all assets listed in `<exercise_dir>/data-manifest.csv`.
# Files that already exist with the correct checksum are skipped.
download_exercise_data <- function(exercise_dir = ".", overwrite = FALSE) {
  manifest_file <- file.path(exercise_dir, "data-manifest.csv")
  if (!file.exists(manifest_file)) {
    message("No data-manifest.csv in '", exercise_dir, "' - nothing to download.")
    return(invisible(NULL))
  }

  # Large point clouds need more than R's default 60 s timeout
  old <- options(timeout = max(3600, getOption("timeout")))
  on.exit(options(old))

  manifest <- utils::read.csv(manifest_file, stringsAsFactors = FALSE)
  for (i in seq_len(nrow(manifest))) {
    asset  <- manifest$asset[i]
    target <- file.path(exercise_dir, manifest$path[i])
    is_zip <- grepl("\\.zip$", asset, ignore.case = TRUE)

    # Extracted archives leave a small marker file behind
    marker <- file.path(target, paste0(".", asset, ".extracted"))
    already_there <- if (is_zip) {
      file.exists(marker)
    } else {
      file.exists(target) && unname(tools::md5sum(target)) == manifest$md5[i]
    }
    if (!overwrite && already_there) {
      message("[skip] ", manifest$path[i], " (already present)")
      next
    }

    dest <- if (is_zip) tempfile(fileext = ".zip") else target
    dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
    message("[get ] ", asset, " -> ", manifest$path[i])
    utils::download.file(release_asset_url(asset), dest, mode = "wb", quiet = FALSE)

    if (unname(tools::md5sum(dest)) != manifest$md5[i]) {
      stop("Checksum mismatch for ", asset, " - please delete the file and retry.")
    }
    if (is_zip) {
      dir.create(target, recursive = TRUE, showWarnings = FALSE)
      utils::unzip(dest, exdir = target)
      unlink(dest)
      file.create(marker)
    }
  }
  message("Done: ", normalizePath(exercise_dir))
  invisible(manifest)
}
