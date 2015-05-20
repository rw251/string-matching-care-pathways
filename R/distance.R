library(stringdist)

normalisedLevenshteinDistance <- function(str1, str2){
  return(stringdist(str1, str2, method="lv") / (nchar(str1) + nchar(str2)))
}

normalisedDamerauLevenshteinDistance <- function(str1, str2){
  return(stringdist(str1, str2, method="dl") / (nchar(str1) + nchar(str2)))
}

metricLevenshteinDistance <- function(str1, str2){
  lv <- stringdist(str1, str2, method="lv");
  return(2 * lv / (nchar(str1) + nchar(str2) + lv))
}

lcs <- function(str1, str2) {
  # Computes the length of the longest common subsequence of two strings
  #
  # Args:
  #   str1: The first string. (required)
  #   str2: The second string.(required)
  #
  # Returns:
  #   The length of the LCS
  
  l <- stringdist(str1, str2, method="lcs") #this is the lcs-distance
  return((nchar(str1) + nchar(str2) - l)/2)
}

normalisedLCS <- function(str1, str2){
  l <- lcs(str1, str2)
  return((max(nchar(str1), nchar(str2)) - l) / l)
}

normalisedLCS2 <- function(str1, str2){
  l <- lcs(str1, str2)
  return((max(nchar(str1), nchar(str2)) - l) / (nchar(str1) + nchar(str2)))
}

#distance.stringdist("cat","batter",method="lv")
#distance.stringdist("cat","batter",method="nlv")
#distance.stringdist("cat","batter",method="mlv")
distance.stringdist <- function(str1, str2, method="osa") {
  if (method == "nlv") {
    return(normalisedLevenshteinDistance(str1, str2))
  } else if (method == "mlv") {
    return(metricLevenshteinDistance(str1, str2))
  } else if (method == "lcs1") {
    return(normalisedLCS(str1, str2))
  } else if (method == "lcs2") {
    return(normalisedLCS2(str1, str2))
  } else if (method == "ndl") {
    return(normalisedDamerauLevenshteinDistance(str1, str2))
  } else {
    return(stringdist(str1, str2, method))
  }
}