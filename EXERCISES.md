# Mock test: a heritage visitor survey in jamovi

About 60 minutes. Open `data/visitor_survey_simulated.csv` in jamovi (☰ > Open > Browse) and answer each question from the jamovi output. Menu paths are for jamovi 2.x in English; the interface language is in the ⋮ application menu (top right).

The answers are in [SOLUTIONS.md](SOLUTIONS.md). The same analyses in R, with the package jamovi runs underneath, are in [analysis/jmv_analysis.R](analysis/jmv_analysis.R).

## The survey (simulated)

240 visitors, 60 in each of four countries (France, United Kingdom, Italy, Belgium), at museums and outdoor monuments, in summer and winter.

| Variable | Question or meaning | Scale |
|---|---|---|
| `country`, `site_type`, `season`, `first_visit` | Country, museum or outdoor monument, season of the visit, first visit (Yes / No) | nominal |
| `age_group` | 18-29, 30-44, 45-64, 65+ | ordinal |
| `temp_c` | Temperature at the time of the visit, °C | continuous |
| `thermal_comfort` | "How comfortable was the temperature during your visit?" 1 = very uncomfortable … 5 = very comfortable | Likert 1-5 |
| `humidity_comfort` | "And the humidity?" same scale | Likert 1-5 |
| `climate_concern` | "Climate change threatens this heritage site." 1 = strongly disagree … 5 = strongly agree | Likert 1-5 |
| `acc_closure` | Acceptability: partial closure during heatwaves | Likert 1-5 |
| `acc_ac` | Acceptability: air conditioning in the rooms | Likert 1-5 |
| `acc_replica` | Acceptability: a replica shown instead of the original | Likert 1-5 |
| `acc_ticket` | Acceptability: a higher ticket price to fund conservation | Likert 1-5 |
| `accept_intervention` | "Would you accept interventions to protect this site?" | Yes / No |

## Questions

**Q0. Set up the data.** In the Data tab, check each variable's measure type: nominal for `country`, `site_type`, `season`, `first_visit` and `accept_intervention`; ordinal for `age_group`. jamovi's t-test, ANOVA and regression menus only accept continuous variables, so set the Likert items to continuous. Why is that a choice, and what would you say about it in a methods section?

**Q1. Compute a score.** Data > Compute: create `acc_score` with the formula `MEAN(acc_closure, acc_ac, acc_replica, acc_ticket)`. What does one point on this score mean?

**Q2. Describe.** Exploration > Descriptives: `thermal_comfort`, split by `season`; tick median and standard deviation. Report the mean and median comfort in summer and in winter.

**Q3. Check the scale.** Factor > Reliability Analysis: the four `acc_` items; tick McDonald's ω, item-rest correlation and "Cronbach's α if item dropped". Is the scale reliable enough to average? Would dropping an item help?

**Q4. Compare two groups.** T-Tests > Independent Samples T-Test: `thermal_comfort` by `season`; tick Student's, Welch's and Mann-Whitney U, effect size and descriptives, and the homogeneity test. Which test do you report, and why?

**Q5. Two categorical variables.** Frequencies > Independent Samples (χ² test of association): rows `country`, columns `accept_intervention`; tick row percentages and Phi and Cramér's V. Does acceptance differ by country? How strong is the link?

**Q6. More than two groups.** ANOVA > One-Way ANOVA: `acc_score` by `country`; tick both variance options (Welch's and Fisher's), descriptives, and the Tukey post hoc test. Which countries differ?

**Q7. Associations.** Regression > Correlation Matrix: `climate_concern`, `thermal_comfort`, `temp_c`, `acc_score`; tick Pearson and Spearman. Which pairs are correlated? Is comfort linked to acceptability?

**Q8. Explain the score.** Regression > Linear Regression: dependent `acc_score`; covariates `climate_concern`, `thermal_comfort`; factor `country` with France as the reference level; tick adjusted R² and standardised estimates. What predicts acceptability, holding the others constant?

**Q9. A yes/no outcome.** Regression > 2 Outcomes (Binomial): dependent `accept_intervention`, reference level No; covariate `climate_concern`; tick odds ratios, McFadden's and Nagelkerke's R². Interpret the odds ratio in one sentence.

**Q10. Say it to the public.** Write three plain sentences for an exhibition panel from Q2, Q6 and Q8, with no statistical vocabulary.

## Saving your work

☰ > Save as: a `.omv` file keeps the data, the computed score and every analysis. Commit it in `analysis/` if you want to keep it.
