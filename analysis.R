library(igraph)
library(hash)
source("R/distance.R")
source("R/pathway.R")
source("R/patient.R")

####################
## Set parameters ##
####################
#config.patient.filename <- "data/sample-patient-file.txt"
config.patient.filename <- "data/fake-sinap-patient-file.txt"
config.patient.date.format <- "%Y/%m/%d %H:%M"  # see help(strptime)

#config.pathway.filename <- "data/sample-pathway.ncol"
config.pathway.filename <- "data/sinap-pathway.gml"
config.pathway.format <- "gml"  #Also "edgelist", "pajek", "ncol", "lgl", "graphml", "dimacs", "graphdb", "gml", "dl" see http://igraph.org/r/doc/read.graph.html

#load patient data and get individual pathway strings
patients <- patient.pathways(config.patient.filename, dateFormat=config.patient.date.format)

#load pathway
pathway <- pathway.load(config.pathway.filename, format=config.pathway.format)
plot(pathway)

all.paths <- pathway.allPaths()

for (i in 1:length(patients)) {
  min.dist <- 100000
  min.paths <- character()
  
  for (j in 1:length(all.paths)) {
    dist <- distance.stringdist(patients[[keys(patients)[[i]]]], all.paths[[j]], method="lcs2")
    #tested with lv, nlv, mlv, dm, ndm, lcs1, lcs2 - all exact matches to SINAP results
    if (dist < min.dist) {
      min.dist <- dist
      min.paths <- c(all.paths[[j]])
    } else if (dist == min.dist) {
      min.paths <- c(min.paths, all.paths[[j]])
    }    
  }
  if (length(min.paths) > 1) {
    patients[[keys(patients)[[i]]]] <- c(patients[[keys(patients)[[i]]]], paste(length(min.paths),"matches"), min.dist)
  } else {
    patients[[keys(patients)[[i]]]] <- c(patients[[keys(patients)[[i]]]], min.paths[[1]], min.dist)
  }
}

patients

## missing functions
# SimulatePatients
# GeneratePatientPathwayData - both for simulating patients in pathway
# Enumerate cycles - thought didn't use this for SINAP..?
# AttemptOrdering(midnightEvents, sameDayEvents) - for events at midnight (i.e. where time lost) - can we slot them in
#
#private static bool AttemptOrdering(IEnumerable<Event> midnightEvents, List<Event> sameDayEvents)
#{
#  
#  foreach (var midnightEvent in midnightEvents)
#{
#    var i = GetLocation(sameDayEvents, midnightEvent);
#    if(i<0) return false;
#    sameDayEvents.Insert(i, midnightEvent);
#  }
#
#return true;
#}
#
#private static int GetLocation(List<Event> events, Event eventToFit)
#{
#  var done = false;
#  var rtn = -1;
#  for(var i = 0; i < events.Count; i++)
#  {
#    var c = CompareEvents(events[i], eventToFit);
#    if (c == EventComparison.Both || c == EventComparison.Neither) return -1;
#    if (!done && c == EventComparison.GreaterThan)
#    {
#      done = true;
#      rtn = i;
#    }
#    else if (done && c == EventComparison.LessThan) return -1;
#  }
#  return rtn < 0 ? events.Count : rtn;
#}