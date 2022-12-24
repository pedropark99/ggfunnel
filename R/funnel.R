#' Plot a Funnel chart
#'
#' @param data The data.frame with your data;
#' @param values The column name where are the values you want to display in your funnel chart;
#' @param levels The column name with the "levels" (or the "groups") you want to
#'   display in your funnel chart;
#'
#' @export
funnel <- function(data, values, levels) {
  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)

  data <- prepare_data(data, values, levels)
  plot_funnel(data)
}


prepare_data <- function(data, values, levels) {
  agg <- aggregate_data(data, values, levels)
  agg <- agg |>
    dplyr::mutate(width = calc_percents(x)) |>
    dplyr::select("x", "y", "width")
}


calc_percents <- function(x) {
  top <- max(x, na.rm = TRUE)
  x / top
}


aggregate_data <- function(data, values, levels) {
  data <- group_data(data, levels)
  agg <- summarise_data(data, values)
  agg <- rename_columns(agg, levels)

  return(agg)
}

group_data <- function(data, levels) {
  dplyr::group_by(data, !!levels)
}

summarise_data <- function(data, values) {
  dplyr::summarise(data, x = sum(!!values))
}

rename_columns <- function(data, levels) {
  dplyr::rename(data, "y" = !!levels)
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


