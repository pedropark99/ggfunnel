devtools::load_all()
library(ggplot2)

a <- ggfunnel::intermediate |>
  ggfunnel::ggfunnel(
    values = Counts, levels = Step
  ) |>
  ggfunnel::geom_funnel() |>
  theme_funnel(
    theme(
      panel.background = element_rect(fill = "#eb4034")
    )
  ) |>
  geom_text_funnel()


print(a)

#
# base <- ggfunnel::aggregates |>
#   ggplot2::ggplot(
#     ggplot2::aes(
#       x = 0,
#       y = reorder(N_users, N_users / max(N_users)),
#       width = N_users / max(N_users))
#   )
#
# geom <- ggplot2::geom_tile(width = 0.8)
# base + geom
