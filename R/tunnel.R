
calc_percents <- function(x){
  top <- max(x, na.rm = TRUE)
  percents <- x / top
  percents
}


funnel <- function(df, values, levels) {
  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)

  data <- prepare_data(df, values, levels)
  plot_funnel(data)
}


prepare_data <- function(df, values, levels) {
  agg <- aggregate_data(df, values, levels)
  agg <- agg |>
    dplyr::mutate(width = calc_percents(x)) |>
    dplyr::select("x", "y", "width")
}


aggregate_data <- function(df, values, levels) {
  agg <- df |>
    dplyr::group_by(!!levels) |>
    dplyr::summarise(x = sum(!!values)) |>
    dplyr::rename("y" = !!levels)

  return(agg)
}


plot_funnel <- function(data) {
  data |>
    ggplot2::ggplot() +
    ggplot2::geom_tile(
      ggplot2::aes(
        x = 0,
        y = reorder(y, width),
        width = width,
        height = 0.8
      )
    ) +
    theme_funnel()
}


