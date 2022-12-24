#' Plot a Funnel chart
#'
#' @param data The data.frame with your data;
#' @param values The column name where are the values you want to display in your funnel chart;
#' @param levels The column name with the "levels" (or the "groups") you want to
#'   display in your funnel chart;
#'
#' @export
funnel <- function(data, values, levels, stat = "sum", ...) {
  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)
  stat <- match.arg(stat, c("count", "sum", "identity"))

  table_specs <- list(
    values = values, levels = levels, stat = stat
  )
  data <- prepare_data(data, table_specs)
  plot_funnel(data, ...)
}


prepare_data <- function(data, table_specs) {
  if (table_specs$stat != "identity") {
    agg <- aggregate_data(data, table_specs)
  }
  agg <- calc_percents(agg)
  dplyr::select(agg, "x", "y", "width")
}



plot_funnel <- function(data, ...) {
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


