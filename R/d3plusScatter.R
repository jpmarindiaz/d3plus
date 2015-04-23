#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3plusScatter <- function(data = NULL, axis = c(2,3), options = list(),
                        width = NULL, height = NULL) {
  data <- data
  id <- names(data)[1]
  xAxis <- names(data)[axis[1]]
  yAxis <- names(data)[axis[2]]

  settings <- list(
    id = id,
    xAxis = xAxis,
    yAxis = yAxis
  )
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )

  name <- "d3plusScatter"
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
d3plusScatterOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'd3plusScatter', width, height, package = 'd3plus')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3plusScatter <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3plusScatterOutput, env, quoted = TRUE)
}
