#' Create a Sankey plot
#'
#' Create a HTML sankey plot for displaying admissions and retention data
#'
#' @param   data   Data-frame containing one row per observation (student).
#' @param   steps   Character vector or list containing a subset of the column names in `data`.
#'   These correspond to the stages of the sankey chart. Where a list is provided, elements of the
#'   list can contain vectors which specify how a step will be further subdivided (drilled-down
#'   into) when that step is clicked on.
#' @param   color   Character representing a single color. This color is used to color all nodes
#'   that don't have an associated color override. Links emanating from these nodes will be a
#'   translucent version of this color.
#' @param   hover_color   Character representing a single color. This color is used to highlight a
#'   node on hover. It is also used---in a translucent form---to highlight a link on hover.
#' @param   color_overrides   If supplied, this should be a list of lists. Each of the inner lists
#'   specifies some form of color override. To have any effect it must have a "color" entry and at
#'   least one of a "name" entry and a "group" entry. The "name" entry corresponds to the name or
#'   label of a node while the "group" entry corresponds to the name associated with the column in
#'   the Sankey. This means the groups are derived from the keys in the supplied data while the
#'   names are the values associated with these keys. An override assigned to a node through a
#'   "name" entry trumps an override assigned through a "group" entry. An override assigned through
#'   a "name" and a "group" entry in the same object will trump both of these.
#' @param   node_template,link_template   Template strings defining the text presented the popups
#'   that are shown when hovering over a node or a link. These use the
#'   [Handlebars HTML templating language](https://handlebarsjs.com/). If supplied, these should be
#'   a single character string. Alongside regular HTML constructs, the templates can reference the
#'   following properties.
#'
#'   For \code{node_template}:
#'   * \code{ {{name}} } the name of the node.
#'   * \code{ {{count}} } the count of the node.
#'   * \code{ {{totalCount}} } the total count for the whole Sankey diagram.
#'
#'   For \code{link_template}:
#'   * \code{ {{sourceName}} } the name of the source node of the link.
#'   * \code{ {{targetName}} } the name of the target node of the link.
#'   * \code{ {{count}} } the count of the link.
#'   * \code{ {{totalCount}} } the total count for the whole Sankey diagram.
#'   * \code{ {{percentageOfSourceCount}} } the (rounded) percentage value of all counts from the
#'     source node that go through this link.
#'   * \code{ {{percentageOfTargetCount}} } the (rounded) percentage value of all counts to the
#'     target node that go through this link.
#'
#' @param   alt_click_handler   A JavaScript function to be called when the user alt-clicks on a
#'   node in the Sankey chart. Construct this with \code{htmlwidgets::JS()}. The function should
#'   have parameters "event" and "data".
#' @param   width,height   The initial size of the visualization
#' @param   elementId   Identifier for the HTML element into which the visualization will be added.
#' @return   A html widget containing a Sankey diagram of the data
#' @examples
#' data(admissions)
#' sankey(
#'   admissions,
#'   steps = c("student_type", "gpa", "outcome")
#' )
#'
#' # steps can be a list containing vectors.
#' sankey(
#'   admissions,
#'   steps = list(c("student_type", "college"), "gpa", "outcome")
#' )
#'
#' @export
sankey = function(data,
                  steps,
                  color = NULL,
                  hover_color = NULL,
                  color_overrides = NULL,
                  node_template = NULL,
                  link_template = NULL,
                  alt_click_handler = NULL,
                  width = NULL,
                  height = NULL,
                  elementId = NULL) {
  used_steps = unlist(steps)
  if (!all(used_steps %in% colnames(data)) || any(duplicated(used_steps))) {
    stop("steps should be unique and be a subset of colnames(data)")
  }

  x = list(
    data = data,
    steps = steps
  )

  if (!is.null(alt_click_handler)) {
    x$altClickHandler = alt_click_handler
  }
  if (!is.null(color)) {
    x$color = gplots::col2hex(color)
  }
  if (!is.null(hover_color)) {
    x$hoverColor = gplots::col2hex(hover_color)
  }
  if (!is.null(color_overrides)) {
    x$colorOverrides = Map(
      function(z) {
        # z is a list(color = "...", name = "...", group = "...")
        z$color = gplots::col2hex(z$color)
        z
      },
      color_overrides
    )
  }
  if (!is.null(node_template)) {
    x$nodePopupTemplate = node_template
  }
  if (!is.null(link_template)) {
    x$linkPopupTemplate = link_template
  }

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
