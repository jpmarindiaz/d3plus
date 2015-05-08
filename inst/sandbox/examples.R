
# library(devtools)
# library(htmlwidgets)
# document()
# devtools::install()

library(d3plus)

# Some networks
edges <- read.csv(system.file("data/edges.csv", package = "d3plus"))
nodes <- read.csv(system.file("data/nodes.csv", package = "d3plus"))
d3plus("rings",edges)
d3plus("rings", edges, focusDropdown = TRUE)
d3plus("rings", edges, nodes = nodes,focusDropdown = TRUE)
d3plus("network", edges)
d3plus("network",edges,nodes = nodes)

# A scatter plot
countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
d3plus("scatter", countries)

# Grouping bubbles
bubbles <- read.csv(system.file("data/bubbles.csv", package = "d3plus"))
d3plus("bubbles", bubbles)

# Some treemaps
d3plus("tree", countries)
d3plus("tree", bubbles[c("name","value")])

# Some lines
## Not working
#data <- read.csv(system.file("data/expenses", package = "d3plus"))
#d3plus("lines", data)

# Saving widgets
s <- d3plus("tree", countries)
htmlwidgets::saveWidget(s,"index.html", selfcontained = FALSE)
## Selfcontained= TRUE not working
# htmlwidgets::saveWidget(s,"index.html")


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








