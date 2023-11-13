# DataCleaner

> "Information is the oil of the 21st century, and analytics is the combustion engine."  
> — Peter Sondergaard (Gartner IT Symposium/Xpo, October 2011).

The intelligent collection, cleaning, processing and visualization of data is an indispensable process for the efficient, precise, productive and sharp **self-criticism** of any project.

This project seeks to be a compendium of best practices for effective data cleaning in R for analysis or formal visualization.

## Current options

### Column manipulation
```R
dataset <- select(dataset, column1, column2, column3, column4, column5,
                  column6, column7, column8)

colnames(dataset) <- c("ColumnName1", "ColumnName2", "ColumnName3",
                       "ColumnName4", "ColumnName5", "ColumnName6",
                       "ColumnName7", "ColumnName8")

```

### Filtering
```R
levels(factor(dataset$ColumnName1))

levels(factor(dataset$ColumnName2))

dataset <- dataset[(dataset$ColumnName1 == "Only this here")
                   & (dataset$ColumnName2 %in% c("We want this", "This too")),]
```

### Timezones to POSIXct format

```R
# Example: Having a UTC timestamp like this 2021-07-13T15:00:05.7020736Z
#                                           123456.....................28

dataset$DateUTC <- substr(dataset$TimestampColumn, 1, 10)

dataset$TimeUTC <- substr(dataset$TimestampColumn, 12, 19)

dataset$DateTimeUTC <- paste(dataset$DateUTC,dataset$TimeUTC, sep = ' ')

dataset$DateTimeUTC <- as.POSIXct(dataset$DateTimeUTC, tz = "UTC")

class(dataset$DateTimeUTC) # The result must be "POSIXct" and "POSIXt"

# In this example the difference between UTC and Monterrey MX
# is -5 hours, equal to -18000 seconds
dataset$DateTimeLocal <- dataset$DateTimeUTC - 18000

dataset <- select(dataset, DateTimeUTC, DateTimeLocal, ColumnName3, ColumnName4,
                  ColumnName5, ColumnName6, ColumnName7, ColumnName8)
```

### URL Domains

```R
# * Get the unique entries to find out how many different domains there are

unique(dataset$ColumnNameX)

# * It's TRUE when a column result has the URL we want to simplify

dataset$ColumnNameX <- case_when(
  str_detect(dataset$ColumnNameX, "urldomain1") ~ "ReadableDomainName1",
  str_detect(dataset$ColumnNameX, "urldomain2") ~ "ReadableDomainName2",
  str_detect(dataset$ColumnNameX, "urldomain3") ~ "ReadableDomainName3",
  str_detect(dataset$ColumnNameX, "urldomain4") ~ "ReadableDomainName4",
  str_detect(dataset$ColumnNameX, "urldomain5") ~ "ReadableDomainName5",
  TRUE ~ dataset$ColumnNameX
)

# * Verify that each URL is simplified to their domain name

unique(dataset$ColumnNameX)
```

## Future work

- Local UX/UI.
- Connection with SQL Databases.
- Connection to GPT API key to uniformly simplify qualitative data.

## Contact

Feel free to reach out if you have any questions or feedback.

- **Email:** victorbenitogr@gmail.com
- **The subject must start with:**  [DataCleaner]