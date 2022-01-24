#Library 
library("RSQLite")

#working directory
setwd("~/Desktop/Coding/Data science")

#elements within directory 
dir()

# connecting with database (later you need to disconnect)

# db- data base, dbConnect- connect, 
# dbDriver- with SQLite- connecting database, 
# dbname- name  
# con basis for connection,  
# con <- creating variable 
 
con <- dbConnect(dbDriver("SQLite"), dbname="IMDB_Movies_2021.db")

# disconnecting
dbDisconnect(con)

#saving as CSV 
write.csv(data1, 'IMDB.csv')

## seeing the data ### 

## tables in db 
dbListTables(con) 

# db fields in tables
dbListFields(con, "sqlite_sequence")

###### commands #######

# dbGetQuery(con, "SELECT * FROM table name, SELECT column name FROM table name)

# SELECT COUNT(column name)- counting, SELECT type AS amount FROM type"= AS- new name of column
# SELECT (everything in group by has to be in select, if it's not in group by it needs COUNT(nr), SUM(nr) etc)

# GROUP BY, ORDER BY, 
# SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT 

#orders: LIMIT, ORDER BY, ORDER BY name DESC, ASC
# WHERE- (numbers need > < = or <>) 
# HAVING- x > 5

# "SELECT * FROM name WHERE type = 'name1' AND requires BETWEEN 50 AND 150"- BETWEEN 
# BEWTEEN, NOT IN (100, 40, 1000)"), 
# WHERE LOWER(name), WHERE UPPER(name)
#WHERE TRIM(color) = 'black' ORDER BY type, name")

#table$head

#paste0("!", table$head, "!")

#dbGetQuery(con, "SELECT * FROM table WHERE name LIKE '%black%' ORDER BY type, name")
#dbGetQuery(con, "SELECT * FROM table WHERE name NOT LIKE '%black%' ORDER BY type, name")

#LIKE and NOT LIKE LIKE- lower case etc,

# !- should improve results 
#%name%- any format should work 
# '_z%'- which ever sign _ 
#email: LIKE ;%@%.__' OR  

#"SELECT, COUNT(nr) AS, FROM, GROUP BY, ORDER BY,") AS
# LIMIT 10") 

#(||)-  two columns together. TRIM()- deletes space, ||' '||- adds space 

# reading this: tablename.columnname = tablename2.columnname2  

#- dbGetQuery(con, "SELECT * FROM table, column WHERE tablename.columnname = talbename2.columnname2 LIMIT 10")
# ... LEFT JOIN x ON -both tables added together 
# dbGetQuery(con, "SELECT * FROM table Z LEFT JOIN table2 K ON K.nr = Z.nr1 LIMIT 10") 

# additional aggregating functions: 
dbGetQuery(con, "SELECT TITLE, RATING FROM REVIEWS
                MAX(RATING) AS rating_max,
                SUM(RATING) AS rating_sum,
                AVG(RATING) AS rating_avarage
               GROUP BY RATING, TITLE, 
               ORDER BY RATING")


dbGetQuery(con, "SELECT RATING, TITLE FROM REVIEWS
               WHERE RATING > 1
               ORDER BY RATING
               LIMIT 10")

# column names 
dbGetQuery(con,"SELECT RATING, TITLE FROM REVIEWS 
               WHERE RATING > 2
               ORDER BY RATING")

# word not numeric
dbGetQuery(con, "SELECT RATING, TITLE FROM REVIEWS WHERE RATING = 'creepy'")

# reqirements sorting
dbGetQuery(con, "SELECT RATING, TITLE FROM REVIEWS
               WHERE (RATING > 1) OR (RATING < 3)
               ORDER BY TITLE
               LIMIT 25")

# requirements with AND, (before was OR) 
dbGetQuery(con, "SELECT RATING, TITLE FROM REVIEWS
               WHERE (RATING > 1) AND (RATING < 3)
               ORDER BY TITLE
               LIMIT 25")

# descenting sorting-  ORDER BY requires DESC, othercolumn ASC
# without repetition SELECT DISTINCT 
# SELECT COUNT(*)

# new column name
dbGetQuery(con, "SELECT COUNT(*) AS amount FROM REVIEWS")
dbGetQuery(con, "SELECT RATING AS rating FROM REVIEWS ORDER BY RATING LIMIT 6")

# HAVING > 5
dbGetQuery(con, "SELECT COUNT(*) AS amount FROM REVIEWS
               GROUP BY RATING, TITLE
               HAVING RATING > 8
               ORDER BY RATING
           LIMIT 10")

#: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT 


# >=6 and <=8
#RATING >= 6 AND wymaga <= 8")

# IN and NOT IN
dbGetQuery(con, "SELECT * FROM REVIEWS WHERE RATING IN (5, 6, 7) LIMIT 100")

# TITLE= "deserve"
dbGetQuery(con, "SELECT * FROM REVIEWS WHERE TITLE = 'deserve' ORDER BY TITLE LIMIT 25")

# WHERE TRIM 
dbGetQuery(con, "SELECT * FROM REVIEWS WHERE TRIM(RATING) = '2' ORDER BY RATING, TITLE")

# Good reviews
dbGetQuery(con, "SELECT * FROM REVIEWS WHERE TITLE LIKE '%good%' ORDER BY TITLE, RATING")


# review with second letter d
dbGetQuery(con, "SELECT * FROM REVIEWS WHERE TITLE LIKE '_d%' ORDER BY TITLE LIMIT 25")

# email LIKE '_%@_%.__'

# how many 1-10 rated reviews? 
dbGetQuery(con, "SELECT RATING, COUNT(10) AS number FROM REVIEWS GROUP BY RATING ORDER BY RATING") 

# LOWER
dbGetQuery(con, "SELECT LOWER(REVIEW)
           FROM REVIEWS 
           GROUP BY LOWER(REVIEW) 
           ORDER BY REVIEW
           LIMIT 10")

# only reviews above 8- HAVING
dbGetQuery(con, "SELECT RATING, TITLE 
           FROM REVIEWS GROUP BY RATING, TITLE 
           HAVING RATING > 8 ORDER BY RATING, TITLE
           LIMIT 25")


# (operator ||)-TRIM(.)- deletes spaces, ||' '||- adds spaces
dbGetQuery(con, "SELECT TITLE || AUTHOR AS author FROM REVIEWS LIMIT 10")
dbGetQuery(con, "SELECT AUTHOR, TRIM(TITLE) || ' ' || RATING AS rating FROM REVIEWS LIMIT 10")

# how many ratings
dbGetQuery(con, "SELECT COUNT(RATING) AS number, 
            COUNT(DISTINCT RATING) AS different_ratings
           FROM REVIEWS")

#inna tabelka opiekun
sqlite <- dbReadTable(con, "sqlite_sequence") 
reviews <- dbReadTable(con, "REVIEWS")

# other table 
dbGetQuery(con, "SELECT name FROM sqlite_sequence WHERE name LIKE '%a%' LIMIT 20")

# two tables together
dbGetQuery(con, "SELECT * FROM REVIEWS, sqlite_sequence WHERE REVIEWS.ID = sqlite_sequence.name LIMIT 10")

# two tables together LEFT JOIN
dbGetQuery(con, "SELECT * FROM REVIEWS R LEFT JOIN sqlite_sequence S ON R.ID = S.name LIMIT 10") 

# working on two tables 
dbGetQuery(con, "SELECT R.REVIEW, R.TITLE, R.RATING, S.name
          FROM REVIEWS R LEFT JOIN sqlite_sequence S ON R.ID = S.name
          ORDER BY R.RATING, R.REVIEW, R.TITLE, S.name 
           LIMIT 50") 

# 1st: which data we need (which tables and fields to use)- remember about syntax
# 2nd: 2 tables- use: LEFT JOINT, which columns you need from these tables
# Think about order and sorting the used tables and columns  

# alphabetic order 
dbGetQuery(con, 'SELECT TITLE from REVIEWS ORDER BY TITLE')
dbGetQuery(con, 'SELECT DISTINCT TITLE from REVIEWS ORDER BY TITLE')

#not for this database but other examples: 

# how many animals in each of the cage
dbGetQuery(con, "SELECT K.nr, K.type, COUNT(A.nr) AS animals
           FROM cage K LEFT JOIN animal A ON A.animals = K.nr 
           GROUP BY K.nr, K.type
           ORDER by K.type")

# animal called Ellie
dbGetQuery(con, "SELECT *
           FROM animals
           WHERE name = 'Ellie'")

# ELLIE carrer address
dbGetQuery(con, "SELECT Z.*, OP.surname, OP.address
           FROM animal Z LEFT JOIN
           op O ON Z.cagenumber = O.cagenumber LEFT JOIN
           op OP ON OP.nr = O.opnumber
           WHERE Z.ame = 'Ellie'")

#FIRST: name of fields then FROM and which table then LEFT JOIN another table 
dbGetQuery(con, "SELECT Z.nr, UPPER(Z.name) AS zname, 
           LOWER(Z.type) AS ztype, 
           OP.surname
           FROM animal Z LEFT JOIN
           op O ON Z.cagenr = O.cagenr LEFT JOIN
           op OP ON OP.nr = O.carrernr
           ORDER BY ztype, zname")

# oppie with data regarding cage nr etc from different tables: first oppie, then left join the group and the order 
dbGetQuery(con, "SELECT OP.nr, OP.surname AS oppie, COUNT(Z.nr) AS number
           FROM oppie OP LEFT JOIN
           oppie O ON OP.nr = O.carrernr LEFT JOIN
           animal Z ON Z.cagenr = O.cagenr
           GROUP BY OP.nr, OP.surname
           ORDER BY oppie")

# oppies with animal stats
dbGetQuery(con, "SELECT 
           oppie.nr,
           oppie.surname, 
           COUNT(animal.nr) AS number, 
           MIN(animal.requires) AS min,
           MAX(animal.requires) AS max,
           SUM(animal.requires) AS sum,
           AVG(animal.requires) AS avg
           FROM 
           oppie LEFT JOIN
           care ON care.oopienr = oppie.nr LEFT JOIN
           animal ON animal.cagenr = oppie.cagenr
           GROUP BY oppie.nr, oppie.surname
           ORDER BY oppie.surname")

# HAVING COUNT(O.nrklatki) > 1 order by desc 

#WYKŁAD 6


dbGetQuery(con, "SELECT DISTINCT, 
          COUNT(nr) AS nr,
                MAX(requires) AS 
                SUM(requires) AS 
                AVG(requires) AS
           FROM   LOWER()  LEFT JOIN 
           ON
           WHERE <> LIKE '%i%'  '_%@_%.__
           GROUP BY
           HAVING COUNT <
           ORDER BY nana DESC ASC")

# przerwanie po??czenia z baz? danych
dbDisconnect(con) 
