#K script draft one with little to no documentation

#loading libraries
library(plyr)

#importing 2014 hitting data originally from www.baseball-reference.com
nl_2014 <- read.csv("http://people.virginia.edu/~jwa5cz/nl_2014.txt")

#subsetting by pitchers using position number from baseball reference csv
pitchers <- subset(nl_2014, POS == "1")

#reformatting columns to numeric after import
pitchers$H <- as.numeric(as.character(pitchers$H))
pitchers$X2B <- as.numeric(as.character(pitchers$X2B))
pitchers$X3B <- as.numeric(as.character(pitchers$X3B))
pitchers$HR <- as.numeric(as.character(pitchers$HR))


#calculating total bases for each pitcher
pitchers$TB <- (pitchers$H - pitchers$X2B - pitchers$X3B - pitchers$HR) + (pitchers$X2B * 2) + (pitchers$X3B * 3) + (pitchers$HR * 4)

#formatting data to relevant informationg and sorting said data
total.bases <- subset(pitchers, select = c("Name", "Age", "Tm", "TB"))
total.bases <- total.bases[with(total.bases, order(-TB)),]

#printing the file to screen
total.bases

#######
# script to run league

#list of team rosters
team.one.roster = c("Madison Bumgarner", "Travis Wood", "Mike Leake", "Zack Greinke", "Adam Wainwright")
team.two.roster = c("Cole Hamels*", "Jordan Lyles", "Shelby Miller", "Jacob deGrom*", "Tyson Ross") 

#creating teams from rosters and naming them
team.one <- data.frame(team.one.roster)
colnames(team.one) <- c("Name")
team.one$TEAM <- "Lenny"

team.two <- data.frame(team.two.roster)
colnames(team.two) <- c("Name")
team.two$TEAM <- "Carl"

team.one <- merge(team.one, total.bases, by.y = "Name")
team.two <- merge(team.two, total.bases, by.y = "Name")

#populating the league from teams
league <- rbind(team.one, team.two)
league$TEAM <-as.factor(league$TEAM)

# calculating standings based on sum of total bases for each team
standings <- ddply(league, .(TEAM),
                   summarize,
                   score = sum(TB))

standings <- standings[with(standings, order(-score)),]

#printing standings to screen
standings