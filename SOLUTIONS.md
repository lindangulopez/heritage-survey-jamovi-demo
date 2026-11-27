# Solutions

Numbers from `Rscript analysis/jmv_analysis.R` (jmv 2.8.0, R 4.6.1), the same tables jamovi shows. The full output is in [analysis/jmv_output.txt](analysis/jmv_output.txt). The data are simulated with known effects (see `data/generate_data.R`), so the analyses should find them: hot visits are less comfortable, concern about climate drives acceptability, Belgium is a little more accepting and Italy a little less.

**Q0.** A Likert item is ordinal: the gap between 1 and 2 is not known to equal the gap between 4 and 5. Treating items, and above all a mean of several items, as continuous is common and usually robust with 5 points and n = 240, but say so in the methods and check with a non-parametric test (Mann-Whitney in Q4, Spearman in Q7). If both agree, the choice does not change the conclusion.

**Q1.** `acc_score` is each visitor's average acceptability across the four measures, still on the 1-5 scale: 1 = finds every measure unacceptable, 5 = accepts all of them.

**Q2.** Summer: mean 3.68, median 4, SD 0.82 (n = 111). Winter: mean 4.67, median 5, SD 0.59 (n = 129). Visitors are less comfortable in summer, and their answers vary more.

**Q3.** Cronbach's α = 0.84, McDonald's ω = 0.84: good, the four items can be averaged. Item-rest correlations 0.65-0.70; dropping any item lowers α (0.79-0.81), so keep all four.

**Q4.** Levene's test is significant (variances differ), so report Welch's t: t(196.2) = -10.57, p < .001, Cohen's d = -1.39, a large effect. Mann-Whitney agrees (U = 2616, p < .001, rank-biserial r = 0.63).

**Q5.** Acceptance (Oui): Belgique 63.3 %, Royaume-Uni 56.7 %, France 46.7 %, Italie 36.7 %. χ²(3) = 9.80, p = .020: acceptance differs by country. Cramér's V = 0.20, a weak to moderate link. (Phi is only defined for 2 × 2 tables, hence NaN here.)

**Q6.** Welch's F(3, 130.9) = 4.47, p = .005 (Fisher's F(3, 236) = 4.80, p = .003). Means: Belgique 3.45, France 3.13, Royaume-Uni 3.00, Italie 2.84. Tukey: Belgique > Italie (difference 0.60, p = .002) and Belgique > Royaume-Uni (0.45, p = .038); no other pair differs.

**Q7.** `climate_concern` and `acc_score`: r = 0.58, ρ = 0.58, p < .001, a strong positive link. `temp_c` and `thermal_comfort`: r = -0.60, p < .001 (hotter, less comfortable). Comfort is not linked to acceptability (r = 0.00, p = .95).

**Q8.** R² = 0.38, adjusted R² = 0.37. Each extra point of climate concern adds 0.51 to the score (β = 0.58, p < .001). Comfort has no effect (0.02, p = .77). Compared with France, Belgium is 0.40 higher (p = .003); Italy and the United Kingdom do not differ from France.

**Q9.** Odds ratio 1.63 (p < .001): each extra point of climate concern multiplies the odds of saying yes to interventions by about 1.6. The model explains little on its own (McFadden R² = 0.04, Nagelkerke R² = 0.08): concern matters, but many other things shape a yes or no.

**Q10.** One possible panel text: « En été, les visiteurs ont nettement plus chaud et se sentent moins à l'aise qu'en hiver. Plus on pense que le climat menace un monument, plus on accepte des mesures pour le protéger, même une fermeture partielle ou un billet plus cher. Les visiteurs belges sont les plus ouverts à ces mesures, les visiteurs italiens les plus réservés. »
