# Load required packages
library(readxl)
library(dplyr)
library(ggplot2)
library(janitor)
library(tidyr)
library(forcats)
library(stringr)
library(patchwork)
library(kableExtra)

# Load data
events <- read_excel("events.xlsx")
cities <- read_excel("cities.xlsx")

# Merge datasets
merged_data <- events %>%
  left_join(select(cities, CITY_ID, CAPITAL), by = "CITY_ID")

# Riot counts
riot_data <- merged_data %>% filter(PTYPE == 50)
riot_counts <- riot_data %>%
  count(CAPITAL, name = "Number_of_Riots")

# Plot 1: Bar chart
plot1 <- ggplot(riot_counts, aes(x = CAPITAL, y = Number_of_Riots, fill = CAPITAL)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Organized Violent Riots by Capital Status",
       x = "Capital City", y = "Number of Riots") +
  scale_fill_manual(values = c("Yes" = "#00088B", "No" = "#00BFFF")) +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text.y = element_text(size = 9),
        axis.title = element_text(size = 9), plot.title = element_text(face = "bold", size = 9))

# Plot 2: Top actors
capital_riots <- merged_data %>% filter(PTYPE == 50, CAPITAL == "Yes")
actor_clean <- capital_riots %>%
  select(ACTOR1, ACTOR2, ACTOR3) %>%
  pivot_longer(cols = everything(), names_to = "actor_type", values_to = "actor") %>%
  filter(!is.na(actor), actor != "99") %>%
  mutate(actor = str_to_title(actor),
         actor = case_when(
           str_detect(actor, "Student") ~ "Students",
           str_detect(actor, "Demonstrator") ~ "Demonstrators",
           str_detect(actor, "Protester") ~ "Protesters",
           str_detect(actor, "Police|Security Force") ~ "Security Forces",
           TRUE ~ actor
         )) %>%
  count(actor, sort = TRUE)

top_actor_names <- c("Students", "Demonstrators", "Security Forces", "Protesters")
custom_colors <- c(
  "Students" = "#27408B",
  "Demonstrators" = "#1874CD",
  "Security Forces" = "#00BFFF",
  "Protesters" = "#0000FF"
)

top_cleaned <- actor_clean %>%
  filter(actor %in% top_actor_names) %>%
  mutate(actor = fct_reorder(actor, n))

plot2 <- ggplot(top_cleaned, aes(x = actor, y = n, fill = actor)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_fill_manual(values = custom_colors) +
  labs(title = "Top Actors in Capital City Riots", x = "Actor", y = "Number of Events") +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text.y = element_text(size = 8),
        axis.title = element_text(size = 8), plot.title = element_text(face = "bold", size = 9))

# Plot 3: Riot trends over time
trend_data <- merged_data %>%
  filter(PTYPE == 50, !is.na(BYEAR)) %>%
  group_by(BYEAR, CAPITAL) %>%
  summarise(Riots = n(), .groups = "drop")

plot3 <- ggplot(trend_data, aes(x = BYEAR, y = Riots, color = CAPITAL)) +
  geom_line(size = 1.2) +
  scale_color_manual(values = c("Yes" = "#00088B", "No" = "#00BFFF")) +
  labs(title = "Trends in Violent Riots Over Time", x = "Year", y = "Number of Riots", color = "Capital City") +
  theme_minimal() +
  theme(panel.grid = element_blank(), axis.text = element_text(size = 9),
        axis.title = element_text(size = 9), plot.title = element_text(face = "bold", size = 9))

# Combine plots vertically
combined_plot <- plot1 / plot3 / plot2
combined_plot

# Run chi-squared test again just in case
chi_result <- chisq.test(table(merged_data$CAPITAL, merged_data$riot_event))

# Create summary table
chi_summary <- data.frame(
  `Test Statistic (χ²)` = round(chi_result$statistic, 2),
  `Degrees of Freedom` = chi_result$parameter,
  `p-value` = round(chi_result$p.value, 4)
)

# Display table
kable(chi_summary, caption = "Chi-Squared Test: Capital vs Non-Capital Riot Frequency")
