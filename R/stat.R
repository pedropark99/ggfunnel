
calc_percents <- function(x){
  top <- max(x, na.rm = TRUE)
  percents <- x / top
  percents
}




StatTunnel <- ggplot2::ggproto(
  "StatTunnel", ggplot2::Stat,

  required_aes = c("x", "y"),

  setup_params = function(data, params) {
    agg <- aggregate(data$x, list(groups = data$y), sum)
    top <- max(agg$x, na.rm = TRUE)
    params$max.value <- top
    params
  },

  compute_group = function(data, scales, max.value = 0) {
    total <- sum(data$x, na.rm = TRUE)
    percent <- total / max.value
    data.frame(width = percent, x = 0, y = data$y)
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


