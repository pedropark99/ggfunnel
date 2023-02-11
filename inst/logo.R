library(ggfunnel)
library(ggplot2)
library(hexSticker)


print(ggfunnel::aggregates)
# Ploting a funne chart that shows the distribution of users
# across the different "steps".
plot <- ggfunnel::aggregates |>
  ggfunnel::funnel(
    values = N_users, levels = Step,
    labels = FALSE,
    tile_specs = list(fill = "#2684ff")
  )

plot <- plot + theme_void()


s <- sticker(
  plot, package="ggfunnel",
  p_size=20, p_y = 1.5,
  s_width=1.5, s_height=1, s_x = 1,
  h_fill = "#222222",
  h_color = "#2684ff",
  filename="inst/ggfunnel-logo.png"
)

print(s)
