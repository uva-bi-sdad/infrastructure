path <- file.path("~", "R", "x86_64-pc-linux-gnu-library",
                  paste(version$major,
                        substr(x = version$minor, start = 1L, stop = 1L),
                        sep = "."))
if (!dir.exists(paths = path)) {
  dir.create(path = path, recursive = TRUE)
  }
.libPaths(new = c(path, .libPaths()))
rm(list = c("path"))
