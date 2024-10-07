# Read data
df <- read.csv('data/processed/clean_data.csv')

# Let's start with categorical variables
categorical_columns <- names(df)[sapply(df, is.factor)]

categorical_columns
str(df)
