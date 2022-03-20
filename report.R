library(dplyr)
library(readr)
library(ggplot2)

getwd()
unzip("Jan22.zip")
outcomes <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-outcomes.csv"))
ss <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-stop-and-search.csv"))
street <- readr::read_csv(unz("Jan 22.zip", "2022-01/2022-01-thames-valley-street.csv"))

# Remove NULL crime IDs
outcomes <- outcomes %>% filter(complete.cases(`Crime ID`))
street <- street %>% filter(complete.cases(`Crime ID`))

join <- outcomes %>%
  dplyr::left_join(street, by = "Crime ID")

offence_types <- join %>%
  filter(complete.cases(`Crime type`)) %>%
  group_by(`Crime type`, `Outcome type`) %>%
  summarise(total = n())
