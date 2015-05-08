#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3plus <- function(type, data, width = NULL, height = NULL,...) {

  data <- getData(type, data, ...)
  settings <- getSettings(type,data, ...)
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings,
    d3plusType = type
  )

  htmlwidgets::createWidget(
    name = "d3plus",
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
d3plusOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'd3plus', width, height, package = 'd3plus')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3plus <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3plusOutput, env, quoted = TRUE)
}
