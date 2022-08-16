#' Create a Sankey plot
#'
#' Create a HTML sankey plot for displaying admissions and retention data
#'
#' @param data Data-frame containing one row per observation (student).
#' @param steps Character vector containing a subset of the column names in `data`. These correspond
#'   to the stages of the sankey chart.
#' @param width,height   The initial size of the visualization
#' @param elementId   Identifier for the HTML element into which the visualization will be added.
#' @return A html widget containing a Sankey diagram of the data
#'
#' @export
sankey = function(data, steps, width = NULL, height = NULL, elementId = NULL) {
  used_steps = unlist(steps)
  if (!all(used_steps %in% colnames(data)) || any(duplicated(used_steps))) {
    stop("steps should be unique and be a subset of colnames(data)")
  }

  # forward options using x
  x = list(
    data = data[used_steps],
    steps = steps
  )

  # Ensures that javascript receives a row-oriented view of 'data'
  attr(x, "TOJSON_ARGS") = list(dataframe = "rows") # nolint: object_name_linter.

  # create widget
  htmlwidgets::createWidget(
    name = "sankey",
    x,
    width = width,
    height = height,
    package = "utVizSankey",
    elementId = elementId
  )
}

#' Shiny bindings for sankey
#'
#' Output and render functions for using sankey within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a sankey
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name sankey-shiny
#'
#' @export
sankeyOutput = function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "sankey", width, height, package = "utVizSankey")
}

#' @rdname sankey-shiny
#' @export
renderSankey = function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr = substitute(expr) # force quoted
  }
  htmlwidgets::shinyRenderWidget(expr, sankeyOutput, env, quoted = TRUE)
}
