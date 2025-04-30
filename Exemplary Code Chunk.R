# Exemplary Code Chunk----------------------------------------------------------
# Reason:
# Use tidyverse conventions
# USe filter for missing values, select by region, and construct new variables
# Visualization, color-customized, minimalistic, and annotated with statistical significance

#Code:--------------------------------------------------------------------------------
# Load packages
library(tidyverse)

# Read data
greenspace_data <- read.csv("greenspace_data_share.csv", encoding = "latin1")

# Focus on South Asia
south_asia <- c("Afghanistan", "Bangladesh", "Bhutan", "India", 
                "Maldives", "Nepal", "Pakistan", "Sri Lanka")

greenspace_sa <- greenspace_data %>%
  filter(Country %in% south_asia) %>%
  filter(!is.na(annual_avg_2021), !is.na(HDI_level))

# Run ANOVA to test greenspace differences by HDI
anova_result <- aov(annual_avg_2021 ~ HDI_level, data = greenspace_sa)
anova_summary <- summary(anova_result)
p_value <- anova_summary[[1]]["Pr(>F)"][1, 1]
p_text <- ifelse(p_value < 0.001, "p < 0.001", paste0("p = ", round(p_value, 3)))

# Visualize with boxplot
ggplot(greenspace_sa, aes(x = HDI_level, y = annual_avg_2021, fill = HDI_level)) +
  geom_boxplot(show.legend = FALSE, outlier.color = "gray") +
  scale_fill_manual(values = c(
    "Low" = "#c7e9c0",
    "Medium" = "#74c476",
    "High" = "#238b45"
  )) +
  annotate("text", x = 2, y = max(greenspace_sa$annual_avg_2021) + 0.02, 
           label = p_text, size = 4.5, fontface = "italic") +
  labs(
    title = "Urban Greenspace by HDI Level (2021)",
    x = "HDI Level",
    y = "NDVI Score"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )