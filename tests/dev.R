devtools::load_all()

a <- ggfunnel::intermediate |>
  ggfunnel::funnel(
    values = Counts, levels = Step
  )


print(a)
