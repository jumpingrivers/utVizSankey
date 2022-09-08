.onLoad = function(libname, pkgname) {
  # It is only possible to register a named input handler once.
  # But I found that on calling `library(utVizSankey)` twice, the following line failed if we
  # did not also specify `force = TRUE` (the use of `force = TRUE` is not recommended).
  # So now, each time the utVizSankey package is loaded, this input handler will be redefined
  shiny::registerInputHandler("utVizSankey.nodeConverter", convert_node_data, force = TRUE)
}
