default_geom_specs <- list(
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

get_default_geom_specs <- function() {
  default_geom_specs
}

`%notin%` <- function(x, y) {
  ! (x %in% y)
}

geom_specs__ <- function(specs) {
  default <- get_default_geom_specs()
  if (length(specs) == 0) {
    return(default)
  }
  unrecognized_specs <- names(specs) %notin% names(default)
  if (any(unrecognized_specs)) {
    report_unrecognized_specs(specs[unrecognized_specs])
  }
  specs <- list_merge(specs, default)
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


