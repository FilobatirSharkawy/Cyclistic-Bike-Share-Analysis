# Cyclistic Bike Share Analysis

This project aims to analyze and compare the usage patterns of annual members and casual riders in Cyclistic, a bike-sharing company.

## Contents

1. [Introduction](#introduction)
2. [Data](#data)
3. [Analysis Process](#analysis-process)
4. [Tools and Libraries](#tools-and-libraries)
5. [Project Structure](#project-structure)
6. [Results](#results)
7. [Presentation](#presentation)

## Introduction

Cyclistic is a bike-sharing company that offers its services to both annual members and casual riders. This analysis aims to understand how these two types of users utilize Cyclistic bikes differently. By analyzing the trip data from the previous year, we can gain insights into usage patterns, peak times, trip durations, and more. Understanding these patterns helps in making informed business decisions, improving service, and tailoring marketing strategies.

## Data

The dataset used for this analysis is the Cyclistic trip data, available [here](https://divvy-tripdata.s3.amazonaws.com/index.html). The data includes trip start/end times, trip duration, user types, and other relevant variables. For this project, data from 01/05/2022 to 30/04/2023 was used.

### Data Overview

- **Size**: Large, spanning 12 months.
- **Structure**: Contains columns such as trip_id, start_time, end_time, start_station, end_station, user_type, etc.
- **Preprocessing**: Data cleaning involved handling missing values, correcting inconsistencies, and standardizing date formats.

## Analysis Process

The analysis process consists of the following steps:

1. **Data Collection**: Collect Cyclistic trip data from the previous 12 months.
2. **Initial Data Exploration**: Get a sense of the data distribution and basic statistics.
3. **Data Wrangling**: Clean and preprocess the data, ensuring it is in a suitable format for analysis.
4. **Combine Data**: Merge the cleaned data into a single file for further analysis.
5. **Data Preparation**: Perform additional data cleaning and preparation tasks specific to the analysis.
6. **Descriptive Analysis**: Conduct exploratory analysis to understand the usage patterns and characteristics of annual members and casual riders.
7. **Visualization**: Create visualizations to present the findings and insights from the analysis.

## Tools and Libraries

- **R**: Data manipulation and visualization using libraries like `dplyr` and `ggplot2`.
- **Power BI**: Created dynamic files, including a source and dimension date table. The date table is dynamic based on the actual data, so it can adapt to new data.
- **Excel**: Similar backend as Power BI but with a different dashboard layout.

## Project Structure

This repository contains the following files:

- **(Cyclistic Analysis Dashboard.pbix)**: An Excel file containing detailed analysis and calculations.
- **(Cyclistic Analysis Dashboard (Excel Version).xlsx)**: An Excel file containing detailed analysis and calculations.
- **(R Script.R)**: An R script implementing the entire analysis process, including data collection, wrangling, cleaning, descriptive analysis, and visualization.
- **(presentation.pptx)**: A presentation file summarizing the analysis process, findings, and insights.

## Results

The analysis of the Cyclistic trip data reveals key differences in usage patterns between annual members and casual riders. Key findings include:

- **Peak Usage Hours**: Annual members tend to use bikes more during weekdays, while casual riders prefer weekends.
- **Trip Durations**: Casual riders typically have longer trip durations compared to annual members.

## Presentation

The presentation file provides a concise overview of the analysis process, visualizations, and key insights derived from the Cyclistic trip data. It serves as a summary of the project and can be used to present the findings to stakeholders, potential employers, or interested parties.
