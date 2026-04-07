library(plotrix)


plot_antigenicity_pyramid <- function(
    comparison_table,
    rows_to_remove = 2,
    left_colors    = c("#E69F00", "#56B4E9", "#CC79A7"),
    right_color    = "grey60",
    gap            = 10,
    space          = 0.2,
    ax_step        = 40,
    show_values    = TRUE,
    left_label     = "Other Antigenicity Metrics",
    right_label    = "Epistatic antigenicity",
    unit_label     = "no. of reference mutations"
) {
  
  pyramid_data <- comparison_table[-rows_to_remove, ] %>%
    mutate(lower_count = total - higher_count)
  
  pyra <- pyramid_data %>%
    pivot_longer(
      cols      = c(higher_count, lower_count),
      names_to  = "ranks",
      values_to = "rank_high_low"
    ) %>%
    mutate(ranks = if_else(
      ranks == "higher_count",
      "Epistatic antigenicity",
      "Other antigenicity metrics"
    ))
  
  total_mutation <- pyramid_data %>% pull(total) %>% unique()
  
  pyramid.plot(
    lx          = pyra %>% filter(ranks == "Other antigenicity metrics") %>% pull(rank_high_low),
    rx          = pyra %>% filter(ranks == "Epistatic antigenicity")     %>% pull(rank_high_low),
    labels      = rep("", nrow(pyramid_data)),
    gap         = gap,
    space       = space,
    top.labels  = c(left_label, "", right_label),
    raxlab      = seq(0, total_mutation, ax_step),
    laxlab      = seq(0, total_mutation, ax_step),
    show.values = show_values,
    unit        = unit_label,
    rxcol       = right_color,
    lxcol       = left_colors,
    ndig        = 0
  )
  
  invisible(pyra)
}

plot_antigenicity_pyramid(hw5$comparison_table)
plot_antigenicity_pyramid(sw5$comparison_table, ax_step = 20)
plot_antigenicity_pyramid(fw5$comparison_table, ax_step = 10)

plot.new()
legend(
  "bottomleft",                # or "topleft", "bottom", etc.
  legend = c("Epistatic Antigenicity\n(structure-derived)", 'DMS score',  "EVEscape score"),
  fill   = c("#E69F00", "#56B4E9", "#CC79A7"),
  border = NA,
  bty    = "n",                 # no legend box
  cex    = 0.85
)


# pyramid_test_hiv <- hw5$comparison_table[-2,] %>% mutate(lower_count = total - higher_count)
# pyra <- pyramid_test_hiv %>% pivot_longer(cols = c(higher_count, lower_count), 
#                                           names_to = 'ranks', values_to = 'rank_high_low') %>% 
#   mutate(ranks = if_else(ranks == 'higher_count', 'Epistatic antigenicity', 'Other antigenicity metrics'))
# 
# total_mutation <- pyramid_test_hiv %>% pull(total) %>% unique()
# class(total_mutation)
# 
# pyramid.plot(pyra %>% filter(ranks == 'Other antigenicity metrics') %>% pull(rank_high_low), 
#              pyra %>% filter(ranks == 'Epistatic antigenicity') %>% pull(rank_high_low), 
#              #labels = rev(c('Eve-Epi', 'Str-Epi', 'Surf-Epi', 'DMS-Epi')), 
#              labels = c(rep("", 3)),
#              gap =10, 
#              space = 0.2,
#              #main = 'each colored bar shows the number of reference mutations\nwith higher ranks for a metric compared to adjacent metric',
#              top.labels=c("Other Antigenicity Metrics","","Epistatic antigenicity"), 
#              raxlab = seq(0,total_mutation,40), 
#              laxlab = seq(0,total_mutation,40), 
#              show.values=TRUE, 
#              unit = 'no. of reference mutations', 
#              rxcol = 'grey60', 
#              lxcol = c("#E69F00", "#56B4E9", "#CC79A7"),
#              ndig =0)

