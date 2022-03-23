library(dplyr)
library(readr)
library(ggplot2)
library(leaflet)

getwd()
unzip("Jan22.zip")
outcomes <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-outcomes.csv"))
ss <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-stop-and-search.csv"))
street <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-street.csv"))

# Remove NULL crime IDs
outcomes <- outcomes %>% filter(complete.cases(`Crime ID`))
street <- street %>% filter(complete.cases(`Crime ID`))

join <- outcomes %>%
  dplyr::left_join(street, by = "Crime ID") %>%
  filter(complete.cases(`Crime type`))

## Broke down by crime type and outcome type
offence_types <- join %>%
  filter(complete.cases(`Crime type`)) %>%
  group_by(`Crime type`, `Outcome type`) %>%
  summarise(total = n())

## Created facet plot
ggplot(data = join, aes(x = `Outcome type`, fill = `Outcome type`)) +
  geom_bar(stat = "count") +
  labs(title = "Number of suspect with dfferent outcomes",
       subtitle = "(Broken down by offence type)",
       y = "Number of suspects", x = "") + 
  facet_wrap(~ `Crime type`)  +
  theme(
    axis.text.x  = element_blank()
  )


## Map
r_birthplace_map <- leaflet() %>%
  addTiles() %>%  # use the default base map which is OpenStreetMap tiles
  addMarkers(lng=street$Longitude, lat=street$Latitude,
             popup="The birthplace of R")
r_birthplace_map
