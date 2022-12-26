devtools::load_all()

a <- ggfunnel::intermediate |>
  ggfunnel::funnel(
    values = Counts, levels = Step, geom_specs = list(),
    theme = ggplot2::theme(plot.background = ggplot2::element_rect())
  )


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
