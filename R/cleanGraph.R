#' @export
cleanGraph <- function(edges, nodes = NULL,
                       nodeSizeVar = NULL,
                       nodeColorVar = NULL,
                       palette = NULL,
                       noSingleNodes = NULL){
  vars <- list()

  noSingleNodes <- noSingleNodes %||% TRUE
  if (is.null(edges)){
    stop("Must specify edges as dataframe")
  }

  if (is.null(nodes)){
    message("No nodes provided: taking nodes from edges list")
    n <- unique(c(as.character(edges$source), as.character(edges$target)))
    nodes <- data.frame(id = n)
  } else{
    if(class(c(edges$source,edges$target)) != class(nodes$id))
      stop("Class of edges and nodes must be the same")

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

  if (is.null(nodeColorVar)){
    if(is.null(nodes$color)){
      nodes$color <- "#FE34A0"
    }
  }else{
    if(!nodeColorVar %in% names(nodes))
      stop("nodeColorVar not in nodes")
    nodes$color <- getColors(nodes[[nodeColorVar]], palette)
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

  if(noSingleNodes){
    nodesInEdges <- nodes$id[nodes$id %in% c(edges$source,edges$target)]
    nodes <- nodes %>% filter(id %in% nodesInEdges)
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


getColors <- function(x,palette = NULL){
  palette <- palette %||% "Set1"
  if(class(x) %in% c("factor","character")){
    vals <- unique(x)
    colors <- RColorBrewer::brewer.pal(length(vals),palette)
    if(length(colors) < length(vals)){
      colors <- colorRampPalette(colors)(length(vals))
    }
    colors <- colors[match(x,vals)]
  }
  if(class(x) %in% c("numeric","integer")){
    n <- min(length(unique(x)),9)
    colors <- colorRampPalette(RColorBrewer::brewer.pal(9, palette))(n)
    colors <- colors[match(x,unique(sort(x)))]
  }
  colors
}




# catColor <- function(v,palette = NULL){
#   palette <- palette %||% "RdYlBu"
#   pal <- colorFactor(palette, levels = unique(v))
#   pal(v)
# }
#
# numColor <- function(v,palette = "PuBu", domain = NULL){
#   pal <- colorNumeric(palette, domain = NULL)
#   pal(v)
# }
#
# quanColor <- function(v,palette = "RdYlBu", domain = NULL, n = NULL){
#   #n <- n %||% length(unique(v))/5
#   pal <- colorQuantile(palette, domain = domain, n = n)
#   tryCatch(pal(v), error = function(e){
#     pal2 <- colorQuantile(palette, domain = domain, n = n-1)
#     return(pal2(v))
#   })
# }


# Seq palette
# Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd
# Divergent
# BrBG PiYG PRGn PuOr RdBu RdGy RdYlBu RdYlGn Spectral
# Qualitative
# Accent Dark2 Paired Pastel1 Pastel2 Set1 Set2 Set3


# c("Blues", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "Oranges", "OrRd", "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd", "BrBG", "PiYG", "PRGn", "PuOr", "RdBu", "RdGy", "RdYlBu", "RdYlGn", "Spectral", "Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1", "Set2", "Set3")



