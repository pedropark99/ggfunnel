default_tile_specs <- list(
  alpha = 1,
  colour = "#222222",
  fill = "#222222",
  linetype = "solid",
  height = 0.8,
  stat = "identity",
  position = "identity",
  linejoin = "mitre",
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

default_text_specs <- list(
  stat = "identity",
  parse = FALSE,
  nudge_x = 0,
  nudge_y = 0,
  alpha = 1,
  angle = 0,
  colour = "#969696",
  family = "sans",
  fontface = "plain",
  hjust = 0.5,
  vjust = 0.5,
  size = 12 / ggplot2::.pt,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

get_default_tile_specs <- function() {
  default_tile_specs
}

get_default_text_specs <- function() {
  default_text_specs
}

`%notin%` <- function(x, y) {
  ! (x %in% y)
}

process_specs <- function(specs, defaults) {
  if (length(specs) == 0) {
    return(defaults)
  }
  unrecognized_specs <- names(specs) %notin% names(defaults)
  if (any(unrecognized_specs)) {
    report_unrecognized_specs(specs[unrecognized_specs])
  }
  specs <- list_merge(specs, defaults)
  specs
}

report_unrecognized_specs <- function(specs) {
  rlang::warn(
    message = "Some geom specs were not recognized, and thus, ignored by `ggfunnel::funnel()`:",
    body = sprintf("* %s", names(specs)),
    use_cli_format = TRUE
  )
}


list_merge <- function(x, y) {
  all <- c(x, y)
  keys <- unique(names(all))
  all[keys]
}


a$layers[[1]][["stat_params"]]

