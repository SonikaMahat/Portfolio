# Load packages
library(tidyverse)

# Read the CSV file
greenspace_data <- read.csv("greenspace_data_share.csv", encoding = "latin1")

# Define South Asian countries
south_asia <- c("Afghanistan", "Bangladesh", "Bhutan", "India", 
                "Maldives", "Nepal", "Pakistan", "Sri Lanka")

# Filter to South Asian countries only
greenspace_sa <- greenspace_data %>%
  filter(Country %in% south_asia)

# Remove rows with missing 2021 NDVI values
greenspace_sa <- greenspace_sa %>%
  filter(!is.na(annual_avg_2021))

# Calculate average NDVI for each country (2021)
country_avg <- greenspace_sa %>%
  group_by(Country) %>%
  summarise(mean_ndvi_2021 = mean(annual_avg_2021, na.rm = TRUE)) %>%
  arrange(desc(mean_ndvi_2021))

# Plot: Average NDVI in 2021 by country
ggplot(country_avg, aes(x = reorder(Country, -mean_ndvi_2021), 
                        y = mean_ndvi_2021, 
                        fill = mean_ndvi_2021)) + 
  geom_bar(stat = "identity", width = 0.6, show.legend = FALSE) +
  labs(
    title = "Average Urban Greenspace by Country in South Asia (2021)",
    x = "Country",
    y = "Mean NDVI (2021)"
  ) +
  scale_fill_gradient(low = "#c7e9c0", high = "#006d2c") +  
  expand_limits(y = 0) +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title.y = element_text(margin = margin(r = 10)),
    axis.title.x = element_text(margin = margin(t = 10))
  )
greenspace_sa <- greenspace_sa %>%
  mutate(city_country = paste0(City, " (", Country, ")"))

#top 20 cities of South Asia
top_20 <- greenspace_sa %>%
  arrange(desc(annual_avg_2021)) %>%
  slice_head(n = 20)

custom_colors <- c("India" = "#006d2c",       # dark green
                   "Sri Lanka" = "#a1d99b",
                   "Bangladesh" = "#c7e9c0") 

# Plot: Top 20 Cities with two-shade green scheme
ggplot(top_20, aes(x = reorder(city_country, annual_avg_2021), 
                   y = annual_avg_2021, fill = Country)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(
    title = "Top 20 Cities with Highest Urban Greenspace in South Asia (2021)",
    x = "City (Country)",
    y = "NDVI Score (2021)"
  ) +
  scale_fill_manual(values = custom_colors) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.y = element_text(size = 10),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

# Run ANOVA test
anova_result <- aov(annual_avg_2021 ~ HDI_level, data = greenspace_sa)
anova_summary <- summary(anova_result)

# Extract p-value
p_value <- anova_summary[[1]]["Pr(>F)"][1, 1]
p_text <- ifelse(p_value < 0.001, "p < 0.001", paste0("p = ", round(p_value, 3)))

# Plot with green fill palette
ggplot(greenspace_sa, aes(x = HDI_level, y = annual_avg_2021, fill = HDI_level)) +
  geom_boxplot(show.legend = FALSE, outlier.color = "gray") +
  scale_fill_manual(values = c(
    "Low" = "#c7e9c0",       # light green
    "Medium" = "#74c476",    # medium green
    "High" = "#238b45"       # dark green
  )) +
  labs(
    title = "Distribution of Urban Greenspace by HDI Level (2021)",
    x = "HDI Level",
    y = "NDVI Score"
  ) +
  annotate("text", x = 2, y = max(greenspace_sa$annual_avg_2021) + 0.02, 
           label = p_text, size = 4.5, fontface = "italic") +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )