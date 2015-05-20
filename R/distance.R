library(stringdist)

normalisedLevenshteinDistance <- function(str1, str2){
  return(stringdist(str1, str2, method="lv") / (nchar(str1) + nchar(str2)))
}

metricLevenshteinDistance <- function(str1, str2){
  lv <- stringdist(str1, str2, method="lv");
  return(2 * lv / (nchar(str1) + nchar(str2) + lv))
}

#distance.stringdist("cat","batter",method="lv")
#distance.stringdist("cat","batter",method="nlv")
#distance.stringdist("cat","batter",method="mlv")
distances.stringdist <- function(str1, str2, method="osa") {
  if (method == "nlv") {
    return(normalisedLevenshteinDistance(str1, str2))
  } else if (method == "mlv") {
    return(metricLevenshteinDistance(str1, str2))
  } else {
    return(stringdist(str1, str2, method))
  }
}