# Install required packages
install.packages("tidyverse")
install.packages("lubridate")
install.packages("ggplot2")

library(tidyverse)  
library(lubridate)  
library(ggplot2)

#sets working directory to call to data
getwd() 
setwd("C:/Users/felon/Documents")

# Upload Divvy datasets (csv files)
m_202205<- read_csv("202205-divvy-tripdata.csv")
m_202206<- read_csv("202206-divvy-tripdata.csv")
m_202207<- read_csv("202207-divvy-tripdata.csv")
m_202208<- read_csv("202208-divvy-tripdata.csv")
m_202209<- read_csv("202209-divvy-publictripdata.csv")
m_202210<- read_csv("202210-divvy-tripdata.csv")
m_202211<- read_csv("202211-divvy-tripdata.csv")
m_202212<- read_csv("202212-divvy-tripdata.csv")
m_202301<- read_csv("202301-divvy-tripdata.csv")
m_202302<- read_csv("202302-divvy-tripdata.csv")
m_202303<- read_csv("202303-divvy-tripdata.csv")
m_202304<- read_csv("202304-divvy-tripdata.csv")


# Inspect the dataframes and look for incongruencies
str(m_202205)
str(m_202206)
str(m_202207)
str(m_202208)
str(m_202209)
str(m_202210)
str(m_202211)
str(m_202212)
str(m_202301)
str(m_202302)
str(m_202303)
str(m_202304)

# Convert started_at  and ended_at to datetime so that they can stack correctly
m_202205 <- m_202205 %>% 
  mutate(started_at = dmy_hm(started_at),
         ended_at = dmy_hm(ended_at))

# Stack individual month's data frames into one big data frame
all_trips <- bind_rows(m_202205, m_202206, m_202207, m_202208, m_202209, m_202210, m_202211,
                       m_202212, m_202301, m_202302, m_202303, m_202304)

# Remove lat, long 
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng))



# Inspect the new table that has been created
colnames(all_trips)  #List of column names
nrow(all_trips)  #How many rows are in data frame?
dim(all_trips)  #Dimensions of the data frame?
head(all_trips)  #See the first 6 rows of data frame.
str(all_trips)  #See list of columns and data types (numeric, character, etc)
summary(all_trips)  #Statistical summary of data

# Add columns that list the date, month, day, and year of each ride
all_trips$date <- as.Date(all_trips$started_at)
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$year <- format(as.Date(all_trips$date), "%Y")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")

# Add a "ride_length" calculation to all_trips (in seconds)
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)

str(all_trips)

# Convert "ride_length" from Factor to numeric so we can run calculations on the data
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
is.numeric(all_trips$ride_length)

# Remove "bad" data
# The dataframe includes a few hundred entries when ride_length was negative
all_trips_v2 <- all_trips[!(all_trips$ride_length < 0), ]


# Descriptive analysis on ride_length (all figures in seconds)
summary(all_trips_v2$ride_length)

# Compare members and casual users
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)

# See the average ride time by each day for members vs casual users
all_trips_v2$day_of_week <- ordered(all_trips_v2$day_of_week, 
                                    levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual 
          + all_trips_v2$day_of_week, FUN = mean)
  
all_trips_v2 <- all_trips %>%
  mutate(weekday = wday(started_at, label = TRUE)) %>% #creates weekday field using wday()
  group_by(member_casual, weekday) %>%
  summarise(number_of_rides = n(),    # Calculates the number of rides
            average_duration = mean(ride_length)) %>%   # Calculates the average duration
  arrange(member_casual, weekday)


# a visualization for the number of rides by rider type
all_trips_v2 %>%
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.6) +  # Adjust the width of the columns
  labs(x = "Weekday", y = "Number of Rides") +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() +  # Apply a minimalistic theme
  scale_fill_manual(values = c("member" = "#4C8BF5", "casual" = "#F56E4C")) +
  theme(plot.title = element_text(size = 16, face = "bold"),  # Increase the title size and make it bold
        plot.subtitle = element_text(size = 12),  # Adjust the subtitle size
        axis.text = element_text(size = 10),  # Adjust the axis label size
        legend.title = element_blank(),  # Remove the legend title
        legend.text = element_text(size = 10)) +  # Adjust the legend label size
  ggtitle("Number of Rides by Weekday") +  # Add a title
  labs(fill = "User Type") +  # Adjust the legend label
  guides(fill = guide_legend(override.aes = list(shape = 21, size = 5)))  # Change the legend shape and size


# a visualization for average duration
all_trips_v2 %>%
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge", width = 0.6) +
  labs(x = "Weekday", y = "Average Duration (in seconds)") +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() +
  theme(plot.title = element_text(size = 16, face = "bold"),
        plot.subtitle = element_text(size = 12),
        axis.text = element_text(size = 10),
        legend.title = element_blank(),
        legend.text = element_text(size = 10)) +
  ggtitle("Average Ride Duration by Weekday") +
  labs(fill = "User Type") +
  guides(fill = guide_legend(override.aes = list(shape = 21, size = 5))) +
  geom_text(aes(label = round(average_duration, 2)), position = position_dodge(width = 0.6), vjust = -0.5, size = 3, color = "Black") +
  scale_fill_manual(values = c("member" = "#4C8BF5", "casual" = "#F56E4C")) +
  theme(plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
        plot.subtitle = element_text(size = 14, hjust = 0.5),
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        legend.position = "bottom",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank())

