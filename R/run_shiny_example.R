#' Run one of the example shiny apps associated with this package
#'
#' @param   app_name   The name of the app to launch. See the "shiny-examples" directory of the
#' installed package.

run_shiny_example = function(app_name = "alt_click") {
  stopifnot(rlang::is_installed("shiny"))

  # Based on https://deanattali.com/2015/04/21/r-package-shiny-app/
  package = "utVizSankey"
  examples_dir = "shiny-examples"

  valid_examples = list.files(system.file(examples_dir, package = package))
  valid_examples_msg = paste0(
    "Valid examples are: '", paste(valid_examples, collapse = "', '"), "'"
  )

  if (!(app_name %in% valid_examples)) {
    stop(
      "Please run `run_shiny_example()` with a valid example app as argument.\n",
      valid_examples_msg,
      call. = FALSE
    )
  }

  app_dir = system.file(examples_dir, app_name, package = package)
  shiny::runApp(app_dir, display.mode = "normal")
}
