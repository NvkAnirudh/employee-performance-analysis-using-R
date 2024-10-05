# Sett Absolute path
setwd('/Users/anirudhnuti/Documents/R_projects/employee-performance-analysis')
getwd()

# sourcing the R scripts for required helper functions
source('functions/data_preprocessing.R')
source('requirements.R')

# Read data
df <- read.csv('data/raw/HR_Data.csv')
View(df)

# Check for number of columns
ncol(df)
names(df)

# df dimensions
dim(df)

# Data Cleaning
# - Missing values
colSums(is.na(df)) # There don't seem to be any missing values

# - Rename column names (replace dots with underscores)
colnames(df) <- gsub('\\.','_',colnames(df))

# - Check for duplicate values
df_clean <- df[!duplicated(df), ]
dim(df_clean) # dimensions of cleaned data are same as the raw data, that means there are no duplicate values

# - Remove irrelevant columns
df_clean <- subset(df, select = -c(Over18, Employee_Number, Employee_Count))

# - Convert all character types to factors using dplyr
df_clean <- df_clean %>% mutate_if(is.character, as.factor)

# Check for data types
str(df_clean)

# - Rename specific columns
colnames(df_clean)[which(names(df_clean) == 'CF_age_band')] <- 'Age_Band'
colnames(df_clean)[which(names(df_clean) == 'CF_attrition_label')] <- 'Attrition_Label'

# - Outlier Detection
outlier_flags <- lapply(df_clean, detect_outliers)

outlier_flags_df <- as.data.frame(outlier_flags)

dim(outlier_flags_df)
outlier_summary <- colSums(outlier_flags_df)
outlier_summary

outlier_columns <- names(outlier_summary[outlier_summary > 0])

# - Visualizing outliers
par(mfrow=c(4,3), mar=c(5,4,2,1)) # Setting layout for multiple plots (4 rows, 3 columns) along with the margins

for (col in outlier_columns) {
  boxplot(df_clean[[col]],
          main=col,
          col='lightblue',
          border='black',
          las=2, # Make the axis labels vertical          
          cex.axis = 0.8, # Adjust axis label size
          cex.main = 0.9 # Adjust title size
  )
}

# Standardizing the numerical features
numerical_columns <- names(df_clean)[sapply(df_clean, is.numeric)]

df_standardized <- df_clean %>% mutate_at(vars(one_of(numerical_columns)), ~scale(.))

head(df_standardized)

# - Finally, checking data types of all the variables
str(df_standardized)

