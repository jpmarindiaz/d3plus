
devtools::install()
library(d3plus)



library(tidyverse)
library(d3plus) #devtools::install_github("jpmarindiaz/d3plus")

####


edges0 <- read_csv("~/Downloads/relaciones_data.csv")
df_catalogo <- read_csv("~/Downloads/catalogo_productos_morph_data.csv")
nodes <- df_catalogo %>%
  dplyr::mutate(vm_1_trend = ifelse(is.na(vm_1_trend), "NO DEFINIDO", vm_1_trend)) %>%
  dplyr::mutate(comerssia_family = ifelse(is.na(comerssia_family), "NO DEFINIDO", comerssia_family)) %>%
  dplyr::select(id = complete_id, label = description, vm_1_trend, comerssia_family)


min_cota <- 100
max_cota <- 200
edges <- edges0 %>% filter(weight >= min_cota & weight <= max_cota)

names(nodes)
d3plus(edges, "network")
d3plus(edges, "rings")

nodes <- nodes %>% filter(id %in% unique(c(edges$source,edges$target)))
length(unique(nodes$id))
length(unique(c(edges$source,edges$target)))
names(nodes)[3] <- "group"
names(nodes)[4] <- "group2"


d3plus(edges, "network", nodes = nodes, nodeColorVar = "comerssia_family", showLegend = TRUE)
d3plus(edges, "network", nodes = nodes, nodeColorVar = "group", showLegend = TRUE)

d3plus(edges, "rings", nodes = nodes, nodeColorVar = "group2", showLegend = TRUE)



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


