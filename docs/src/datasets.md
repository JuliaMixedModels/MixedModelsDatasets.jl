# Datasets

## cbpp

**Full name:** Contagious Bovine Pleuropneumonia

**Package origin:** lme4

**Description:** Serological incidence of contagious bovine pleuropneumonia (CBPP) in zebu cattle
from a longitudinal follow-up survey of 15 commercial herds in the Boji district of Ethiopia.
Blood samples were collected quarterly to determine CBPP status. The dataset contains 56
observations with variables for herd identity, incidence count, period, and herd size. It is
a canonical example for fitting binomial GLMMs with a grouped random effect.

**APA citation:**

Lesnoff, M., Laval, G., Bonnet, P., Abdicho, S., Workalemahu, A., Kifle, D., Peyraud, A.,
Lancelot, R., & Thiaucourt, F. (2004). Within-herd spread of contagious bovine pleuropneumonia
in Ethiopian highlands. *Preventive Veterinary Medicine*, *64*(1–2), 27–40.
https://doi.org/10.1016/j.prevetmed.2004.04.002

---

## contra

**Full name:** Contraceptive Use in Bangladesh

**Package origin:** MixedModels.jl (via mlmRev / MLwiN example datasets)

**Description:** Data on use of artificial contraception by 1,934 currently married women in
Bangladesh from the 1988 Bangladesh Fertility Survey. Variables include district of residence
(60 districts), whether the woman lives in an urban or rural area, her age (centred), number
of living children, and a binary contraception use indicator. A standard example for
binomial GLMMs with a random intercept for district.

**APA citation:**

Steele, F., Diamond, I., & Amin, S. (1996). Immunization uptake in rural Bangladesh:
A multilevel analysis. *Journal of the Royal Statistical Society: Series A (Statistics in
Society)*, *159*(2), 289–299. https://doi.org/10.2307/2983285

!!! note
    The dataset itself originates from the 1988 Bangladesh Fertility Survey and is
    distributed as a worked example in the MLwiN multilevel modelling software package
    (Rasbash et al., 2009). The Steele et al. citation is the standard reference given with the
    dataset in mlmRev / MLwiN documentation.

---

## d3

**Full name:** Three-factor Crossed Benchmark Dataset

**Package origin:** MixedModels.jl (benchmark dataset)

**Description:** A large synthetic dataset with three fully crossed grouping factors (g, h, i)
and a single integer-valued covariate (u, taking values 0–29), used primarily to benchmark
the fitting of linear mixed models with three-way crossed vector random effects of the form
`y ~ 1 + u + (1 + u | g) + (1 + u | h) + (1 + u | i)`. The generic variable names
indicate it was generated for computational rather than substantive purposes.

**APA citation:**

No published citation. 

---

## dyestuff

**Full name:** Yield of Dyestuff by Batch

**Description:** Yield (in grams of standard colour) of Naphthalene Black 12B dyestuff from
five preparations made from each of six batches of the intermediate product H-acid. This
classic one-way balanced random-effects dataset (30 observations) was the primary motivating
example in the lme4 and MixedModels.jl documentation for simple scalar random effects.

**APA citation:**

Davies, O. L., & Goldsmith, P. L. (Eds.). (1972). *Statistical methods in research and
production* (4th ed., Section 6.4). Oliver and Boyd.

---

## dyestuff2

**Full name:** Yield of Dyestuff by Batch (Constructed)

**Description:** A constructed dataset of the same structure as dyestuff (six batches, five
preparations, 30 observations total) but with a large residual variance relative to the
batch variance — a scenario in which the between-batch mean square is less than the
within-batch mean square, illustrating a boundary case for variance component estimation.
The data were constructed because such cases, while occurring in practice, were rarely
published at the time.

**APA citation:**

Box, G. E. P., & Tiao, G. C. (1973). *Bayesian inference in statistical analysis*
(Section 5.1.2). Addison-Wesley.

---

## grouseticks

**Full name:** Red Grouse Tick Infestation

**Description:** Counts of sheep ticks (*Ixodes ricinus*) on the heads of red grouse chicks
(*Lagopus lagopus scoticus*) sampled in the field in Scotland during 1995–1997. The dataset
contains 403 observations (individual chick-level) nested within 118 broods within 63
geographic locations, with altitude (height above sea level) and year as covariates.
A worked example for overdispersed count (Poisson GLMM) analysis with nested grouping.

**APA citation:**

Elston, D. A., Moss, R., Boulinier, T., Arrowsmith, C., & Lambin, X. (2001). Analysis of
aggregation, a worked example: Numbers of ticks on red grouse chicks.
*Parasitology*, *122*(5), 563–569. https://doi.org/10.1017/S0031182001007740

---

## insteval

**Full name:** University Lecture/Instructor Evaluations at ETH

**Description:** Anonymised ratings of lectures and instructors by students at ETH Zürich.
The dataset contains 73,421 observations from 2,972 students evaluating 1,128 instructors
across up to 6 semesters back. Variables include student identifier (s), instructor
identifier (d), student seniority (studage), lecture recency (lectage), whether the lecture
was a service course for another department (service), department (dept), and numerical
rating (y, scale 1–5). The stated goal of the underlying survey was to identify the
"best liked professor." A medium-large example of a partially nested (students partially
crossed with instructors) mixed-effects model.

**APA citation:**

No published citation. The dataset was collected at ETH Zürich, anonymised, and simplified
for inclusion in lme4 by the package authors. It is described in:

Bates, D., Mächler, M., Bolker, B., & Walker, S. (2015). Fitting linear mixed-effects
models using lme4. *Journal of Statistical Software*, *67*(1), 1–48.
https://doi.org/10.18637/jss.v067.i01

---

## kb07

**Full name:** Kronmüller & Barr (2007) Visual World Experiment

**Description:** Response time data from a visual world eye-tracking experiment in which 56
subjects selected objects on a monitor using a cursor. The 2×2×2 factorial design
manipulated (1) whether auditory instructions maintained or broke a previously established
reference precedent (prec: maintain vs. break), (2) whether instructions were given by the
original speaker or a new speaker (spkr: old vs. new), and (3) whether the task was
performed with or without a concurrent cognitive load of six random digits (load: yes vs.
no). The dataset contains 1,789 observations of truncated reaction times (rt_trunc) and raw
reaction times (rt_raw), and is a canonical example for maximal and parsimonious
mixed-effects modelling in psycholinguistics.

**APA citation:**

Kronmüller, E., & Barr, D. J. (2007). Perspective-free pragmatics: Broken precedents and
the recovery-from-preemption hypothesis. *Journal of Memory and Language*, *56*(3), 436–455.
https://doi.org/10.1016/j.jml.2006.05.002


!!! note "Famous use of this dataset"
    Barr, D. J., Levy, R., Scheepers, C., & Tily, H. J. (2013). Random effects
    structure for confirmatory hypothesis testing: Keep it maximal. *Journal of Memory and
    Language*, *68*(3), 255–278. https://doi.org/10.1016/j.jml.2012.11.001

---

## machines

**Full name:** Machine Productivity Scores

**Description:** Scores from a designed experiment comparing three brands of industrial
machines. Six workers were chosen randomly from a factory and each worker operated each
machine three times, yielding 54 observations in a balanced crossed design. A classic example
from the split-plot/repeated-measures literature, analysed with a random intercept for
worker and a random worker-by-machine interaction.

**APA citation:**

Milliken, G. A., & Johnson, D. E. (1992). *Analysis of messy data: Vol. I. Designed
experiments* (p. 285). Chapman and Hall.

!!! note "See also"
    Pinheiro, J. C., & Bates, D. M. (2000). *Mixed-effects models in S and
    S-PLUS* (pp. 233–234). Springer. https://doi.org/10.1007/b98882

---

## ml1m

**Full name:** MovieLens 1M Ratings

**Description:** Approximately one million anonymous movie ratings (1–5 stars) from the
MovieLens collaborative filtering system, contributed by 6,040 users who each rated at least
20 of approximately 3,700 movies. Collected by the GroupLens Research Group at the
University of Minnesota. Included in MixedModels.jl as a large-scale benchmark for
two-way crossed random effects models (users crossed with movies), illustrating the
computational advantages of the blocked Cholesky approach.

**APA citation:**

Harper, F. M., & Konstan, J. A. (2016). The MovieLens datasets: History and context.
*ACM Transactions on Interactive Intelligent Systems*, *5*(4), Article 19.
https://doi.org/10.1145/2827872

---

## mmec

**Full name:** Malignant Melanoma Mortality in the European Community

**Description:** Counts of malignant melanoma deaths and expected deaths (based on age and
sex), together with a UV radiation index, across 354 counties nested within 78 regions
within 9 European nations (Belgium, West Germany, Denmark, France, Ireland, Italy,
Luxembourg, Netherlands, United Kingdom). A standard example for Poisson GLMMs with
region-level random intercepts and a national-level offset, first distributed with the
MLwiN multilevel modelling software.

**APA citation:**

Langford, I. H., Bentham, G., & McDonald, A.-L. (1998). Multilevel modelling of
geographically aggregated health data: A case study on malignant melanoma mortality and UV
exposure in the European community. *Statistics in Medicine*, *17*(1), 41–58.
https://doi.org/10.1002/(SICI)1097-0258(19980115)17:1<41::AID-SIM721>3.0.CO;2-4

---

## mrk17_exp1

**Full name:** Masson, Rabe & Kliegl (2017) Semantic Priming Experiment 1

**Description:** Response times from correct responses in a lexical decision task (LDT) in
which 73 subjects decided whether a target string was a word or a non-word. The 2×2×2
factorial design manipulated prime-target relatedness (related vs. unrelated; P), target
frequency (high vs. low; F), and target display quality (clear vs. degraded; Q). Following
Masson & Kliegl (2013), the experiment also tracked lagged target type (word vs. non-word
on the previous trial; lT) and lagged quality (lQ) as additional covariates. Correct
responses to word targets in the 300–3,000 ms range yielded 16,409 analyzable observations.
A standard RePsychLing benchmark for high-dimensional crossed random-effects models.

**APA citation:**

Masson, M. E. J., Rabe, M. M., & Kliegl, R. (2017). Modulation of additive and interactive
effects in lexical decision by trial history. *Memory & Cognition*, *45*(3), 480–492.
https://doi.org/10.3758/s13421-016-0666-z

---

## oxide

**Full name:** Oxide Layer Thickness in Semiconductor Manufacturing

**Description:** Thickness of the silicon dioxide (oxide) layer on silicon wafers measured
at three sites on each of three wafers selected from each of eight lots obtained from two
furnace sources, for a total of 72 observations. A passive data collection study from the
semiconductor industry intended to estimate variance components and identify assignable
causes of observed variability. A four-level nested design (sites within wafers within lots
within sources).

**APA citation:**

Littell, R. C., Milliken, G. A., Stroup, W. W., & Wolfinger, R. D. (1996). *SAS system for
mixed models* (p. 155). SAS Institute.

!!! note "See also"
    Pinheiro, J. C., & Bates, D. M. (2000). *Mixed-effects models in S and S-PLUS* (Appendix A.20). Springer. https://doi.org/10.1007/b98882

---

## pastes

**Full name:** Paste Strength by Batch and Cask

**Description:** Strength measurements of a chemical paste product from 60 cask samples:
three casks are drawn from each of 10 batches, with two strength measurements per cask,
yielding a nested random-effects structure (cask nested within batch).

**APA citation:**

Davies, O. L., & Goldsmith, P. L. (Eds.). (1972). *Statistical methods in research and
production* (4th ed., Section 6.5). Oliver and Boyd.

---

## penicillin

**Full name:** Variation in Penicillin Testing

**Description:** Diameter (mm) of the zone of inhibition of bacterial growth for six
penicillin samples tested on each of 24 agar plates using the *Bacillus subtilis* plate
assay method, yielding 144 observations. Plates and samples are fully crossed (a
two-way crossed design with no interaction term). A classic example for fitting
models with crossed random effects, originating from an investigation into the variability
between penicillin samples.

**APA citation:**

Davies, O. L., & Goldsmith, P. L. (Eds.). (1972). *Statistical methods in research and
production* (4th ed., Section 6.6). Oliver and Boyd.

---

## sleepstudy

**Full name:** Reaction Times in a Sleep Deprivation Study

**Description:** Average reaction time per day (ms) on a 10-minute psychomotor vigilance
test for 18 subjects in the most severe sleep restriction arm (3 hours time-in-bed per
night) of a multi-condition sleep dose-response study. The dataset covers 10 days
(days 0–1: adaptation/training; day 2: baseline; days 3–9: sleep restriction), giving
180 observations (18 subjects × 10 days). A ubiquitous example for fitting linear
mixed models with random slopes for time.

!!! note "Prior erroneous description"
    The lme4 help page contains a slight inaccuracy: sleep restriction began after day 2 (the baseline), not day 0 (see Belenky et al., 2003, p. 2, and [lme4 GitHub issue #615](https://github.com/lme4/lme4/issues/615)).

**APA citation:**

Belenky, G., Wesensten, N. J., Thorne, D. R., Thomas, M. L., Sing, H. C., Redmond, D. P.,
Russo, M. B., & Balkin, T. J. (2003). Patterns of performance degradation and restoration
during sleep restriction and subsequent recovery: A sleep dose-response study.
*Journal of Sleep Research*, *12*(1), 1–12.
https://doi.org/10.1046/j.1365-2869.2003.00337.x

---

## verbagg

**Full name:** Verbal Aggression Item Responses

**Description:** Item responses to a 24-item questionnaire on verbal aggression administered
to 316 participants, yielding 7,584 observations. Participants indicated whether they would
*want* to react aggressively and whether they would *actually* react, across scenarios
involving frustrating situations and three aggression modes (curse, scold, shout) in two
situational types (self-to-blame vs. other-to-blame). Variables include trait anger
(STAXI; anger), gender, behavior type (btype), situation type (situ), mode, polytomous
response (resp: no/perhaps/yes), and a binary dichotomization thereof (r2: N/Y). Originally
collected by Vansteelandt (2000) and used throughout De Boeck & Wilson (2004) to illustrate
explanatory item response models.

**APA citation:**

De Boeck, P., & Wilson, M. (Eds.). (2004). *Explanatory item response models:
A generalized linear and nonlinear approach*. Springer.
https://doi.org/10.1007/978-1-4757-3990-9

!!! note "Original data collection"
    The original data collection is attributed to Vansteelandt, K. (2000).
    *Psychometric modelling of verbal aggression* [Doctoral dissertation, KU Leuven]. The
    dataset was formerly available from the UC Berkeley BEAR Center (no longer accessible;
    archived at https://web.archive.org/web/20221128003829/https://old.bear.berkeley.edu/page/materials-explanatory-item-response-models).
