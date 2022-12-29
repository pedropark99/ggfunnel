default_theme <- function(){
  ggplot2::theme_void() +
    ggplot2::theme(
      axis.title.y = ggplot2::element_text(
        angle = 90,
        margin = ggplot2::margin(r = 10)
      ),
      axis.text.y = ggplot2::element_text(hjust = 1)
    )
}

theme_funnel <- function(plot, user_theme = ggplot2::theme()) {
  plot + user_theme
}
