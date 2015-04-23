#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3plusLines <- function(data, options = list(),
                          width = NULL, height = NULL) {
  xAxis <- names(data)[1]
  data <- reshape2::melt(data,id = "Year")
  id <- "variable"
  value <- "value"

  settings <- list(
    id = id,
    xAxis = xAxis,
    value = value
  )
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )

  name <- "d3plusLines"
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
d3plusLinesOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'd3plusLines', width, height, package = 'd3plus')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3plusLines <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3plusLinesOutput, env, quoted = TRUE)
}
