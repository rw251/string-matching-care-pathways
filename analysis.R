#library(some_package)
#library(another_package)
#source("R/functions.R")
#source("R/utilities.R")
source("R/distances.R")
library(igraph)

mystringdist("cat","batter",method="lv")
mystringdist("cat","batter",method="nlv")
mystringdist("cat","batter",method="mlv")

#load patient data

patient.data <- read.table("data/sample-patient-file.txt", sep="\t", header=TRUE)

#pathway <- read.graph("data/sample-pathway.graphml", format="graphml")
pathway <- read.graph("data/sample-pathway.ncol", format="ncol", directed=TRUE)

#plot(pathway)

