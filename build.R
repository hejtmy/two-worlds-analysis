detach("package:brainvr.R", unload = TRUE)
detach("package:restimoter", unload = TRUE)

install.packages("../brainvr-reader/",  type = "source", repos = NULL)
install.packages("../restimoter/", type = "source", repos = NULL )

library(brainvr.R)
library(restimoter)
