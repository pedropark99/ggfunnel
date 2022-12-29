library(tidyverse)
library(uuid)
steps <- c(
  "Entry",
  "See an item",
  "Add to cart",
  "Close order",
  "Choose payment method",
  "Pay order"
)

probs <- c(
  1, 0.87, 0.32, 0.26, 0.15, 0.1
)

set.seed(40)
userids <- uuid::UUIDgenerate(n = 462)
n <- length(userids)

l_steps <- list()
for(i in seq_along(steps)) {
  step <- steps[[i]]
  prob <- probs[[i]]
  choices <- c(NA_character_, step)
  sample_prob <- c(1 - prob, prob)

  l_steps[[i]] <- sample(choices, size = n, replace = TRUE, prob = sample_prob)
}
names(l_steps) <- steps
l_steps <- as_tibble(l_steps)

dates <- seq.Date(as.Date("2022-10-15"), as.Date("2022-11-12"), by = "day")
dates <- sample(dates, size = n, replace = TRUE)

build_datetime <- function(dates){
  dates <- as.character(dates)
  n <- length(dates)
  hours <- sample(0:23, size = n, replace = TRUE)
  minutes <- sample(0:59, size = n, replace = TRUE)
  seconds <- sample(0:59, size = n, replace = TRUE)

  hours <- if_else(hours < 10, sprintf("0%d", hours), as.character(hours))
  minutes <- if_else(minutes < 10, sprintf("0%d", minutes), as.character(minutes))
  seconds <- if_else(seconds < 10, sprintf("0%d", seconds), as.character(seconds))

  times <- sprintf("%s %s:%s:%s", dates, hours, minutes, seconds)
  lubridate::as_datetime(times)
}




user_events <- tibble(
    Date = dates,
    UserID = userids
  ) |>
  bind_cols(l_steps) |>
  pivot_longer(
    cols = c(-Date, -UserID),
    names_to = "Column",
    values_to = "Event"
  ) |>
  select(-Column) |>
  mutate(
    DatetimeEvent = build_datetime(Date)
  ) |>
  select(
    starts_with("Date"),
    everything()
  ) |>
  filter(!is.na(Event))




usethis::use_data(user_events, overwrite = TRUE)
