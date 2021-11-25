library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)


# get data from https://github.com/owid/covid-19-data/tree/master/public/data

Japan_data <- read_csv('data/covid-data.csv') %>% filter(location=='Japan')


olympics <-   annotate("rect", xmin = date("2021-07-24"), xmax = date("2021-08-08"), ymin = -1, ymax = 180,
                      alpha = .1,fill = "blue")


new_case_plot <- Japan_data %>% 
filter(year(date) == 2021) %>% 
  ggplot(aes(x=date,y=new_cases_smoothed_per_million)) +
  geom_line(lwd=2) + 
  geom_point(size=3) + 
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('New cases per million in Japan in 2021\nSource: Our World in Data') + 
  ylab('New cases per million (smoothed)') + 
  cowplot::theme_cowplot() 

# recreate campbell's plot

new_case_plot + xlim(date('2021-06-24'),date('2021-11-22'))

new_case_plot + xlim(date('2021-06-24'),date('2021-11-22')) + olympics


p_vaccinated <- Japan_data %>% 
  filter(year(date) == 2021) %>% 
  ggplot(aes(x=date,y=people_fully_vaccinated_per_hundred)) + 
  geom_line(lwd=2) + 
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('Percentage fully vaccinated\nSource: Our World in Data') + 
  ylab('Percent vaccinated') + 
  cowplot::theme_cowplot() + 
  annotate("rect", xmin = date("2021-07-24"), xmax = date("2021-08-08"), ymin = 0, ymax = 100,
                                                     alpha = .1,fill = "blue")
