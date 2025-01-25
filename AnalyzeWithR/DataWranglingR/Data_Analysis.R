#import libraries
library(tidyverse)
library(ggplot2)

#loading datasets

tax <- read.delim("otu_taxonomy.txt", header = F, row.names = 1)
otu <- read.delim("otu_table.txt", header = T)


#new columns names and remove brackets in tax dataframe

tax <- tax %>% 
  rename(Size = V2, Taxonomy = V3) %>% 
  mutate(Taxonomy = gsub("\\(.*?\\)", "", Taxonomy))


#seperate Taxonomy column to relavant colummns

tax <- separate(tax, 
         Taxonomy, 
         into = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus"),
         sep = ";") 


#selecting columns in otu dataframe

otu <- select(otu, -label & - numOtus)


#Group column goes to rownames after that remove in dataframe

rownames(otu) <- otu$Group
otu$Group <- NULL

#tranpoze dataframe

otu <- t(otu)

#merge two dataframes

otu.tax <- merge(tax, otu, by = "row.names")


#transforming long format column

otu.tax <- pivot_longer(otu.tax, 
                        cols = c("SRR28401498", "SRR28401501", "SRR28401502", "SRR28401508"),
                        names_to = "Sample_ID",
                        values_to = "Counts")
                        
#rename "Row.names" column name 

otu.tax <- rename(otu.tax, Otu_ID = Row.names)

#selecting factor

otu.tax$Otu_ID <- as.factor(otu.tax$Otu_ID)

#visualization

plot1 <- otu.tax %>% 
  ggplot(aes(Sample_ID, Counts)) +
  geom_bar(aes(fill = Otu_ID), stat = "identity", position = "fill") +
  labs(y = "Relative Abundance", x = "Sample ID") +
  theme_minimal()

#save the plot

png("Relative_Abundance.png", width = 2400, height = 1600, res = 360)
plot1
dev.off()




















