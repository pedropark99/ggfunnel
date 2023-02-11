# `ggfunnel` <img src="inst/ggfunnel-logo.png" style="height:200px" align="right" />

## Overview

`{ggfunnel}` is a R package that uses `{ggplot2}` to create Power BI
like funnel charts in R. `ggfunnel::funnel()` is the main function of
the package, responsible for producing the plot. The basic example below
will produce the following plot:

```r
library(ggfunnel)
plot <- ggfunnel::aggregates |>
  ggfunnel::funnel(
    values = N_users, levels = Step
  )

print(plot)
```

![](inst/example1.png)

# A simple approach

`{ggfunnel}` is far from perfect, and does not contain literally all you might want/need for building a funnel chart. `{ggfunnel}` takes a minimal and simple approach to the problem. It makes some assumptions about your data that might not hold, and does not contain some features that you might find at Power BI.

But, even being a very simple package, since `ggfunnel::funnel()` returns the raw `ggplot` object that describes the funnel chart, it gives you freedom to customize (or complement) the output in the way you might need (see `vignette("funnel")` for more details on how to customize/complement the `ggfunnel::funnel()` output).

However, the package needs some work to be a more robust and complete piece of code, for sure. If you think you can make `{ggfunnel}` better I would be happy to review a PR from you!

