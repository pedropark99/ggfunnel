devtools::load_all()

a <- ggfunnel::intermediate |>
  ggfunnel::funnel(
    values = Counts, levels = Step
  )


print(a)


ggfunnel:::plot_specs()
ggfunnel:::plot_specs(teste = 1)
