# Load data
data <- read.csv('/Spotify_analysis_with_R/spotify-2023.csv')

# Display first few rows
head(data)

# Display columns and structure
str(data)

# Summary of data
summary(data)

# Convert column datatypes
# Remove commas and convert to numeric
data$streams <- as.numeric(gsub(",", "", data$streams))

# Check rows with NA values in streams
na_rows <- data[is.na(data$streams), ]
print(na_rows)

# Remove rows with NA values in streams
data <- data[!is.na(data$streams), ]

# Confirm if NA values are removed
sum(is.na(data$streams))

# Convert in_deezer_playlists and in_shazam_charts to numeric
data$in_deezer_playlists <- as.numeric(data$in_deezer_playlists)
data$in_shazam_charts <- as.numeric(data$in_shazam_charts)

# Check for introduced NA values in any column
na_check <- sapply(data, function(x) sum(is.na(x)))
print(na_check)

# Remove rows with any NA values
data <- data[complete.cases(data), ]

# Confirm no NA values
sum(is.na(data))

# Exploratory Data Analysis (EDA)
# Univariate analysis for numerical variables
hist(data$streams, breaks = 20,
     main = "Streams Distribution",
     col = "skyblue", xlab = "Streams")

boxplot(data$streams, main = "Boxplot of Streams",
        col = "coral")

# Categorical Variables
table(data$key)  # Frequency table for 'key'
barplot(table(data$key), main = "Distribution of Key", 
        col = "lightgreen",
        xlab = "Key",
        ylab = "Count")

# Bivariate analysis
plot(data$streams, data$energy_, main = "Streams vs Energy",
     xlab = "Streams", ylab = "Energy", col = "blue")

# Correlation matrix for selected numerical variables
numeric_vars <- data[, c("streams", "danceability_.", "valence_.", "energy_.")]
cor_matrix <- cor(numeric_vars, use = "complete.obs")
print(cor_matrix)

# Visualize using heatmap
library(corrplot)
corrplot(cor_matrix, method = "color")

# Streams by key
boxplot(data$streams ~ data$key, main = "Streams by Key",
        xlab = "Key",
        ylab = "Streams",
        col = "lightblue")

# Multivariate analysis
library(GGally)
ggpairs(data[, c("streams", "bpm", "danceability_.", "energy_.")])

# Group-wise aggregation
# An artist and their total streams
library(dplyr)
top_artists <- data %>%
  group_by(artist.s._name) %>%
  summarise(total_streams = sum(streams, na.rm = TRUE)) %>%
  arrange(desc(total_streams)) %>%
  head(10)

print(top_artists)
# Outliers detection
boxplot(data$streams,
        main = "Boxplot of Streams",
        col = "lightpink",
        horizontal = TRUE)

