
#library(devtools)
#library(htmlwidgets)
#document()
#devtools::install()

library(d3plus)

library(readr)
data <- read_csv("inst/data/electricity-expenses.csv")
d3plusLines(data)


data <- read.csv("inst/data/cab-inf-countries.csv")
d3plusScatter(data)


edges <- read.csv("inst/data/edges.csv")
nodes <- read.csv("inst/data/nodes.csv")

edges$label <- paste(edges$source, edges$target, sep = "-")

d3plusRings(edges,nodes)
d3plusRings(edges)

d3plusNetwork(edges,nodes)
d3plusNetwork(edges)





