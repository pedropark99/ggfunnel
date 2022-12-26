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
                   labels = TRUE,
                   tile_specs = list(),
                   text_specs = list(),
                   theme = ggplot2::theme()) {

  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)
  stat <- match.arg(stat, c("count", "sum", "identity"))

  table_specs <- list(
    values = values, levels = levels, stat = stat
  )
  data <- prepare_data(data, table_specs)
  plot_funnel(data, labels, tile_specs, text_specs, theme)
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



plot_funnel <- function(data, labels, tile_specs, text_specs, theme) {

  tile_specs <- process_specs(
    tile_specs,
    defaults = get_default_tile_specs()
  )
  text_specs <- process_specs(
    text_specs,
    defaults = get_default_text_specs()
  )



  plot <- data |>
    ggplot2::ggplot(ggplot2::aes(
      x = 0,
      y = reorder(y, width),
      width = width,
      label = x
    )) +
    ggplot2::geom_tile(
      height = tile_specs$height,
      alpha = tile_specs$alpha,
      colour = tile_specs$colour,
      fill = tile_specs$fill,
      linetype = tile_specs$linetype,
      stat = tile_specs$stat,
      position = tile_specs$position,
      linejoin = tile_specs$linejoin,
      na.rm = tile_specs$na.rm,
      show.legend = tile_specs$show.legend,
      inherit.aes = tile_specs$inherit.aes
    ) +
    ggplot2::labs(y = "Levels") +
    theme_funnel(theme)



  if (isTRUE(labels)) {
    plot <- plot +
      ggplot2::geom_text(
        stat = text_specs$stat,
        parse = text_specs$parse,
        nudge_x = text_specs$nudge_x,
        nudge_y = text_specs$nudge_y,
        alpha = text_specs$alpha,
        angle = text_specs$angle,
        colour = text_specs$colour,
        family = text_specs$family,
        fontface = text_specs$fontface,
        hjust = text_specs$hjust,
        vjust = text_specs$vjust,
        size = text_specs$size,
        check_overlap = text_specs$check_overlap,
        na.rm = text_specs$na.rm,
        show.legend = text_specs$show.legend,
        inherit.aes = text_specs$inherit.aes
      )
  }


  return(plot)
}







