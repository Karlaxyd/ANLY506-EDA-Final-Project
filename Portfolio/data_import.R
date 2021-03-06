## R for data science 

#11.2.2 Exercises

#1. What function would you use to read a file where fields were separated with “|”?

read_delim(file, delim = "|")

#2. Apart from file, skip, and comment, what other arguments do read_csv() and read_tsv() have in common?

intersect(names(formals(read_csv)), names(formals(read_tsv)))

#3. What are the most important arguments to read_fwf()?

fwf_widths() 
fwf_positions()

#4. Sometimes strings in a CSV file contain commas. To prevent them from causing problems they need to be surrounded by a quoting character, like " or '. By convention, read_csv() assumes that the quoting character will be ", and if you want to change it you’ll need to use read_delim() instead. What arguments do you need to specify to read the following text into a data frame?
#"x,y\n1,'a,b'"

read_delim("x,y\n1,'a,b'",
           ",", quote = "'")
read_csv("x,y\n1,'a,b'",
         quote = "'")

#5. Identify what is wrong with each of the following inline CSV files. What happens when you run the code?

#read_csv("a,b\n1,2,3\n4,5,6")
#Warning: parsing failures
#The first vector has different amount of elements from the secound vector and the third vector.

#read_csv("a,b,c\n1,2\n1,2,3,4")
#Warning: parsing failures
#The three vectors have different amount of elements.

#read_csv("a,b\n\"1")
#Warning: parsing failures
#Data content in not clear. The second line only includes 1 element.

#read_csv("a,b\n1,2\na,b")
#Nothing's wrong with this line of code.

#read_csv("a;b\n1;3")
#This data is ; dilimited, so use read_csv2 is a better choice.
read_csv2("a;b\n1;3")

##11.3.5

#1. What are the most important arguments to locale()?
#date_names  to set the language of day and month names 
#date_format & time_format  to set the date and time formats
#decimal_mark & grouping_mark  to set the symbols used to indicate the decimal place and to chunk larger numbers
#tz  to set time zome 
#encoding  to set encoding 

#2. What happens if you try and set decimal_mark and grouping_mark to the same character? What happens to the default value of grouping_mark when you set decimal_mark to “,”? What happens to the default value of decimal_mark when you set the grouping_mark to “.”?
#If the decimal and grouping marks are set to the same character, 'locale' throws an error
parse_number("123.456,789", locale = locale(decimal_mark = ",", grouping_mark = ","))
#If the 'decimal_mark' is set to the comma, then the grouping mark is set to the period
parse_number("123.456,789", locale = locale(decimal_mark = ","))
#If the grouping mark is set to a period, then the decimal mark is set to a comma
parse_number("123.456,789", locale = locale(grouping_mark = "."))

#3. I didn’t discuss the date_format and time_format options to locale(). What do they do? Construct an example that shows when they might be useful.
#date_format & time_format are used to set the date and time formats
#They set the default date/time formats, which are based on the 'ISO8601' format of yyyy-mm-dd hh-mm-ss. You can override that default by specifying the `locale` argument with new defaults.
#And they can be put in a locale object and become the basic setting of that locale object
parse_date("2001-02-06")
parse_date("2001-02-06", locale = locale(date_format = "%Y-%d-%m"))
parse_date("2001-02-06", "%Y-%d-%m")


parse_time("02:00:08")
parse_time("02:00:08", locale = locale(time_format = "%M:%S:%H"))
parse_time("02:00:08", "%M:%S:%H")

#4. If you live outside the US, create a new locale object that encapsulates the settings for the types of file you read most commonly.

china_locale <- locale(date_format = "%m/%d/%Y")
parse_date("04/02/2019", locale = china_locale)

#5. What’s the difference between read_csv() and read_csv2()?
#The delimiter. While read_csv sets comma as delimiter, read_csv2 sets semi-colon as delimiter.

#6. What are the most common encodings used in Europe? What are the most common encodings used in Asia? Do some googling to find out.
#To find a list of encodings: 
?stringi::stri_enc_detect()
#-   Western European Latin script languages: ISO-8859-1, Windows-1250 (also CP-1250 for code-point)
#-   Eastern European Latin script languages: ISO-8859-2, Windows-1252
#-   Greek: ISO-8859-7
#-   Turkish: ISO-8859-9, Windows-1254
#-   Hebrew: ISO-8859-8, IBM424, Windows 1255
#-   Russian: Windows 1251
#-   Japanese: Shift JIS, ISO-2022-JP, EUC-JP
#-   Korean: ISO-2022-KR, EUC-KR
#-   Chinese: GB18030, ISO-2022-CN (Simplified), Big5 (Traditional)
#-   Arabic: ISO-8859-6, IBM420, Windows 1256

#7. Generate the correct format string to parse each of the following dates and times:

d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014
t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1, "%B %d, %Y")
parse_date(d2, "%Y-%b-%d")
parse_date(d3, "%d-%b-%Y")
parse_date(d4, "%B %d (%Y)")
parse_date(d5, "%m/%d/%y")
parse_time(t1, "%H%M")
parse_time(t2, "%I:%M:%OS %p")
#t2 uses real seconds