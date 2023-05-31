set.seed(46378)
library(dplyr)
library(meta)

studies_n <- 10
samples_n <- c(10, 25, 50, 75)

e_mean = 115
e_sd = 7

c_mean = 100
c_sd = 7

output1_data <- tibble(
    author = paste("Contribution", 1:studies_n),
    n.e = sample(samples_n, studies_n, replace = TRUE),
    mean.e = rnorm(studies_n, e_mean, e_sd/2),
    sd.e = rnorm(studies_n, e_sd, e_sd/2),
    n.c = n.e,
    mean.c = rnorm(studies_n, c_mean, c_sd/2),
    sd.c = rnorm(studies_n, c_sd, c_sd/2)
  )


output1_analysis <- metacont(
                    n.e = n.e,
                    mean.e = mean.e,
                    sd.e = sd.e,
                    n.c = n.c,
                    mean.c = mean.c,
                    sd.c = sd.c,
                    studlab = author,
                    data = output1_data,
                    sm = "SMD",
                    method.smd = "Hedges",
                    fixed = TRUE,
                    random = TRUE,
                    method.tau = "REM",
                    hakn = TRUE,
                    prediction = TRUE,
                    title = "Exemple de méta-analysis"
)

output1_forest <- forest.meta(
  output1_analysis,
  digits = 2,
  digits.se = 2,
  digits.stat = 2,
  prediction = TRUE,
  common = TRUE,
  random = FALSE
)


# Produce funnel plot
funnel.meta(output1_analysis,
            studlab = TRUE,
            common = FALSE
)

