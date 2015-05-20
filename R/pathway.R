library(hash)

pathway.events <- hash()
pathway.uniCtr <- 97

pathway.event <- function( event ) {
  if(is.null(pathway.events[[ event ]])){
    pathway.events[[event]] <- intToUtf8(pathway.uniCtr)
    pathway.uniCtr <<- pathway.uniCtr + 1
  }
  return( pathway.events[[ event ]] )
}

pathway.load <- function(file, format="ncol") {
  pathway.pathway <<- read.graph(file, format=format, directed=TRUE)
  return( pathway.pathway )
}

pathway.startVertices <- function () {
  d<-degree(pathway.pathway, mode="in") #get in degree of all vertices
  return( names(d[d==0]) ) #filter to those with in degree of 0 and get names
}