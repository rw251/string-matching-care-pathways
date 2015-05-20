library(hash)
source("R/pathway.R")

patient.patients <- hash()

patient.load <- function(file, sep="\t", header=TRUE, col.names=c("patid", "dt", "event")) {
  patient.data <- read.table(file, sep=sep, header=header, col.names=col.names)
  patient.data.sorted <<- patient.data[order(patient.data$patid,patient.data$dt), ]
}

patient.pathways <- function (file, dateFormat="%Y/%m/%d %H:%M", sep="\t", header=TRUE, col.names=c("patid", "dt", "event")) {
  
  patient.dateFormat <<- dateFormat
  patient.load(file, sep=sep, header=header, col.names=col.names)
  
  patid <- -1
  lastDt <- date()
  path <- character()
  
  for(i in 1:(length(patient.data.sorted[, 1])-1)) {
    event <- pathway.event(as.character(patient.data.sorted[i, "event"]))
    dt <- strptime(patient.data.sorted[i, "dt"], patient.dateFormat)  
    
    if(patient.data.sorted[i, "patid"] == patid){
      path <- c(path, event)
      #time diff
      diff <- as.double(difftime(dt, lastDt, units = "mins"))
    } else {
      if(length(path) > 0){
        patient.patients[patid] <- paste(path, collapse="")
      }
      #New patient
      patid <- patient.data.sorted[i, "patid"]
      path <- c(event)
    }
    lastDt <- dt  
  }
  
  if(length(path) > 0){
    patient.patients[patid] <- paste(path, collapse="")
  }
  
  return( patient.patients )
}