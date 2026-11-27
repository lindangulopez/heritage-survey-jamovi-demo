# Simulated visitor survey: comfort, climate perception and acceptability
# of conservation measures at heritage sites in four countries.
# All values are SIMULATED (fixed seed), for practice only. No real respondents.
#
# Run from the repository root:  Rscript data/generate_data.R

set.seed(2026)
n_per_country <- 60
countries <- c("France", "Royaume-Uni", "Italie", "Belgique")
n <- n_per_country * length(countries)

country     <- rep(countries, each = n_per_country)
site_type   <- sample(c("Musee", "Monument exterieur"), n, replace = TRUE)
season      <- sample(c("Ete", "Hiver"), n, replace = TRUE)
age_group   <- sample(c("18-29", "30-44", "45-64", "65+"), n, replace = TRUE,
                      prob = c(0.25, 0.25, 0.30, 0.20))
first_visit <- sample(c("Oui", "Non"), n, replace = TRUE, prob = c(0.6, 0.4))

# Temperature at the time of the visit (degrees C): hotter in summer and in Italy
temp_c <- round(ifelse(season == "Ete", 27, 9) +
                ifelse(country == "Italie", 3, 0) +
                rnorm(n, 0, 3), 1)

likert <- function(x) pmin(5, pmax(1, round(x)))

# Comfort (1 = tres inconfortable ... 5 = tres confortable): lower when hot, lower outdoors
thermal_comfort  <- likert(4.6 - 0.07 * (temp_c - 18) -
                           0.4 * (site_type == "Monument exterieur") + rnorm(n, 0, 0.8))
humidity_comfort <- likert(3.6 - 0.03 * (temp_c - 18) + rnorm(n, 0, 0.9))

# "Le changement climatique menace ce patrimoine" (1 = pas du tout d'accord ... 5 = tout a fait)
climate_concern <- likert(3.4 + 0.3 * (age_group == "18-29") -
                          0.2 * (age_group == "65+") + rnorm(n, 0, 1))

# Acceptability of four measures (1 = inacceptable ... 5 = tout a fait acceptable),
# driven by one attitude linked to climate concern
latent <- 0.55 * (climate_concern - 3) + rnorm(n, 0, 0.7) +
          ifelse(country == "Belgique", 0.3, 0) - ifelse(country == "Italie", 0.2, 0)
acc_closure <- likert(3.2 + latent + rnorm(n, 0, 0.7))   # fermeture partielle en canicule
acc_ac      <- likert(3.0 + latent + rnorm(n, 0, 0.8))   # climatisation des salles
acc_replica <- likert(2.4 + latent + rnorm(n, 0, 0.8))   # replique a la place de l'original
acc_ticket  <- likert(2.8 + latent + rnorm(n, 0, 0.8))   # billet plus cher pour la conservation

# Overall yes/no answer: "Accepteriez-vous des interventions pour proteger ce site ?"
accept_intervention <- ifelse(runif(n) < plogis(-0.4 + 1.1 * latent), "Oui", "Non")

survey <- data.frame(
  id = sprintf("R%03d", seq_len(n)),
  country, site_type, season, age_group, first_visit, temp_c,
  thermal_comfort, humidity_comfort, climate_concern,
  acc_closure, acc_ac, acc_replica, acc_ticket,
  accept_intervention
)

write.csv(survey, "data/visitor_survey_simulated.csv", row.names = FALSE)
cat("Wrote", nrow(survey), "rows to data/visitor_survey_simulated.csv\n")
