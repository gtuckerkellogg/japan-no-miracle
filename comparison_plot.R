library(readr)
library(lubridate)
library(dplyr)
library(ggplot2)
library(patchwork)

XLIM <- c(min((Japan_data %>% filter(year(date) == 2021))$date),
          max((Japan_data %>% filter(year(date) == 2021))$date))
          


pvisitors <- visitors %>%
  filter(year == 2021) %>%
  ggplot(aes(x=day,y=inbound,group=year)) + 
  xlim(XLIM) + 
  geom_line(lwd=2) + 
  geom_point(size=6) +
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('Inbound visitors to Japan per month in 2021\nSource: Japanese Tourism Board') + 
  xlab('date') + 
  ylab('Inbound visitors per month') + 
  cowplot::theme_cowplot() + 
  annotate("rect", xmin = date("2021-07-24"), xmax = date("2021-08-08"), ymin = -1, ymax = 50000,
           alpha = .1,fill = "blue")


pcases <- Japan_data %>% 
  filter(year(date) == 2021) %>% 
  ggplot(aes(x=date,y=new_cases_smoothed_per_million)) +
  xlim(XLIM) +
  geom_line(lwd=2) + 
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('New cases per million in Japan in 2021\nSource: Our World in Data') + 
  ylab('New cases per million (smoothed)') + 
  cowplot::theme_cowplot() + 
  annotate("rect", xmin = date("2021-07-24"), xmax = date("2021-08-08"), ymin = -1, ymax = 180,
           alpha = .1,fill = "blue")



pvisitors / pcases  / p_vaccinated
