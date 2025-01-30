#importing libraries
library(ggplot2)
library(tidyverse)
library(pheatmap)
library(viridis)

#seeing datasets
data()

#creating plots from various data

diamonds <- diamonds %>% ggplot(aes(fct_infreq(cut))) +
  geom_bar(fill = "blue", alpha = 0.5) +
  labs(x = "Diamond Cut", y = "Count", title = "Distribution of Diamond Cuts") +
  theme_bw()

DNase <- DNase %>% 
  ggplot(aes(conc, density, colour = Run)) +
  geom_line(size=1) +
  geom_point(alpha=0.5, size=5) +
  labs(title = "Elisa assay of DNase",
       x = "Concentration",
       y ="Density") +
  theme_bw()

PlantGrowth <- PlantGrowth %>% 
  ggplot(aes(group, weight, fill = group)) +
  geom_boxplot(alpha=0.5) +
  labs(x="Group",
       y="Weight",
       title="Results from an Experiment on Plant Growth") +
  theme_bw()

airquality <- airquality %>% 
  drop_na() %>% 
  mutate(Month = gsub( 5 ,"May",Month),
         Month = gsub( 6 ,"June",Month),
         Month = gsub( 7 ,"July",Month),
         Month = gsub( 8 ,"August",Month),
         Month = gsub( 9 ,"September",Month)) %>% 
         ggplot(aes(Ozone, Solar.R) ) +
         geom_point(alpha= 0.7, aes(size=Wind, color=Temp)) +
         geom_smooth(method = lm, se=F) +
         facet_wrap(~Month) +
         labs(x = "Ozone",
              y ="Solar radiation",
              title = "New York Air Quality Measurements") +
         theme_bw()

#calculating the correlation and creating the heatmap
correlation <- cor(mtcars)
corrr <- pheatmap(correlation, 
         color = viridis(100), 
         display_numbers = TRUE,
         main = "Correlation Matrix") 

#save plots
png("airquality.png", width = 2400, height = 1600, res = 360)
airquality
dev.off()

png("corrr.png", width = 2400, height = 1600, res = 360)
corrr
dev.off()

png("DNase.png", width = 2400, height = 1600, res = 360)
DNase
dev.off()

png("PlantGrowth.png", width = 2400, height = 1600, res = 360)
PlantGrowth
dev.off()

png("diamonds.png", width = 2400, height = 1600, res = 360)
diamonds
dev.off()
