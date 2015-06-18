getData <- function(type,data, ...){
  args <- list(...)
  if(type %in% c("tree","bubbles","scatter")){
    data <- data
  }
  if(type == "lines"){
    data <- reshape2::melt(data,id = 1)
  }
  if(type %in% c("network","rings")){
    if(is.null(args$nodes))
      data <- cleanGraph(edges)
    else
    data <- cleanGraph(edges, nodes)
  }
  data
}


getSettings <- function(type, data,...){
  args <- list(...)
  focusDropdown <- args$focusDropdown %||% FALSE
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
      focusDropdown = focusDropdown
    )
  }

  settings
}
