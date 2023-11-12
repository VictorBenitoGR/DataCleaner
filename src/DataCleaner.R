# = = = = = = = = = = = = = = = = = = = = = = =
# DataCleaner
# https://github.com/VictorBenitoGR/DataCleaner
# = = = = = = = = = = = = = = = = = = = = = = =

# === PACKAGES === ------------------------------------------------------------

# install.packages("PackageName")

library("dplyr") # Data manipulation/transformation

library("openxlsx") # Reading/writing/editing excel files

library("stringr") # Strings (text) manipulation


# === FILE === ----------------------------------------------------------------

getwd() # Change Working Directory with setwd("/path/to/DataCleaner") if needed

dataset <- read.csv("data/dataset.csv") # Change according to your file name

# datasetTest <- head(dataset,1000) # View without loading the entire db

str(dataset) # Quick overview of the general structure


# === COLUMN NAMES === --------------------------------------------------------

# /// Analyze the clarity of the column names

names(dataset)

# /// Select/reorder the relevant columns after select(dataset,___,___,___)

dataset <- select(dataset, column1, column2, column3, column4, column5,
                  column6, column7, column8)

# /// Rename column names

colnames(dataset) <- c("ColumnName1", "ColumnName2", "ColumnName3",
                       "ColumnName4", "ColumnName5", "ColumnName6",
                       "ColumnName7", "ColumnName8")


# === FITLER === --------------------------------------------------------------

# /// See the unique entries in each column

levels(factor(dataset$ColumnName1))

levels(factor(dataset$ColumnName2))

# /// Write here the entries you want to keep, the rest will be omitted

dataset <- dataset[(dataset$ColumnName1 == "Only this here")
                   & (dataset$ColumnName2 %in% c("We want this", "This too")),]


# === DATES AND TIME === ------------------------------------------------------

# /// Redo date and time columns

# Example: Having a UTC timestamp like this 2021-07-13T15:00:05.7020736Z
#                                           123456.....................28

dataset$DateUTC <- substr(dataset$TimestampColumn, 1, 10)

dataset$TimeUTC <- substr(dataset$TimestampColumn, 12, 19)

dataset$DateTimeUTC <- paste(dataset$DateUTC,dataset$TimeUTC, sep = ' ')

dataset$DateTimeUTC <- as.POSIXct(dataset$DateTimeUTC, tz = "UTC")

class(dataset$DateTimeUTC) # The result must be "POSIXct" and "POSIXt"

# /// Get local time

# In this example the difference between UTC and Monterrey MX
# is -5 hours, equal to -18000 seconds
dataset$DateTimeLocal <- dataset$DateTimeUTC - 18000

# /// Select/reorder the relevant columns after select(dataset,___,___,___)

dataset <- select(dataset, DateTimeUTC, DateTimeLocal, ColumnName3, ColumnName4,
                  ColumnName5, ColumnName6, ColumnName7, ColumnName8)


# === URL DOMAINS === ---------------------------------------------------------

# /// Get the unique entries to find out how many different domains there are

unique(dataset$ColumnNameX)

# /// It's TRUE when a column result has the URL we want to simplify

dataset$ColumnNameX <- case_when(
  str_detect(dataset$ColumnNameX, "urldomain1") ~ "ReadableDomainName1",
  str_detect(dataset$ColumnNameX, "urldomain2") ~ "ReadableDomainName2",
  str_detect(dataset$ColumnNameX, "urldomain3") ~ "ReadableDomainName3",
  str_detect(dataset$ColumnNameX, "urldomain4") ~ "ReadableDomainName4",
  str_detect(dataset$ColumnNameX, "urldomain5") ~ "ReadableDomainName5",
  TRUE ~ dataset$ColumnNameX
)

# /// Verify that each URL is simplified to their domain name

unique(dataset$ColumnNameX)


# === EXPORT === --------------------------------------------------------------

# The file will be exported to the project's "data" folder

write.csv(dataset, "data/CleanDataset.csv", row.names = FALSE)

# Look at it as a dataframe if you want

CleanDataset <- read.csv("data/CleanDataset.csv")


# === DELETE TEST === ---------------------------------------------------------

# /// If you are programming for the official repository, make sure that no
#     generated file is going to be pushed.

# testPath <- "data/CleanDataset.csv"

# if (file.exists(testPath)) {
#   file.remove(testPath)
#   cat("File deleted successfully.\n")
# } else {
#   cat("File does not exist.\n")
# }
