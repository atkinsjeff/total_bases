#K script draft one with little to no documentation

nl_2014 <- read.csv("http://people.virginia.edu/~jwa5cz/nl_2014.txt")

pitchers <- subset(nl_2014, POS == "1")

pitchers$H <- as.numeric(as.character(pitchers$H))
pitchers$X2B <- as.numeric(as.character(pitchers$X2B))
pitchers$X3B <- as.numeric(as.character(pitchers$X3B))
pitchers$HR <- as.numeric(as.character(pitchers$HR))

pitchers$TB <- (pitchers$H - pitchers$X2B - pitchers$X3B - pitchers$HR) + (pitchers$X2B * 2) + (pitchers$X3B * 3) + (pitchers$HR * 4)
subset(dat, select=c("A", "B"))

total.bases <- subset(pitchers, select = c("Name", "Age", "Tm", "TB"))
total.bases <- total.bases[with(total.bases, order(-TB)),]

total.bases