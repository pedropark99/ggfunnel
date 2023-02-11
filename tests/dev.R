devtools::load_all()
library(ggplot2)



plot <- ggfunnel::aggregates |>
  ggfunnel::funnel(
    values = N_users, levels = Step
  )

print(plot)
