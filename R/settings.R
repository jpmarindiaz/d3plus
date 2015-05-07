getData <- function(data, type){
  if(type == "tree"){
    data <- data
  }
  if(type == "lines"){
    data <- reshape2::melt(data,id = "Year")
  }
  data
}


getSettings <- function(data,type,opts){
  if(type == "tree"){
    vars <- c("id","size","color") # add vars to opts
    data_names <- as.list(names(data))
    names(data_names) <- vars[1:length(data_names)]

    settings <- list(
      data_names = data_names,
      d3plusType = type
    )
  }
  if(type == "lines"){
    xAxis <- names(data)[1]
    id <- "variable"
    value <- "value"

    settings <- list(
      id = id,
      xAxis = xAxis,
      value = value,
      d3plusType = type
    )
  }
  settings
}
