default_plot_specs <- list(
  width = 0.8
)

plot_specs <- function(...) {
  dots <- list(...)
  default <- get_default_plot_specs()
  if (length(dots) == 0) {
    return(default)
  }
  specs <- list_merge(dots, default)
  specs
}

get_default_plot_specs <- function() {
  default_plot_specs
}



list_merge <- function(x, y) {
  all <- c(x, y)
  keys <- unique(names(all))
  all[keys]
}

