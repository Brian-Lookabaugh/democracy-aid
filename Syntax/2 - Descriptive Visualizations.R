pacman::p_load(
  "dplyr", # Data Manipulation
  "ggplot2", # Data Visualization
  "ggdag", # Visualizing DAGs
  "dagitty", # More DAGs Stuff,
  install = FALSE
)

# DAG of Treatment-Outcome Feedback Loop
dgp1_dag <- dagitty('dag {
  "DA[t-1]" [pos="1,1"]
  "D[t-1]" [pos="2,1.25"]
  "DA[t]" [pos="3,1"]
  "D[t]" [pos="4,1.25"]
  "DA[t-1]" -> "D[t-1]"
  "D[t-1]" -> "DA[t]"
  "DA[t]" -> "D[t]"
  "DA[t-1]" -> "DA[t]"
  "D[t-1]" -> "D[t]"
}') %>%
  tidy_dagitty()

ggplot(dgp1_dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_edges() +
  geom_dag_point(color = "grey80", size = 20) +
  geom_dag_text(color = "black", size = 5, parse = TRUE) +
  theme_dag()

# DAG of Time-Varying Confounding Leading to Mediator Bias
# V = Internal Violence
dgp2_dag <- dagitty('dag {
  "DA[t-1]" [pos="1,3"]
  "D[t-1]" [pos="3,3"]
  "DA[t]" [pos="1,1"]
  "D[t]" [pos="3,1"]
  "V[t-1]" [pos="2,4"]
  "V[t]" [pos="2,2"]
  "V[t-1]" -> "DA[t-1]"
  "V[t-1]" -> "D[t-1]"
  "V[t-1]" -> "V[t]"
  "DA[t-1]" -> "D[t-1]"
  "DA[t-1]" -> "V[t]"
  "DA[t-1]" -> "DA[t]"
  "D[t-1]" -> "D[t]"
  "D[t-1]" -> "V[t]"
  "V[t]" -> "DA[t]"
  "V[t]" -> "D[t]"
  "DA[t]" -> "D[t]"
}') %>%
  tidy_dagitty()

ggplot(dgp2_dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_edges() +
  geom_dag_point(color = "grey80", size = 20) +
  geom_dag_text(color = "black", size = 5, parse = TRUE) +
  theme_dag()