package_list = list(
  handlebars = list(
    url = "https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js",
    local_dir = file.path("inst", "htmlwidgets", "handlebars"),
    local_file = "handlebars.min.js"
  ),
  utviz = list(
    url = "https://raw.githubusercontent.com/jumpingrivers/ard-js/main/dist/utviz.min.js",
    local_dir = file.path("inst", "htmlwidgets", "utviz"),
    local_file = "utviz.min.js"
  )
)

for (pkg in package_list) {
  local_dir = pkg$local_dir
  local_path = file.path(local_dir, pkg$local_file)

  dir.create(local_dir, showWarnings = FALSE, recursive = TRUE)
  download.file(pkg$url, local_path)
}
