#' d3plus
#' @import htmlwidgets
#' @export
d3plus <- function(d, type, width = NULL, height = NULL,...) {

  args <- list(...)

  availableTypes <- c("tree","bubbles","scatter","lines","network","rings")

  if(!type %in% availableTypes)
    stop("Type must be one of ",paste0(availableTypes, collapse = ", "))
  if(type %in% c("tree","bubbles","scatter")) {
    data <- d
  }
  if(type == "lines"){
    data <- reshape2::melt(d,id = 1)
  }
  if(type %in% c("network","rings")) {
    edges <- d
    if(is.null(args$nodes))
      data <- cleanGraph(edges)
    else{
      noSingleNodes <- FALSE
      if(type == "rings") noSingleNodes <- TRUE
      data <- cleanGraph(edges, nodes = args$nodes,
                         nodeSizeVar = args$nodeSizeVar,
                         nodeColorVar = args$nodeColorVar,
                         palette = args$palette,
                         noSingleNodes = noSingleNodes)
    }
  }

  focusDropdown <- args$focusDropdown %||% FALSE
  lang <- args$lang %||% "en_US"
  showLegend <- args$showLegend %||% FALSE
  attributes <- args$attributes %||% NULL

  if(type == "tree"){
    vars <- c("id","size","color") # add vars to opts
    data_names <- as.list(names(data))
    names(data_names) <- vars[1:length(data_names)]
    settings <- list(
      data_names = data_names
    )
  }
  if(type == "lines"){
    xAxis <- names(data)[1]
    id <- "variable"
    value <- "value"
    settings <- list(
      id = id,
      xAxis = xAxis,
      value = value
    )
  }
  if(type == "bubbles"){
    #CCN, must be CCN
    # or specify what each column represents
    vars = c("id","group","value")
    data_names <- as.list(names(data))
    names(data_names) <- vars
    settings <- list(
      data_names = data_names,
      attributes = attributes
    )
  }
  if(type == "scatter"){
    axis = c(2,3)
    id <- names(data)[1]
    xAxis <- names(data)[axis[1]]
    yAxis <- names(data)[axis[2]]
    size <- names(data)[4]
    size <- size %||% FALSE

    settings <- list(
      id = id,
      xAxis = xAxis,
      yAxis = yAxis,
      size = size
    )
  }
  if(type %in% c("network","rings")){
    drawEdges <- TRUE
    drawNodes <- TRUE
    settings <- list(
      drawEdges = drawEdges,
      drawNodes = drawNodes,
      focusDropdown = focusDropdown,
      lang = lang,
      showLegend = showLegend
    )
  }

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
