
devtools::install()
library(d3plus)


# Some networks
edges <- read.csv(system.file("data/edges.csv", package = "d3plus"))
nodes <- read.csv(system.file("data/nodes.csv", package = "d3plus"))

d3plus(edges,"network")
d3plus(edges,"network",nodes = nodes)
nodes$color <- NULL
d3plus(edges,"network",nodes = nodes, nodeColorVar = "group")
d3plus(edges,"network",nodes = nodes, nodeColorVar = "size", palette = "Greens")
d3plus(edges,"network",nodes = nodes, nodeColorVar = "group", palette = "Set2")
d3plus(edges,"network",nodes = nodes, lang = "es_ES")

d3plus(edges,"rings")
d3plus(edges, "rings", nodes = nodes)
nodes$weight <- runif(nrow(nodes))*100
d3plus(edges, "rings", nodes = nodes, nodeSizeVar = "weight")
d3plus(edges, "rings", nodes = nodes, nodeSizeVar = "weight",nodeColorVar = "weight", palette = "Oranges")
d3plus(edges, "rings", nodes = nodes, nodeColorVar = "group", palette = "Greys")
d3plus(edges, "rings", nodes = nodes, focusDropdown = TRUE)
d3plus(edges, "rings", focusDropdown = TRUE)

###

edges <- read.csv(system.file("data/edges-prod.csv", package = "d3plus"))
nodes <- read.csv(system.file("data/nodes-prod.csv", package = "d3plus"))
nodes$label <- nodes$description
nodes$color <- sample(substr(rainbow(12),1,7),nrow(nodes),replace = TRUE)
d <- edges
type <- "network"
d3plus(edges,"network",nodes = nodes, nodeSizeVar = "group")
d3plus(edges,"network",nodes = nodes)
d3plus(d,type)


# Some networks
edg <- read.csv(system.file("data/edges.csv", package = "d3plus"))
d3plus(edg, "network")


