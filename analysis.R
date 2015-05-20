library(igraph)
library(hash)
source("R/distance.R")
source("R/pathway.R")
source("R/patient.R")

####################
## Set parameters ##
####################
config.patient.filename <- "data/sample-patient-file.txt"
config.patient.date.format <- "%Y/%m/%d %H:%M"  # see help(strptime)

config.pathway.filename <- "data/sample-pathway.ncol"
config.pathway.format <- "ncol"  #Also "edgelist", "pajek", "ncol", "lgl", "graphml", "dimacs", "graphdb", "gml", "dl" see http://igraph.org/r/doc/read.graph.html

#load patient data and get individual pathway strings
patient.pathways(config.patient.filename, dateFormat=config.patient.date.format)

#load pathway
pathway <- pathway.load(config.pathway.filename, format=config.pathway.format)

sv <- pathway.startVertices()

for(i in 1:length(sv)){
  
}
#plot(pathway)

#Get all paths
# assume no recursion

#select start node

#flag as visited

#visit each

#identify start nodes

# add two nodes
# add 1 to indegree of second
#loop through nodes and return those with indeg of 0