
stat_tunnel <- function(x){
  top <- max(x)
  percents <- x / top
  percents
}

aggregates$p <- stat_tunnel(aggregates$N_users)

aggregates |>
  ggplot() +
  geom_tile(
    aes(x = 0, y = reorder(Step, p), width = p, height = 0.5)
  )

#'
#'
#'
#'
#'
#'
#'
geom_tunnel <- function(mapping = NULL, data = NULL){

}
