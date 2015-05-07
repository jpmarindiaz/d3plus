#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3plusBubbles <- function(data, vars = c("id","group","value"),
                        width = NULL, height = NULL) {
  #CCN, must be CCN
  # or specify what each column represents

  data_names <- as.list(names(data))
  names(data_names) <- vars

  settings <- list(
    data_names = data_names
  )
  # pass the data and settings using 'x'
  x <- list(
    data = data,
    settings = settings
  )

  name <- "d3plusBubbles"
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
d3plusBubblesOutput <- function(outputId, width = '100%', height = '500px'){
  shinyWidgetOutput(outputId, 'd3plusBubbles', width, height, package = 'd3plus')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3plusBubbles <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3plusBubblesOutput, env, quoted = TRUE)
}
