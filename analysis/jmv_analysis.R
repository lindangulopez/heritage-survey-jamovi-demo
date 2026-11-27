# The analyses of EXERCISES.md, run with jmv: the R package that jamovi itself
# runs under its menus. The tables printed here are the tables jamovi shows.
#
# install.packages("jmv")   # once
# Run from the repository root:  Rscript analysis/jmv_analysis.R

library(jmv)

d <- read.csv("data/visitor_survey_simulated.csv", stringsAsFactors = TRUE)

# 1. Data > Compute: acceptability score = MEAN(acc_closure, acc_ac, acc_replica, acc_ticket)
d$acc_score <- rowMeans(d[, c("acc_closure", "acc_ac", "acc_replica", "acc_ticket")])

# 2. Exploration > Descriptives: thermal comfort by season
descriptives(d, vars = "thermal_comfort", splitBy = "season",
             median = TRUE, sd = TRUE)

# 3. Factor > Reliability Analysis: the four acceptability items
reliability(d, vars = c("acc_closure", "acc_ac", "acc_replica", "acc_ticket"),
            alphaScale = TRUE, omegaScale = TRUE, meanScale = TRUE,
            alphaItems = TRUE, itemRestCor = TRUE)

# 4. T-Tests > Independent Samples T-Test: thermal comfort, summer vs winter
ttestIS(d, vars = "thermal_comfort", group = "season",
        welchs = TRUE, mann = TRUE, effectSize = TRUE, desc = TRUE)

# 5. Frequencies > Contingency Tables > Independent Samples: country x accept_intervention
contTables(d, rows = "country", cols = "accept_intervention",
           pcRow = TRUE, phiCra = TRUE)

# 6. ANOVA > One-Way ANOVA: acceptability score by country, Tukey post hoc
anovaOneW(d, deps = "acc_score", group = "country",
          welchs = TRUE, fishers = TRUE, desc = TRUE, phMethod = "tukey")

# 7. Regression > Correlation Matrix: concern, comfort, temperature, score (Spearman)
corrMatrix(d, vars = c("climate_concern", "thermal_comfort", "temp_c", "acc_score"),
           pearson = TRUE, spearman = TRUE)

# 8. Regression > Linear Regression: acc_score ~ climate_concern + thermal_comfort + country
linReg(d, dep = "acc_score", covs = c("climate_concern", "thermal_comfort"),
       factors = "country",
       blocks = list(list("climate_concern", "thermal_comfort", "country")),
       refLevels = list(list(var = "country", ref = "France")),
       r2Adj = TRUE, stdEst = TRUE)

# 9. Regression > 2 Outcomes Binomial: accept_intervention ~ climate_concern
logRegBin(d, dep = "accept_intervention", covs = "climate_concern",
          blocks = list(list("climate_concern")),
          refLevels = list(list(var = "accept_intervention", ref = "No")),
          OR = TRUE, pseudoR2 = c("r2mf", "r2n"))
