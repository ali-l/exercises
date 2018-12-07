# https://dev.to/jorinvo/csv-challenge-1al

library("jsonlite")

frames <- fromJSON("https://gist.githubusercontent.com/jorinvo/7f19ce95a9a842956358/raw/e319340c2f6691f9cc8d8cc57ed532b5093e3619/data.json")
frames <- frames[!is.na(frames$creditcard),]
frames <- frames[,c("name","creditcard")]

write.csv(frames, file="20171112.csv", row.names=FALSE)
