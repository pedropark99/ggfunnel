library(hexSticker)
devtools::load_all()


funnel(user_events, levels = Event, values = Event, stat = "count")


user_events |>
  group_by(Event) |>
  dplyr::count(Event)
