library(readxl)
library(lubridate)
library(dplyr)
library(ggplot2)


# Japanese inbound visitor data from https://www.tourism.jp/en/tourism-database/stats/inbound/#monthly

visitors <- read_excel('data/JTM_inbound20211025eng.xlsx',range="A3:C315")


dates <- seq(as.Date('1996-01-01',"%Y-%m-%d"),
    as.Date('2021-12-01',"%Y-%m-%d"),by="month")



visitors$year <- as.ordered(year(dates))
visitors$month <- month(dates,label=TRUE)
visitors$day <- dates - 1

visitors <- select(visitors,year,month,day,`Grand Total`) %>% 
  rename(inbound=`Grand Total`)

visitors

visitors %>%
  filter(year > 2016) %>%
  ggplot(aes(x=month,y=inbound,group=year,color=year)) + 
  geom_line(lwd=2) + 
  geom_point(size=6) +
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('Inbound visitors to Japan per month from 2017-2021\nSource: Japanese Tourism Board') + 
  ylab('Inbound visitors per month') + 
  cowplot::theme_cowplot()
  

visitors %>%
  filter(year == 2021) %>%
  ggplot(aes(x=month,y=inbound,group=year)) + 
  geom_line(lwd=2) + 
  geom_point(size=6) +
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('Inbound visitors to Japan per month in 2021\nSource: Japanese Tourism Board') + 
  ylab('Inbound visitors per month') + 
  cowplot::theme_cowplot()


visitors %>%
  filter(year == 2021) %>%
  ggplot(aes(x=day,y=inbound,group=year)) + 
  geom_line(lwd=2) + 
  geom_point(size=6) +
  scale_color_brewer(type='qual',palette = 'Set2') + 
  ggtitle('Inbound visitors to Japan per month in 2021\nSource: Japanese Tourism Board') + 
  xlab('date') + 
  ylab('Inbound visitors per month') + 
  cowplot::theme_cowplot() + 
  annotate("rect", xmin = date("2021-07-24"), xmax = date("2021-08-08"), ymin = -1, ymax = 50000,
           alpha = .1,fill = "blue")


