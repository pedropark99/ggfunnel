#' Plot a Funnel chart
#'
#' @param data The data.frame with your data;
#' @param values The column name where are the values you want to display in your funnel chart;
#' @param levels The column name with the "levels" (or the "groups") you want to
#'   display in your funnel chart;
#'
tunnel <- function(data, values, levels) {
  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)

  data <- prepare_data(data, values, levels)
  plot_tunnel(data)
}


prepare_data <- function(data, values, levels) {
  agg <- aggregate_data(data, values, levels)
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


plot_tunnel <- function(data) {
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
    theme_tunnel()
}


