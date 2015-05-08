
library(devtools)
library(htmlwidgets)
document()
devtools::install()

library(d3plus)

edges <- read.csv("inst/data/edges.csv")
nodes <- read.csv("inst/data/nodes.csv")

d3plus("rings",edges)
d3plus("rings", edges, focusDropdown = TRUE)
d3plus("rings", edges, nodes = nodes,focusDropdown = TRUE)


d3plus("network", edges)
d3plus("network",edges,nodes = nodes)


data <- tblpkg::sampleData("CNN")
d3plus("scatter", data)

data <- tblpkg::sampleData("CCN")
data <- tblpkg::sampleData("CCN1")
d3plus("bubbles", data)

data <- tblpkg::sampleData("CNN")
d3plus("tree", data[c(1,3,2)])

data <- tblpkg::sampleData("DNNNN")
d3plus("lines", data)




library(shiny)

app <- shinyApp(
  ui = bootstrapPage(
    checkboxInput("swapNCols","Swap columns",value=FALSE),
    d3plusOutput("viz")
  ),
  server = function(input, output) {
    output$viz <- renderD3plus({
      d <- tblpkg::sampleData("CNN")
      if(input$swapNCols){
        d <- d[c(1,3,2)]
      }
      d3plus("tree",d)
    })
  }
)
runApp(app)









data <- read.csv("inst/data/bubbles.csv")
d3plusBubbles(data)


edges <- read.csv("inst/data/edges.csv")
edges$label <- paste(edges$source, edges$target, sep = "-")
d3plusRingsFocus(edges)

edges <- read.csv("inst/data/edges.csv")
nodes <- read.csv("inst/data/nodes.csv")
d3plusRings(edges)

d3plusNetwork(edges,nodes)
d3plusNetwork(edges)

edges$label <- paste(edges$source, edges$target, sep = "-")
d3plusRings(edges,nodes)


library(readr)
data <- read_csv("inst/data/electricity-expenses.csv")
d3plusLines(data)

data <- read.csv("inst/data/cab-inf-countries.csv")
d3plusScatter(data)








