

theme_funnel <- function(user_theme) {
  base_theme <- ggplot2::theme_void() +
    ggplot2::theme(
      axis.title.y = ggplot2::element_text(
        angle = 90,
        margin = ggplot2::margin(r = 10)
      ),
      axis.text.y = ggplot2::element_text()
    )


  result <- ggplot2::`%+replace%`(base_theme, user_theme)
  result
}
