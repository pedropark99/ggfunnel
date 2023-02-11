# `ggfunnel`

`{ggfunnel}` is a R package that uses `{ggplot2}` to create Power BI
like funnel charts in R. `ggfunnel::funnel()` is the main function of
the package, responsible for producing the plot. The basic example below
will produce the following plot:

    library(ggfunnel)
    plot <- ggfunnel::aggregates |>
      ggfunnel::funnel(
        values = N_users, levels = Step
      )

    print(plot)

![](README_files/figure-markdown_strict/unnamed-chunk-1-1.png)
