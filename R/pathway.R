library(hash)

pathway.events <- hash()
pathway.uniCtr <- 97

pathway.events[["stroke"]] <- "G"
pathway.events[["first seen"]] <-"D"
pathway.events[["arrive hospital"]] <-"H"
pathway.events[["arrive stroke bed"]] <-"F"
pathway.events[["discharge stroke unit"]] <-"I"
pathway.events[["discharge hospital"]] <-"B"
pathway.events[["brain imaging"]] <-"E"
pathway.events[["thrombolysis"]] <-"A"
pathway.events[["follow up scan"]] <-"C"


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
  if (format=="ncol") {
    pathway.pathway <<- read.graph(file, format=format, directed=TRUE)
  } else {
    pathway.pathway <<- read.graph(file, format=format) 
  }
  return(pathway.pathway)
}

pathway.startVertices <- function () {
  d<-degree(pathway.pathway, mode="in") #get in degree of all vertices
  return(as.list(rep(1:length(d))[d==0])) #filter to those with in degree of 0 and get vertex indices
}

pathway.allPaths <- function() {
  sv <- pathway.startVertices()
  output <- character()
  
  f.adjlist <- get.adjlist(pathway.pathway, mode = "out")
  
  while (length(sv) > 0) {
    l <- sv[[ length(sv) ]]
    length(sv) <- length(sv)-1  # pop the first pending path
    
    v <- l[[length(l)]]  # Get the last vertex of the path
    
    if (length(f.adjlist[[v]]) == 0) {      
      output <- c(output, paste(pathway.eventList(get.vertex.attribute(pathway.pathway, "name", l)), collapse=""))  # output it (or save it in a list to be returned, if you prefer)
    }
    
    for (i in f.adjlist[[v]]) {
      sv[[ length(sv)+1 ]] <- c(l, i)
    }
  } 
  return(output)
}