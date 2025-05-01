# Portfolio
# Introduction
This portfolio showcases the skills I’ve developed over the semester in data cleaning, analysis, and visualization using R and RMarkdown. It includes four key deliverables that represent different aspects of my learning and growth in this course:
- Polished slides 
- Polished research poster 
- Exemplary code chunk 
- Analyst resume
I write on detail the changes I made in each of the above deliverables based on feedback in detail below.

# Polished Slide Deck: Revisions Made Based on Feedback
For my in-class slide presentation, I presented findings using the Global Greenspace Indicator Dataset by Stowell, J. (2023). After presenting, I received valuable feedback from both the professor and classmates, which helped me identify areas to strengthen. Based on that, I made the following revisions:
*Added City-Level Analysis: One of the main suggestions was that country-level averages were too broad. So, I added a bar chart highlighting the Top 20 greenest cities. This helped bring out a clearer story—while Sri Lanka had the highest national average, most of the top-ranked green cities were actually in India.
*Simplified and Clarified Slides: I reduced text and visual clutter to make the slides easier to follow. Each slide now centers on one main takeaway or message to keep things clean and direct.
*Combined ANOVA Test and Boxplot: Originally these were on separate slides. I now display the HDI-level boxplot and ANOVA p-value together so the audience can quickly grasp the statistical relationship between HDI and greenspace.
*Added Data Citation: I included a full and properly formatted citation for the dataset to make sure sources are transparent and traceable.

# Polished Research Poster: Revisions Made Based on Feedback
For this poster, I used the dataset by Thomson, Henry, Karim Bahgat, Henrik Urdal, and Halvard Buhaug (2022), titled "Urban Social Disorder 3.0: A global, city-level event dataset of political mobilization and disorder." (Journal of Peace Research, forthcoming). Based on feedback from the professor and classmates, I made the following improvements to strengthen both the analysis and the presentation:
*Added Depth and Context: I rewrote the Introduction and Objective sections to better explain the importance of analyzing violent riots in capital cities. I also clarified the research question to make it more focused and relevant.
*Expanded Analysis Beyond a Single Bar Chart: To go deeper into the data, I added two new visuals line chart showing riot trends over time by city type (capital vs. non-capital) and bar chart of top actors involved in capital city riots. These additions helped bring out patterns that a single bar chart couldn’t capture and showed more thoughtful use of the dataset.
*Displayed Statistical Test Results: I added a clearly formatted chi-squared result table next to the visuals, showing the outcome of the hypothesis test (χ² = 0.23, p = 0.63), making the statistical conclusion easy to follow.
*Fixed Layout and Formatting Issues: I used the patchwork package to stack plots vertically for smoother visual flow. I also added a \columnbreak and adjusted fig.width and fig.height to prevent column overlap issues in the posterdown format.

# Exemplary Code Chunk
The exemplary code chunk comes from my analysis of the Urban Greenspace dataset for my slides, where I examined how NDVI scores vary by HDI level across South Asian cities. i selected this code chunk because it demonstrates all four key learning outcomes of the SIS-750 Data Analysis course: data wrangling, visualization, statistical analysis, and reproducibility. The code filters and prepares a subset of city-level data, applies a one-way ANOVA to test group differences, and produces a clean, customized boxplot using ggplot2. It includes a dynamic annotation of the p-value to clearly communicate statistical significance. The chunk reflects tidyverse conventions, professional visual design, and replicable RMarkdown practices, all in under 40 lines of well-structured, efficient code.

# Analyst Resume
I created my analyst resume using an RMarkdown PDF document, in keeping with the principles of reproducibility and professionalism emphasized in the SIS-750 Data Analysis course. Instead of using a traditional template, I wrote and formatted the resume in code to reflect the same workflow used in my project deliverables. The resume highlights my hands-on experience with R, data wrangling, and statistical visualization. It includes key projects from the course, such as my research poster using the Urban Social Disorder dataset and my slide deck on greenspace inequality in South Asia and documents how I applied statistical methods like chi-squared tests and ANOVA. Coming from a non-technical background, I used this resume to reflect not only the skills I've gained, but also my growth in confidence as a junior analyst. It positions me for data-facing roles in the development field, where I can continue asking meaningful questions and telling data-driven stories clearly and effectively.

This portfolio represents the most meaningful transformation I’ve had this semester, from someone who didn’t see herself as a working in R to someone who now feels confident exploring, analyzing, and presenting data using R. Through this course, I’ve not only developed technical skills in data wrangling, visualization, and statistical analysis, but also learned how to communicate insights clearly and professionally. Thank you




