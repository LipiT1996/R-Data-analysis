#set the directory path
setwd("~/Desktop/Core Bioinformatics/scripts")

#loading the libraries
library(tidyverse)
library(ggplot2)

#creating a bar plot
data_long %>% #loading the data
  filter(gene == 'BRCA1') %>% #filtering the data
  ggplot(., aes(x= samples, y = FPKM, fill = tissue)) + #variables for the plot
  geom_col() #type of plot
  
#density plot
data_long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = FPKM, fill = tissue)) + 
  geom_density(alpha = 0.3)

# box-plot
data_long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = metastasis, y = FPKM)) +
  geom_boxplot()

#violin plot    
data_long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = metastasis, y = FPKM)) +
  geom_violin()

#scatter plot- expression between two genes
data_long %>%
  filter(gene == 'BRCA1'| gene == 'BRCA2') %>%
  spread(key = gene, value = FPKM) %>%
  ggplot(., aes(x = BRCA1, y = BRCA2, color = tissue)) + 
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

#heat-maps
# pdf('heatmap_2.pdf', width = 10, height = 8)
gene_of_interest <- c('BRCA1', 'BRCA2', 'TP53', 'ALK', 'MYCN')

p <- data_long %>%
  filter(gene %in% gene_of_interest) %>%
  ggplot(., aes(x= samples, y = gene, fill = FPKM)) +
  geom_tile() +
  scale_fill_gradient(low = 'white', high = 'red')
#dev.off()

ggsave(p, filename = 'head_map.pdf', width = 10, height = 8)

