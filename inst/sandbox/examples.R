
library(devtools)
library(htmlwidgets)
document()
#load_all()
devtools::install()

library(d3plus)

#

edges <- read.csv(system.file("data/edges-prod.csv", package = "d3plus"))
nodes <- read.csv(system.file("data/nodes-prod.csv", package = "d3plus"))
nodes$x <- NULL
nodes$y <- NULL
nodes$label <- nodes$description
d3plus("network",edges,nodes = nodes)


# Some networks
edg <- read.csv(system.file("data/edges.csv", package = "d3plus"))
d3plus("network", edg)

# Some networks
edges <- read.csv(system.file("data/edges.csv", package = "d3plus"))
nodes <- read.csv(system.file("data/nodes.csv", package = "d3plus"))
d3plus("network", edges)
d3plus("network",edges,nodes = nodes)
d3plus("rings",edges)
d3plus("rings", edges, focusDropdown = TRUE)
d3plus("rings", edges, nodes = nodes,focusDropdown = TRUE)


# Grouping bubbles with color
bubbles <- read.csv(system.file("data/senado-tlc-corea.csv", package = "d3plus"))
bubbles <- bubbles[c(2,1,3)]
attributes <- data.frame(Partido = unique(bubbles$Partido),
                         color = RColorBrewer::brewer.pal(9,"Set1"))
d3plus("bubbles", bubbles, attributes = attributes)

# Saving widgets
s <- d3plus("tree", countries)
htmlwidgets::saveWidget(s,"index.html", selfcontained = FALSE)
htmlwidgets::saveWidget(s,"index.html")


# Grouping bubbles
bubbles <- read.csv(system.file("data/bubbles.csv", package = "d3plus"))
d3plus("bubbles", bubbles)
bubbles <- read.csv(system.file("data/senado-tlc-corea.csv", package = "d3plus"))
d3plus("bubbles", bubbles)
d3plus("bubbles", bubbles[c(2,1,3)])


# Some lines
data <- read.csv(system.file("data/expenses.csv", package = "d3plus"))
d3plus("lines", data)


# A scatter plot
countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
d3plus("scatter", countries)
countries$big <- ceiling(10*runif(1:nrow(countries)))
d3plus("scatter", countries)




# Some treemaps
d3plus("tree", countries)
d3plus("tree", bubbles[c("name","value")])






# A nice shiny app
library(shiny)
app <- shinyApp(
  ui = bootstrapPage(
    checkboxInput("swapNCols","Swap columns",value=FALSE),
    d3plusOutput("viz")
  ),
  server = function(input, output) {
    countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
    output$viz <- renderD3plus({
      d <- countries
      if(input$swapNCols){
        d <- d[c(1,3,2)]
      }
      d3plus("tree",d)
    })
  }
)
runApp(app)








