library(readr)
library(dplyr)
library(tidyr)
library(ggfortify)

# import gata in R
FRA <- read_csv("data/FRA.csv")
FRN <- read_csv("data/FRN.csv")

# convert NA TO 0
FRA[is.na(FRA)] <- 0
FRN[is.na(FRN)] <- 0

# look at the structure of the data
glimpse(FRA)
glimpse(FRN)

# tidy the data
tidyFRA <-
  FRA %>%
  gather(key = Month, value = Area, -Year)

# sort data by month
tidyFRA <- tidyFRA[order(tidyFRA$Year),]

# coerce the Year and Month variables to factos
tidyFRA[-3] <- lapply(tidyFRA[-3], as.factor)

link_fun <- c("binomial", "gaussian", "Gamma", "inverse.gaussian", "poisson",
              "quasi", "quasibinomial", "quasipoisson")

# git GLM to data using a gaussian link function
fit_FRA <- lapply(link_fun, function(x){
  tryCatch(glm(formula = Area ~ Year + Month, family = x, data = tidyFRA),
           error = function(e) {
             print(paste("link function not compactible", x))
           }
  )
})


# print fit summary
for(i in 1:length(fit_FRA)){

  if(length(fit_FRA[[i]]) > 1){
    cat("\n")
    print(paste0("###### Summary for ", link_fun[i], " ######"))
    print(summary(fit_FRA[[i]]))
    cat("\n")
  }else{
    "Not glm object"
  }
}



# plot fit objects
for(i in 1:length(fit_FRA)){

  if(length(fit_FRA[[i]]) > 1){
    print(paste0("###### Plot for ", link_fun[i], " ######"))
    print(autoplot(fit_FRA[[i]]))
  }
}


# Kolmogorov-Smirnov test
ks.test(tidyFRA$Year, tidyFRA$Area)
ks.test(tidyFRA$Month, tidyFRA$Area)

