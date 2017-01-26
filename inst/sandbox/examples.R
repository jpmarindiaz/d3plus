
library(devtools)
library(htmlwidgets)
document()
#load_all()
devtools::install()

library(d3plus)


# # Some treemaps
countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))

bubbles <- read.csv(system.file("data/senado-tlc-corea.csv", package = "d3plus"))
d3plus(countries, "tree")
d3plus(bubbles[c(1,3)], "tree")
d3plus(bubbles[c(2,3)], "tree")








# Grouping bubbles with color
bubbles <- read.csv(system.file("data/senado-tlc-corea.csv", package = "d3plus"))
bubbles <- bubbles[c(2,1,3)]
attributes <- data.frame(Partido = unique(bubbles$Partido),
                         color = RColorBrewer::brewer.pal(9,"Set1"))
d3plus(bubbles, "bubbles", attributes = attributes)

# Saving widgets
countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
s <- d3plus(countries, "tree")
s
htmlwidgets::saveWidget(s,"index.html", selfcontained = FALSE)
htmlwidgets::saveWidget(s,"index.html")


# Grouping bubbles
bubbles <- read.csv(system.file("data/bubbles.csv", package = "d3plus"))
d3plus(bubbles, "bubbles")
bubbles <- read.csv(system.file("data/senado-tlc-corea.csv", package = "d3plus"))
d3plus(bubbles,"bubbles")
d3plus(bubbles[c(2,1,3)],"bubbles")


# Some lines
data <- read.csv(system.file("data/expenses.csv", package = "d3plus"))
d3plus(data,"lines")


# A scatter plot
countries <- read.csv(system.file("data/countries.csv", package = "d3plus"))
d3plus(countries,"scatter")
countries$big <- ceiling(10*runif(1:nrow(countries)))
d3plus(countries,"scatter")



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
      d3plus(d,"tree")
    })
  }
)
runApp(app)








