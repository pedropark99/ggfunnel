aggregate_data <- function(data, table_specs) {
  data <- group_data(data, table_specs)
  agg <- summarise_data(data, table_specs)
  agg <- rename_columns(agg, table_specs)

  return(agg)
}

group_data <- function(data, table_specs) {
  levels <- table_specs$levels
  dplyr::group_by(data, !!levels)
}

summarise_data <- function(data, table_specs) {
  values <- table_specs$values
  fun <- get_agg_function(table_specs)
  dplyr::summarise(data, x = fun(!!values))
}

get_agg_function <- function(table_specs) {
  switch (table_specs$stat,
    "count" = dplyr::count,
    "sum" = sum
  )
}

rename_columns <- function(data, table_specs) {
  levels <- table_specs$levels
  dplyr::rename(data, "y" = !!levels)
}


calc_percents <- function(data) {
  dplyr::mutate(
    data,
    width = .data$x / max(.data$x)
  )
}
