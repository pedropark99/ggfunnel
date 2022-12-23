
calc_percents <- function(x){
  top <- max(x, na.rm = TRUE)
  percents <- x / top
  percents
}

geom_tunnel <- function(mapping = NULL, data = NULL){
  mapping
}


build_grid <- function(y, percents){
  y <- forcats::fct_reorder(y, percents, .desc = TRUE)
  # y is the categorical variable
  data.frame(
    x = 0,
    y = y,
    width = percents
  )
}

StatTunnel <- ggplot2::ggproto("StatTunnel", ggplot2::Stat,
  required_aes = c("x", "y"),

  compute_group = function(data, scales) {
    p <- calc_percents(data$x)
    print(data$x)
    print(p)
    build_grid(data$y, p)
  }

)

stat_tunnel <- function(mapping = NULL, data = NULL, geom = "tile",
                        position = "identity", na.rm = FALSE, show.legend = NA,
                        inherit.aes = TRUE, height = 0.8, ...) {
  ggplot2::layer(
    stat = StatTunnel, data = data, mapping = mapping, geom = geom,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, height = height, ...)
  )
}



# aggregates |>
#   ggplot() +
#   geom_tile(
#     aes(x = 0, y = reorder(Step, p), width = p, height = 0.8)
#   )
