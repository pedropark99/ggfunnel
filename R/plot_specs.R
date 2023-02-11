#' Default specifications for the \code{ggplot2::geom_tile()} geom
#'
#' \code{ggfunnel::default_tile_specs} store the list of default values
#' used at the \code{ggplot2::geom_tile()} geom arguments.
#'
#' @details
#' \code{ggfunnel::funnel()} uses the
#' \code{ggplot2::geom_tile()} geom to build the rectangles present in the funnel chart,
#' and will fill all arguments of \code{ggplot2::geom_tile()} geom with the values
#' present at \code{ggfunnel::default_tile_specs}.
#'
#' You can change these values by using the \code{tile_specs} argument of \code{ggfunnel::funnel()}.
#' @export
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


#' Default specifications for the \code{ggplot2::geom_text()} geom
#'
#' \code{ggfunnel::default_text_specs} store the list of default values
#' used at the \code{ggplot2::geom_text()} geom arguments.
#'
#' @details
#' If the argument \code{labels} of \code{ggfunnel::funnel()} is set to \code{TRUE}, than,
#' the \code{ggplot2::geom_text()} geom will be used to print the value labels in the funnel chart.
#' \code{ggfunnel::funnel()} will fill all arguments of \code{ggplot2::geom_text()} geom with the values
#' present at \code{ggfunnel::default_text_specs}.
#'
#' You can change these values by using the \code{text_specs} argument of \code{ggfunnel::funnel()}.
#' @export
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


