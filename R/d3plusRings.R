#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3plusRings <- function(edges, nodes = NULL, options = list(),
                          width = NULL, height = NULL) {

  data <- cleanGraph(edges, nodes)

  drawEdges = TRUE
  drawNodes = TRUE
  settings <- list(
    drawEdges = drawEdges,
    drawNodes = drawNodes
  )
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )

  name <- "d3plusRings"
  # create widget
  htmlwidgets::createWidget(
    name = name,
    x,
    width = width,
    height = height,
    package = 'd3plus',
    sizingPolicy = htmlwidgets::sizingPolicy(
      viewer.padding = 0,
      browser.fill = TRUE
    )
  )
}

#' Widget output function for use in Shiny
#'
#' @export
d3plusRingsOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'd3plusRings', width, height, package = 'd3plus')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3plusRings <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3plusRingsOutput, env, quoted = TRUE)
}
