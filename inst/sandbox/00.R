
library(devtools)
library(htmlwidgets)
document()
devtools::install()

library(d3plus)

data <- tblpkg::sampleData("CNN")
type <- "tree"
d3plus(data,"tree")

data <- tblpkg::sampleData("DNNNN")
d3plus(data,"lines")


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
      d3plus(d,"tree")
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








