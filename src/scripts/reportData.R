# read in
for (f in list.files()) {
  assign(f, read_delim(f, "\t", escape_double = FALSE, col_names = T, trim_ws = TRUE))
}


# Pearson
# AP
mean(ap.clarity.map.pearson$cor)
max(ap.clarity.map.pearson$cor)
mean(ap.clarity.ndcg.pearson$cor)
max(ap.clarity.ndcg.pearson$cor)

mean(AP.clarity.map.pearson.wiki$cor)
max(AP.clarity.map.pearson.wiki$cor)
mean(AP.clarity.ndcg.pearson.wiki$cor)
max(AP.clarity.ndcg.pearson.wiki$cor)

mean(ap.feedback.map.pearson$cor)
max(ap.feedback.map.pearson$cor)
mean(ap.feedback.ndcg.pearson$cor)
max(ap.feedback.ndcg.pearson$cor)

mean(AP.pseudoFlip.map.pearson$cor)
max(AP.pseudoFlip.map.pearson$cor)
mean(AP.pseudoFlip.ndcg.pearson$cor)
max(AP.pseudoFlip.ndcg.pearson$cor)

mean(ap.pseudo.map.pearson$cor)
max(ap.pseudo.map.pearson$cor)
mean(ap.pseudo.ndcg.pearson$cor)
max(ap.pseudo.ndcg.pearson$cor)

mean(AP.pseudo.map.pearson.wiki$cor)
max(AP.pseudo.map.pearson.wiki$cor)
mean(AP.pseudo.ndcg.pearson.wiki$cor)
max(AP.pseudo.ndcg.pearson.wiki$cor)

t.test(ap.pseudo.map.pearson$cor,
       ap.clarity.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.map.pearson$cor,
       ap.feedback.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.map.pearson$cor,
       AP.pseudoFlip.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(ap.pseudo.ndcg.pearson$cor,
       ap.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.ndcg.pearson$cor,
       ap.feedback.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.ndcg.pearson$cor,
       AP.pseudoFlip.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(AP.pseudo.map.pearson.wiki$cor,
       ap.pseudo.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(AP.pseudo.ndcg.pearson.wiki$cor,
       ap.pseudo.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(AP.clarity.map.pearson.wiki$cor,
       ap.clarity.map.pearson$cor,
       paired = T, alternative = 'less')$p.value
t.test(AP.clarity.ndcg.pearson.wiki$cor,
       ap.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'less')$p.value

# wt10g
mean(wt10g.clarity.map.pearson$cor)
max(wt10g.clarity.map.pearson$cor)
mean(wt10g.clarity.ndcg.pearson$cor)
max(wt10g.clarity.ndcg.pearson$cor)

mean(wt10g.clarity.map.pearson.wiki$cor)
max(wt10g.clarity.map.pearson.wiki$cor)
mean(wt10g.clarity.ndcg.pearson.wiki$cor)
max(wt10g.clarity.ndcg.pearson.wiki$cor)

mean(wt10g.feedback.map.pearson$cor)
max(wt10g.feedback.map.pearson$cor)
mean(wt10g.feedback.ndcg.pearson$cor)
max(wt10g.feedback.ndcg.pearson$cor)

mean(wt10g.pseudoFlip.map.pearson$cor)
max(wt10g.pseudoFlip.map.pearson$cor)
mean(wt10g.pseudoFlip.ndcg.pearson$cor)
max(wt10g.pseudoFlip.ndcg.pearson$cor)

mean(wt10g.pseudo.map.pearson$cor)
max(wt10g.pseudo.map.pearson$cor)
mean(wt10g.pseudo.ndcg.pearson$cor)
max(wt10g.pseudo.ndcg.pearson$cor)

mean(wt10g.pseudo.map.pearson.wiki$cor)
max(wt10g.pseudo.map.pearson.wiki$cor)
mean(wt10g.pseudo.ndcg.pearson.wiki$cor)
max(wt10g.pseudo.ndcg.pearson.wiki$cor)

t.test(wt10g.pseudo.map.pearson$cor,
       wt10g.clarity.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.map.pearson$cor,
       wt10g.feedback.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.map.pearson$cor,
       wt10g.pseudoFlip.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(wt10g.pseudo.ndcg.pearson$cor,
       wt10g.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.pearson$cor,
       wt10g.feedback.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.pearson$cor,
       wt10g.pseudoFlip.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(wt10g.pseudo.map.pearson.wiki$cor,
       wt10g.pseudo.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.pearson.wiki$cor,
       wt10g.pseudo.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.clarity.map.pearson.wiki$cor,
       wt10g.clarity.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.clarity.ndcg.pearson.wiki$cor,
       wt10g.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value

# robust
mean(robust.clarity.map.pearson$cor)
max(robust.clarity.map.pearson$cor)
mean(robust.clarity.ndcg.pearson$cor)
max(robust.clarity.ndcg.pearson$cor)

mean(robust.clarity.map.pearson.wiki$cor)
max(robust.clarity.map.pearson.wiki$cor)
mean(robust.clarity.ndcg.pearson.wiki$cor)
max(robust.clarity.ndcg.pearson.wiki$cor)

mean(robust.feedback.map.pearson$cor)
max(robust.feedback.map.pearson$cor)
mean(robust.feedback.ndcg.pearson$cor)
max(robust.feedback.ndcg.pearson$cor)

mean(robust.pseudoFlip.map.pearson$cor)
max(robust.pseudoFlip.map.pearson$cor)
mean(robust.pseudoFlip.ndcg.pearson$cor)
max(robust.pseudoFlip.ndcg.pearson$cor)

mean(robust.pseudo.map.pearson$cor)
max(robust.pseudo.map.pearson$cor)
mean(robust.pseudo.ndcg.pearson$cor)
max(robust.pseudo.ndcg.pearson$cor)

mean(robust.pseudo.map.pearson.wiki$cor)
max(robust.pseudo.map.pearson.wiki$cor)
mean(robust.pseudo.ndcg.pearson.wiki$cor)
max(robust.pseudo.ndcg.pearson.wiki$cor)

t.test(robust.pseudo.map.pearson$cor,
       robust.clarity.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.map.pearson$cor,
       robust.feedback.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.map.pearson$cor,
       robust.pseudoFlip.map.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(robust.pseudo.ndcg.pearson$cor,
       robust.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.ndcg.pearson$cor,
       robust.feedback.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.ndcg.pearson$cor,
       robust.pseudoFlip.ndcg.pearson$cor,
       paired = T, alternative = 'greater')$p.value

t.test(robust.pseudo.map.pearson.wiki$cor,
       robust.pseudo.map.pearson$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.pseudo.ndcg.pearson.wiki$cor,
       robust.pseudo.ndcg.pearson$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.clarity.map.pearson.wiki$cor,
       robust.clarity.map.pearson$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.clarity.ndcg.pearson.wiki$cor,
       robust.clarity.ndcg.pearson$cor,
       paired = T, alternative = 'less')$p.value

# Kendall
# AP
mean(ap.clarity.map.kendall$cor)
max(ap.clarity.map.kendall$cor)
mean(ap.clarity.ndcg.kendall$cor)
max(ap.clarity.ndcg.kendall$cor)

mean(AP.clarity.map.kendall.wiki$cor)
max(AP.clarity.map.kendall.wiki$cor)
mean(AP.clarity.ndcg.kendall.wiki$cor)
max(AP.clarity.ndcg.kendall.wiki$cor)

mean(ap.feedback.map.kendall$cor)
max(ap.feedback.map.kendall$cor)
mean(ap.feedback.ndcg.kendall$cor)
max(ap.feedback.ndcg.kendall$cor)

mean(AP.pseudoFlip.map.kendall$cor)
max(AP.pseudoFlip.map.kendall$cor)
mean(AP.pseudoFlip.ndcg.kendall$cor)
max(AP.pseudoFlip.ndcg.kendall$cor)

mean(ap.pseudo.map.kendall$cor)
max(ap.pseudo.map.kendall$cor)
mean(ap.pseudo.ndcg.kendall$cor)
max(ap.pseudo.ndcg.kendall$cor)

mean(AP.pseudo.map.kendall.wiki$cor)
max(AP.pseudo.map.kendall.wiki$cor)
mean(AP.pseudo.ndcg.kendall.wiki$cor)
max(AP.pseudo.ndcg.kendall.wiki$cor)

t.test(ap.pseudo.map.kendall$cor,
       ap.clarity.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.map.kendall$cor,
       ap.feedback.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.map.kendall$cor,
       AP.pseudoFlip.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(ap.pseudo.ndcg.kendall$cor,
       ap.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.ndcg.kendall$cor,
       ap.feedback.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(ap.pseudo.ndcg.kendall$cor,
       AP.pseudoFlip.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(AP.pseudo.map.kendall.wiki$cor,
       ap.pseudo.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(AP.pseudo.ndcg.kendall.wiki$cor,
       ap.pseudo.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(AP.clarity.map.kendall.wiki$cor,
       ap.clarity.map.kendall$cor,
       paired = T, alternative = 'less')$p.value
t.test(AP.clarity.ndcg.kendall.wiki$cor,
       ap.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'less')$p.value

# wt10g
mean(wt10g.clarity.map.kendall$cor)
max(wt10g.clarity.map.kendall$cor)
mean(wt10g.clarity.ndcg.kendall$cor)
max(wt10g.clarity.ndcg.kendall$cor)

mean(wt10g.clarity.map.kendall.wiki$cor)
max(wt10g.clarity.map.kendall.wiki$cor)
mean(wt10g.clarity.ndcg.kendall.wiki$cor)
max(wt10g.clarity.ndcg.kendall.wiki$cor)

mean(wt10g.feedback.map.kendall$cor)
max(wt10g.feedback.map.kendall$cor)
mean(wt10g.feedback.ndcg.kendall$cor)
max(wt10g.feedback.ndcg.kendall$cor)

mean(wt10g.pseudoFlip.map.kendall$cor)
max(wt10g.pseudoFlip.map.kendall$cor)
mean(wt10g.pseudoFlip.ndcg.kendall$cor)
max(wt10g.pseudoFlip.ndcg.kendall$cor)

mean(wt10g.pseudo.map.kendall$cor)
max(wt10g.pseudo.map.kendall$cor)
mean(wt10g.pseudo.ndcg.kendall$cor)
max(wt10g.pseudo.ndcg.kendall$cor)

mean(wt10g.pseudo.map.kendall.wiki$cor)
max(wt10g.pseudo.map.kendall.wiki$cor)
mean(wt10g.pseudo.ndcg.kendall.wiki$cor)
max(wt10g.pseudo.ndcg.kendall.wiki$cor)

t.test(wt10g.pseudo.map.kendall$cor,
       wt10g.clarity.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.map.kendall$cor,
       wt10g.feedback.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.map.kendall$cor,
       wt10g.pseudoFlip.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(wt10g.pseudo.ndcg.kendall$cor,
       wt10g.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.kendall$cor,
       wt10g.feedback.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.kendall$cor,
       wt10g.pseudoFlip.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(wt10g.pseudo.map.kendall.wiki$cor,
       wt10g.pseudo.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.pseudo.ndcg.kendall.wiki$cor,
       wt10g.pseudo.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.clarity.map.kendall.wiki$cor,
       wt10g.clarity.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(wt10g.clarity.ndcg.kendall.wiki$cor,
       wt10g.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value

# robust
mean(robust.clarity.map.kendall$cor)
max(robust.clarity.map.kendall$cor)
mean(robust.clarity.ndcg.kendall$cor)
max(robust.clarity.ndcg.kendall$cor)

mean(robust.clarity.map.kendall.wiki$cor)
max(robust.clarity.map.kendall.wiki$cor)
mean(robust.clarity.ndcg.kendall.wiki$cor)
max(robust.clarity.ndcg.kendall.wiki$cor)

mean(robust.feedback.map.kendall$cor)
max(robust.feedback.map.kendall$cor)
mean(robust.feedback.ndcg.kendall$cor)
max(robust.feedback.ndcg.kendall$cor)

mean(robust.pseudoFlip.map.kendall$cor)
max(robust.pseudoFlip.map.kendall$cor)
mean(robust.pseudoFlip.ndcg.kendall$cor)
max(robust.pseudoFlip.ndcg.kendall$cor)

mean(robust.pseudo.map.kendall$cor)
max(robust.pseudo.map.kendall$cor)
mean(robust.pseudo.ndcg.kendall$cor)
max(robust.pseudo.ndcg.kendall$cor)

mean(robust.pseudo.map.kendall.wiki$cor)
max(robust.pseudo.map.kendall.wiki$cor)
mean(robust.pseudo.ndcg.kendall.wiki$cor)
max(robust.pseudo.ndcg.kendall.wiki$cor)

t.test(robust.pseudo.map.kendall$cor,
       robust.clarity.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.map.kendall$cor,
       robust.feedback.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.map.kendall$cor,
       robust.pseudoFlip.map.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(robust.pseudo.ndcg.kendall$cor,
       robust.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.ndcg.kendall$cor,
       robust.feedback.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value
t.test(robust.pseudo.ndcg.kendall$cor,
       robust.pseudoFlip.ndcg.kendall$cor,
       paired = T, alternative = 'greater')$p.value

t.test(robust.pseudo.map.kendall.wiki$cor,
       robust.pseudo.map.kendall$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.pseudo.ndcg.kendall.wiki$cor,
       robust.pseudo.ndcg.kendall$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.clarity.map.kendall.wiki$cor,
       robust.clarity.map.kendall$cor,
       paired = T, alternative = 'less')$p.value
t.test(robust.clarity.ndcg.kendall.wiki$cor,
       robust.clarity.ndcg.kendall$cor,
       paired = T, alternative = 'less')$p.value