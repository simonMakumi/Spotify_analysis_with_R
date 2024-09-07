data <- read.csv('/home/simon-makumi/R/Spotify_analysis_with_R/spotify-2023.csv')
# Display first few rows
head(data)

# Display columns
str(data)

# Summary of Spotify data
summary(data)

# Convert column datatypes
# Remove commas and convert to numeric
data$streams <- as.numeric(gsub(",", "", data$streams)) 

# Check rows with NA values
na_rows <- data[is.na(data$streams), ]
print(na_rows)

# Remove NA values
data <- data[!is.na(data$streams), ]

# Confirm if NA values are removed
sum(is.na(data$streams))

# Convert in_deezer_playlists and in_shazam_charts
data$in_deezer_playlists <- as.numeric(data$in_deezer_playlists)
data$in_shazam_charts <- as.numeric(data$in_shazam_charts)

# Check introduced NA
data[is.na(data), ]

# Remove NA values
data <- data[!is.na(data)]

# Confirm no NA values
sum(is.na(data))
