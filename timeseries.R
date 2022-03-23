library(dplyr)
library(readr)
library(ggplot2)
library(leaflet)
library(plotly)


essex_0121 <- readr::read_csv(unz("Essex.zip", "2021-01/2021-01-essex-street.csv"))
essex_0221 <- readr::read_csv(unz("Essex.zip", "2021-02/2021-02-essex-street.csv"))
essex_0321 <- readr::read_csv(unz("Essex.zip", "2021-03/2021-03-essex-street.csv"))
essex_0421 <- readr::read_csv(unz("Essex.zip", "2021-04/2021-04-essex-street.csv"))
essex_0521 <- readr::read_csv(unz("Essex.zip", "2021-05/2021-05-essex-street.csv"))
essex_0621 <- readr::read_csv(unz("Essex.zip", "2021-06/2021-06-essex-street.csv"))
essex_0721 <- readr::read_csv(unz("Essex.zip", "2021-07/2021-07-essex-street.csv"))
essex_0821 <- readr::read_csv(unz("Essex.zip", "2021-08/2021-08-essex-street.csv"))
essex_0921 <- readr::read_csv(unz("Essex.zip", "2021-09/2021-09-essex-street.csv"))
essex_1021 <- readr::read_csv(unz("Essex.zip", "2021-10/2021-10-essex-street.csv"))
essex_1121 <- readr::read_csv(unz("Essex.zip", "2021-11/2021-11-essex-street.csv"))
essex_1221 <- readr::read_csv(unz("Essex.zip", "2021-12/2021-12-essex-street.csv"))
essex_0122 <- readr::read_csv(unz("Essex.zip", "2022-01/2022-01-essex-street.csv"))

essex <- rbind(essex_0121, essex_0221, essex_0321, essex_0421,
               essex_0521, essex_0621, essex_0721, essex_0821,
               essex_0921, essex_1021, essex_1121, essex_1221,
               essex_0122)

rm(essex_0121, essex_0221, essex_0321, essex_0421,
      essex_0521, essex_0621, essex_0721, essex_0821,
      essex_0921, essex_1021, essex_1121, essex_1221,
      essex_0122)

essex_totals <- essex %>%
  filter(complete.cases(`Crime ID`)) %>%
  group_by(Month, `Crime type`) %>%
  summarise(total = n())

p <- ggplot(essex_totals, aes(x = Month, y = total, group = `Crime type`)) +
  geom_line(aes(colour = `Crime type`)) +
  theme(panel.background = element_blank(),
        legend.position = "bottom")

ggplotly(p)
