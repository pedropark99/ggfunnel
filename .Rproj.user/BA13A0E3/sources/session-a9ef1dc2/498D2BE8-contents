
calc_percents <- function(x){
  top <- max(x, na.rm = TRUE)
  percents <- x / top
  percents
}


tunnel <- function(df, values, levels) {
  values <- rlang::enquo(values)
  levels <- rlang::enquo(levels)
  data <- prepare_data(df, values, levels)
  data
}


prepare_data <- function(df, values, levels) {
  agg <- aggregate_data(df, values, levels)
  agg <- agg |>
    dplyr::mutate(
      width = calc_percents(x),
      y = forcats::fct_reorder(y, width)
    ) |>
    dplyr::select("x", "y", "width")
}


aggregate_data <- function(df, values, levels) {
  agg <- df |>
    dplyr::group_by(!!levels) |>
    dplyr::summarise(x = sum(!!values)) |>
    dplyr::rename("y" = !!levels)

  return(agg)
}




# aggregates |>
#   ggplot() +
#   geom_tile(
#     aes(x = 0, y = reorder(Step, p), width = p, height = 0.8)
#   )
