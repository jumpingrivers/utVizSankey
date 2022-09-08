#' Function for converting the data.entries component of a node on the Sankey visualization to an
#' R data.frame
#'
#' @param   x   The data obtained from the JavaScript Sankey visualization for an alt-clicked node.
#'   This should already have been transformed with \code{jsonlite::fromJSON} and be a list of
#'   lists.
#' @param   session,inputname   shiny session and inputname for the element. Not used.
#'
#' @return   A data.frame with as many rows as there are entries in the list \code{x}. The names in
#'   each sub-entry of \code{x} define the columns of this data.frame.

convert_node_data = function(x, session, inputname) {
  stopifnot("purrr" %in% utils::installed.packages())
  purrr::map_dfr(x, as.data.frame)
}
