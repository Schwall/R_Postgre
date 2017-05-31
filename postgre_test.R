

#postgre test

library(RPostgreSQL)

# loads the PostgreSQL driver
drv <- dbDriver("PostgreSQL")


pw <- {
  "xxx"
}

# creates a connection to the postgres database
# note that "con" will be used later in each connection to the database
con <- dbConnect(drv, dbname = "R_test_DB",
                 host = "localhost", port = 5432,
                 user = "Alexander", password = pw)






df <- data.frame(num_data1 = c(1,3,5,7,9,1 ),
                 num_data2 = c(2,4,6,8,1,1),
                 group_memb = c("green", "green", "blue", "blue", "red", "red"))

dbWriteTable(con, "R_test_table",
             value = df, append = T, row.names = FALSE)


# query the data from postgreSQL 
dbGetQuery(conn = con, statement =  'SELECT group_memb FROM "R_test_table" ')

#Assign results from SQL query to new R object (dbinR)
dbinR <- dbGetQuery(conn = con, statement =  'SELECT * FROM "R_test_table" ')

# do stuff in R (in our case these would be many 100 lines of code)
dbinR$new_column <- with(dbinR, num_data1 + num_data2)

#output the data in new table or append table
dbWriteTable(con, "R_test_table_new",
             value = dbinR, append = T, row.names = TRUE)

