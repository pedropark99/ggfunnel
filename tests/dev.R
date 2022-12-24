devtools::load_all()

a <- ggfunnel::intermediate |>
  ggfunnel::funnel(
    values = Counts, levels = Step
  )


print(a)


# b <- ggfunnel::aggregates |>
#   ggfunnel::funnel(
#     values = N_users, levels = Step,
#     stat = "identity"
#   )
#
# print(b)
