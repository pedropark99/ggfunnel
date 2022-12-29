aggregate_data <- function(data, table_specs) {
  data <- group_data(data, table_specs)
  agg <- summarise_data(data, table_specs)
  agg <- ungroup(agg)
  return(agg)
}

group_data <- function(data, table_specs) {
  levels <- table_specs$levels
  dplyr::group_by(data, !!levels)
}

summarise_data <- function(data, table_specs) {
  levels <- table_specs$levels
  values <- table_specs$values
  stat <- table_specs$stat

  if (stat == "sum") {
    result <- dplyr::summarise(data, x = sum(!!values))
  }
  if (stat == "count") {
    result <- data |>
      dplyr::count(!!levels)
  }

  return(result)
}




calc_percents <- function(data) {
  dplyr::mutate(
    data,
    width = .data$x / max(.data$x)
  )
}
