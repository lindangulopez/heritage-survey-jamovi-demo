# Heritage visitor survey: a jamovi demo

Practice for analysing a visitor survey on comfort, climate perception and the acceptability of conservation measures at heritage sites, with [jamovi](https://www.jamovi.org/), the free point-and-click statistics program built on R.

**The data are simulated** (`set.seed(2026)`): 240 fictional visitors in four countries. No real respondents.

## What is here

| Path | What it is |
|---|---|
| [EXERCISES.md](EXERCISES.md) | A mock test, Q0-Q10, with jamovi menu paths: descriptives, reliability, t-test, χ², ANOVA, correlation, linear and logistic regression, and a text for the public |
| [SOLUTIONS.md](SOLUTIONS.md) | The answers, with the numbers |
| [data/visitor_survey_simulated.csv](data/visitor_survey_simulated.csv) | The dataset, opens directly in jamovi |
| [data/generate_data.R](data/generate_data.R) | How the data were simulated, with the effects built in |
| [analysis/jmv_analysis.R](analysis/jmv_analysis.R) | The same analyses in R with [jmv](https://cran.r-project.org/package=jmv), the package jamovi runs under its menus |
| [analysis/jmv_output.txt](analysis/jmv_output.txt) | The output of that script |

## jamovi and R

Every jamovi analysis is a function of the `jmv` R package: Descriptives is `jmv::descriptives()`, One-Way ANOVA is `jmv::anovaOneW()`, and so on. In jamovi, the ⋮ application menu (top right) > Syntax mode shows the R call behind each table, so an analysis built with the menus can be rerun as a script. That is why `analysis/jmv_analysis.R` prints the same tables as jamovi.

## Run it

1. Install jamovi (https://www.jamovi.org/download.html), open `data/visitor_survey_simulated.csv` and work through [EXERCISES.md](EXERCISES.md).
2. To check in R:

   ```sh
   Rscript -e 'install.packages("jmv")'   # once
   Rscript data/generate_data.R            # rebuilds the CSV (same values)
   Rscript analysis/jmv_analysis.R
   ```

## Licence and credits

MIT, see [LICENSE](LICENSE). By Linda Angulo Lopez. Prepared with help from Claude (Anthropic); the analyses were run and checked with jmv 2.8.0 on R 4.6.1.
