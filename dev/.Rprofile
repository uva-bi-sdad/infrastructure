for v in c("3.4", "3.5") {
  if (!dir.exists(paths = file.path("~", "R", "x86_64-pc-linux-gnu-library", v))) {
    dir.create(path = file.path("~", "R", "x86_64-pc-linux-gnu-library", v),
               recursive = TRUE)
    }
  .libPaths(new = c(file.path("~", "R", "x86_64-pc-linux-gnu-library", v),
                    .libPaths()))
  }
