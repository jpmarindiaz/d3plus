#' @export
cleanGraph <- function(edges, nodes = NULL, nodeSizeVar = NULL){
  vars <- list()

  if (is.null(edges)){
    stop("Must specify edges as dataframe")
  }

  if (is.null(nodes)){
    message("No nodes provided: taking nodes from edges list")
    n <- unique(c(as.character(edges$source), as.character(edges$target)))
    nodes <- data.frame(id = n)
  }

  if (is.null(nodes$id)){
    stop("No node id provided")
  }

#   if (is.null(nodes$label)){
#     message("No node labels provided: using labels as id")
#     nodes$label <- nodes$id
#   }

  if (is.null(nodes$x) || is.null(nodes$y)){
    message("No node position provided: using automatic")
    positions <- FALSE
  }

  if(!is.null(nodeSizeVar)){
  nodes$size <- nodes[[nodeSizeVar]]
  }else{
    nodeSizeVar <- "size"
  }

  if (is.null(nodes$size)){
    message("No node size provided: using random value")
    nodes$size <- 1
  }else{
    vars$size <- nodeSizeVar
  }

  if (is.null(nodes$color)){
    message("No node color provided: using default")
    nodes$color <- "#FE34A0"
  }

  if(is.null(nodes$label)){
    nodes$label <- nodes$id
  }

#   if (is.null(nodes$type)){
#     message("No node type provided: using random")
#     ntypes <- c("diamond","square","circle","star","equilateral")
#     nodes$type <- sample(ntypes,1)
#   }

#   if(is.null(edges$id)){
#     edges$id <- paste0("e",seq(1:nrow(edges)))
#   } else {
#     if(length(unique(edges$id))< nrow(edges)){
#       message("edges id not unique: overriding edges id")
#       edges$id <- seq(1:nrow(edges))
#     }
#   }
  if (is.null(edges$size)){
    message("No edge size provided: using 1")
    edges$size <- 1
  }
  if (is.null(edges$label)){
    message("No edge label provided")
    edges$label <- ""
  }

#   if (is.null(edges$type)){
#     message("No edge type provided: using random")
#     etypes <- c("line","arrow","curvedArrow","curve")
#     edges$type <- sample(etypes,1)
#   }

#   nodes <- apply(nodes, 1,function(r){
#     as.list(r)
#   })
#
#   edges <- apply(edges, 1,function(r){
#     as.list(r)
#   })

  g <- list(nodes=nodes, edges=edges, positions = positions, vars = vars)
  data <- g
  data
}
