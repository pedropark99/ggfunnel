#' Plot a Funnel chart
#'
#' @param data The data.frame with your data;
#' @param values The column name where are the values you want to display in your funnel chart;
#' @param levels The column name with the "levels" (or the "groups") you want to
#'   display in your funnel chart;
#'
#' @export
funnel <- function(data,
                   values,
                   levels,
                   stat = "sum",
                   geom_specs = list(),
                   theme = ggplot2::theme()) {

  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)
  stat <- match.arg(stat, c("count", "sum", "identity"))

  table_specs <- list(
    values = values, levels = levels, stat = stat
  )
  data <- prepare_data(data, table_specs)
  plot_funnel(data, geom_specs, theme)
}


prepare_data <- function(data, table_specs) {
  if (table_specs$stat != "identity") {
    data <- aggregate_data(data, table_specs)
  }
  data <- rename_columns(data, table_specs)
  data <- calc_percents(data)
  dplyr::select(data, "x", "y", "width")
}

rename_columns <- function(data, table_specs) {
  levels <- table_specs$levels
  values <- table_specs$values
  stat <- table_specs$stat
  if (stat != "identity") {
    data <- dplyr::rename(data, "y" = !!levels)
  } else {
    data <- dplyr::rename(data, "x" = !!values, "y" = !!levels)
  }

  return(data)
}



plot_funnel <- function(data, geom_specs, theme) {
  geom_specs <- geom_specs__(geom_specs)

  data |>
    ggplot2::ggplot(ggplot2::aes(
      x = 0,
      y = reorder(y, width),
      width = width
    )) +
    ggplot2::geom_tile(
      height = geom_specs$height,
      alpha = geom_specs$alpha,
      colour = geom_specs$colour,
      fill = geom_specs$fill,
      linetype = geom_specs$linetype,
      stat = geom_specs$stat,
      position = geom_specs$position,
      linejoin = geom_specs$linejoin,
      na.rm = geom_specs$na.rm,
      show.legend = geom_specs$show.legend,
      inherit.aes = geom_specs$inherit.aes
    ) +
    theme_funnel()
}







