library(hash)

pathway.events <- hash()
pathway.uniCtr <- 97

pathway.event <- function( event ) {
  if(is.null(pathway.events[[ event ]])){
    pathway.events[[event]] <- intToUtf8(pathway.uniCtr)
    pathway.uniCtr <<- pathway.uniCtr + 1
  }
  return(pathway.events[[ event ]])
}

pathway.eventList <- function( events ) {
  return(lapply(events, pathway.event))
}

pathway.load <- function(file, format="ncol") {
  pathway.pathway <<- read.graph(file, format=format, directed=TRUE)
  return(pathway.pathway)
}

pathway.startVertices <- function () {
  d<-degree(pathway.pathway, mode="in") #get in degree of all vertices
  return(as.list(names(d[d==0]))) #filter to those with in degree of 0 and get names
}

pathway.allPaths <- function() {
  sv <- pathway.startVertices()
  
  f.adjlist <- get.adjlist(pathway.pathway, mode = "out")
  
  while (length(sv) > 0) {
    l <- sv[[ length(sv) ]]
    length(sv) <- length(sv)-1  # pop the first pending path
    
    v <- l[[length(l)]]  # Get the last vertex of the path
    
    if (length(f.adjlist[[v]]) == 0) {      
      cat(paste(pathway.eventList(l)), "\n")  # output it (or save it in a list to be returned, if you prefer)
    }
    
    for (i in f.adjlist[[v]]) {
      sv[[ length(sv)+1 ]] <- c(l, names(pathway.pathway[[i]]))
    }
  } 
}