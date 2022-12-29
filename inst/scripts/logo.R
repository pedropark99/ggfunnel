library(hexSticker)
devtools::load_all()


funnel(intermediate, levels = Step, values = Counts, stat = "sum")


user_events |>
  group_by(Event) |>
  dplyr::count(Event)
