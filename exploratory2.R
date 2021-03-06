# Load libraries
library(ggplot2)

# File with # of ratings/user
fileNameRatingsPerUser <- "./data/nratings.csv"

ratings <- read.csv(fileNameRatingsPerUser, 
                     header = TRUE, col.names = c("nratings", "id_user"), 
                     colClasses = c("integer", "integer"), 
                     comment.char = "", na.strings = "N/A")

# Histogram of ratings/user
h <- qplot(ratings$nratings, 
           geom="histogram", 
           binwidth = 10,  
           main = "User-Review degree distribution", 
           xlab = "Degree (reviews per user)",
           ylab = "# of users",
           fill=I("blue"), 
           col=I("red"), 
           alpha=I(.2),
           xlim=c(0,1500))
h <- h + theme(plot.title = element_text(lineheight=.8, face="bold", size = 16))
h

ggsave(file="user-review-degree.png")
# hist(ratings$nratings)

mean(ratings$nratings) # 209.252


# # of Ratings/movie
fileNameCleaned <- "./data/movie_titles_clean.txt"

movies <- read.csv2(fileNameCleaned, 
                    header = FALSE, col.names = c("id", "year", "title", "director",
                                                  "genre", "language", "country"), 
                    colClasses = c("integer", "character", "character", "factor", 
                                   "character", "character", "character"), 
                    comment.char = "", na.strings = "N/A")

# Movies rating files
file.names<-paste0('data/training_set/mv_',sprintf('%07d',movies$id),'.txt')

# Number of lines per file, the minus 1 is because the first line is for
# the movie id
nRowsMoviesFiles <- sapply( file.names, function(f){length(count.fields(f)) - 1} )

# Histogram of ratings/movie
h <- qplot(nRowsMoviesFiles, 
           geom="histogram", 
           binwidth = 100,  
           main = "Movie-Review degree distribution", 
           xlab = "Degree (reviews per movie)",
           ylab = "# of movies",
           fill=I("blue"), 
           col=I("red"), 
           alpha=I(.2),
           xlim=c(0,10000))
h <- h + theme(plot.title = element_text(lineheight=.8, face="bold", size = 16))
h

ggsave(file="movie-review-degree.png")

mean(nRowsMoviesFiles) # 5654.502
