ggplot(robust_pseudo_cor_map, 
       aes(x = n, 
           y = cor, 
           color = p, 
           group = p)) + 
  geom_line() + 
  geom_point() + 
  facet_grid(. ~ k) + 
  theme(axis.title.x = element_text(face = 'italic'), 
        legend.title = element_text(face = 'italic'), 
        plot.subtitle = element_text(face = 'italic', 
                                     hjust = .5, 
                                     size = 12)) + 
  labs(y = 'Correlation', 
       subtitle = 'k') + 
  scale_color_gradient(low = 'orange', 
                       high = 'blue')