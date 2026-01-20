# Models

A progression model for repeated measures (PMRM) is a longitudinal
continuous-time nonlinear model of a progressive disease. The `pmrm`
package implements PMRMs from Raket (2022). This vignette defines the
specific models that the package supports, using the same
parameterization as the underlying code.

First, we define a base model to characterize disease progression in a
one-arm study. Then, we extend the base model to a randomized controlled
parallel clinical trial with $K$ study arms with different
interventions.

## Base model

The base model characterizes a progressive disease in a one-arm study
with at most one clinical intervention:

$$\begin{aligned}
y_{ij} & {= f\left( t_{ij}|\xi,\alpha \right) + W_{i}\gamma + e_{ij}}
\end{aligned}$$

The following subsections describe the components of the base model.

### Data

For patient $i$ ($i = 1,\ldots,I$) at clinical visit $j$ (j = 1, , J),
$y_{ij}$ is the observed clinical outcome. $y_{ij}$ could be a clinical
measure of disease severity or of the patient’s health. Since the model
accounts for baseline, $y_{ij}$ should not already be a change from
baseline. Some clinical outcomes may have missing values. However, the
baseline outcome $y_{i1}$ must be non-missing for all patients
($i = 1,\ldots,I$).

$t_{ij}$ is the continuous time since baseline. A continuous time of 0
indicates the scheduled time of the baseline visit. Time $j = 1$ denotes
the baseline visit, and so $t_{i1}$ should be close to 0 for
$i = 1,\ldots,I$. At baseline, we assume treatment has not been
administered yet, so all study arms should have the same expected
outcome if randomization is conducted properly.

Let $N$ be the total number of records in the data, including records
with missing $y_{ij}$ values. Records with missing $y_{ij}$ values are
excluded from the model. Other than a subset of $y_{ij}$ values missing
at random, no other quantity in the model (data or parameters) may be
missing.

### Residuals

$e_{ij}$ is the residual of patient $i$ at visit $j$. Residuals from
different patients are independent.
$\Sigma = \text{Var}\left( e_{i1},\ldots,e_{iJ} \right)$ is the
$J \times J$ unstructured covariance matrix of residuals for patient
$i$. The model assumes all patients share the same covariance $\Sigma$.

We parameterize $\Sigma$ as follows:

$$\begin{aligned}
\Sigma & {= D\Lambda D}
\end{aligned}$$

$D$ is a $J \times J$ diagonal matrix with diagonal
$\sigma = \left( \sigma_{1},\ldots,\sigma_{J} \right)$ (the
visit-specific standard deviation parameters). To constrain
$\sigma_{j} > = 0$ during maximum likelihood estimation, we define a
latent parameter vector $\phi = \left( \phi_{1},\ldots,\phi_{J} \right)$
such that $\phi_{j} = \log\left( \sigma_{j} \right)$ for
$j = 1,\ldots,J$.

$\Lambda$ is the $J \times J$ correlation matrix among visits within a
patient. Define:

$$\begin{aligned}
\Lambda & {= LL^{T}}
\end{aligned}$$

$L$ is a lower triangular Cholesky factor of the correlation matrix
$\Lambda$, and it is expressed in terms of a vector
$\rho = \left( \rho_{1},\ldots,\rho_{J{(J - 1)}/2} \right)$ of
$\frac{J(J - 1)}{2}$ latent parameters.[¹](#fn1)

The model estimates parameter vectors $\phi$ and $\rho$ with maximum
likelihood.

### Handling missing outcomes

Let $y_{i} = \left( y_{i1},\ldots,y_{iJ} \right)$ be the vector of
outcomes of patient $i$. Suppose $q$ outcomes in $y_{i}$ are missing,
and let $Q$ be an $(I - q) \times I$ subsetting matrix such that
$Qy_{i}$ is the vector of observed values in $y_{i}$. Then, a simple
linear transformation shows:

$$\begin{array}{r}
{Qy_{i} \sim \text{MVN}\left( QE\left( y_{i} \right),Q\Sigma Q^{T} \right)}
\end{array}$$ The modeling code estimates the parameters that maximize
the sum of the above marginal likelihoods across all patients
($i = 1,\ldots,I$). The remainder of this vignette parameterizes the
expectation $E(y)$.

### Covariate adjustment

$\gamma$ is a vector of $v$ fixed effect parameters for concomitant
covariates, and $W_{i}$ is a constant model matrix for the covariates
for patient $i$. Define:

$$\begin{array}{r}
{W = \begin{bmatrix}
W_{1} \\
\vdots \\
W_{I}
\end{bmatrix}}
\end{array}$$

Matrix $W$ has $V$ columns, and each column is centered so that its mean
is 0. That way, the reference level at $\gamma = (0,\ldots,0)$
represents the means of the covariate values in the data. To help
initial value specification, columns with positive variance are also
divided by their respective standard deviations.

### Mean function

$f\left( t|\xi,\alpha \right)$ is the expected clinical outcome at
continuous time $t$ given $\gamma = (0,\ldots,0)$ (without intervention
(from an active treatment arm) or covariate adjustment). We compute
$f\left( t|\xi,\alpha \right)$ by interpolating a spline at time
$t$.[²](#fn2) We construct the spline using
`RTMB::splinefun(x = xi, y = alpha)`. This fitted spline is uniquely
determined by the knot vector
$\xi = \left( \xi_{1},\ldots,\xi_{S} \right)$ and the corresponding
vector $\alpha = \left( \alpha_{1},\ldots,\alpha_{S} \right)$ of values
on the outcome scale. Specifically, for $s = 1,\ldots,S$:

$$\begin{aligned}
{f\left( \xi_{s}|\xi,\alpha \right)} & {= \alpha_{s}}
\end{aligned}$$

The parameter vector $\alpha$ is estimated with maximum likelihood.

The knots in $\xi$ are fixed and supplied by the user. The knot values
are usually the scheduled visit times specified in the study
protocol.[³](#fn3)

## Proportional decline model

The proportional decline model characterizes therapeutic benefit (or
worsening) as a pointwise reduction (or increase) in severity on the
clinical outcome scale. The expected amount of therapeutic change is
assumed to be proportional to the amount of time elapsed since baseline.

### Definition

Define scalar $\beta_{k}$ for each study arm $k$ ($k = 1,\ldots,K$). Let
$k = 1$ denote the control arm, and let $b(i) \in \{ 1,\ldots,K\}$
indicate the study arm of patient $i$. The proportional decline model is
defined as:

$$\begin{aligned}
y_{ij} & {= \mu_{ij} + e_{ij}}
\end{aligned}$$

where:

$$\begin{aligned}
\mu_{ij} & {= \left( 1 - \beta_{b{(i)}} \right)\left( f\left( t_{ij}|\xi,\alpha \right) - f\left( 0|\xi,\alpha \right) \right) + f\left( 0|\xi,\alpha \right) + W_{i}\gamma}
\end{aligned}$$

### Constraints

The model imposes a constraint so that the control arm ($k = 1$) is the
reference arm:

$$\begin{array}{r}
{\beta_{k} = \begin{cases}
0 & {k = 1} \\
\theta_{k - 1} & {k = 2,\ldots,K}
\end{cases}}
\end{array}$$

The model estimates latent parameters $\theta_{1},\ldots,\theta_{K - 1}$
using maximum likelihood.

### Interpretation

$f\left( t_{ij}|\xi,\alpha \right) - f\left( 0|\xi,\alpha \right)$
quantifies the decline from baseline to visit $j$ in the health of
patient $i$ due to the progression of the disease. For $k > 1$,
$1 - \beta_{k}$ is the ratio of the decline of arm $k$ to the decline of
the control arm. Thus, $\beta_{k}$ is the *reduction in proportional
decline* due to the therapy in study arm $k$.

### Baseline

At the baseline visit $j = 1$, we have $t_{i1} = 0$ for
$i = 1,\ldots,I$, and thus:

$$\begin{aligned}
y_{i1} & {= f\left( 0|\xi,\alpha \right) + W_{i}\gamma + e_{ij}}
\end{aligned}$$

This property constrains the expected outcomes of all study arms to be
equal at baseline. This is known as constrained longitudinal data
analysis (cLDA) (Wang et al. 2022).

## Non-proportional slowing model

The non-proportional slowing model characterizes the benefit from
treatment as a slowing in the disease progression trajectory. Whereas
the proportional decline model expresses treatment effects on the
clinical outcome scale, the non-proportional slowing model expresses
treatment effects on the continuous time scale. As explained in the
“Interpretation” section, this model assumes each treatment does not
noticeably accelerate the rate of disease progression.

### Definition

Define scalar $\beta_{kj}$ for each study arm $k$ ($k = 1,\ldots,K$) and
visit $j$ ($j = 1,\ldots,J$). Let $k = 1$ denote the control arm, and
let $b(i) \in \{ 1,\ldots,K\}$ indicate the study arm of patient $i$.
Define $u_{ij}$ as follows:

$$\begin{array}{r}
{u_{ij} = \left( 1 - \beta_{b{(i)}j} \right)t_{ij}}
\end{array}$$

The non-proportional slowing model is defined as:

$$\begin{aligned}
y_{ij} & {= \mu_{ij} + e_{ij}}
\end{aligned}$$

where:

$$\begin{aligned}
\mu_{ij} & {= f\left( u_{ij}|\xi,\alpha \right) + W_{i}\gamma}
\end{aligned}$$

### Constraints

The model imposes constraints on the $\beta_{kj}$ parameters. The
purpose is to preserve identifiability at baseline, with the control arm
as the reference arm. We impose these constraints by expressing each
non-constant $\beta_{kj}$ in terms of a latent scalar parameter
$\theta_{{(k - 1)}{(j - 1)}}$:

$$\begin{array}{r}
{\beta_{kj} = \begin{cases}
0 & {k = 1{\mspace{6mu}\text{or}\mspace{6mu}}j = 1} \\
\theta_{{(k - 1)}{(j - 1)}} & {k \in \{ 2,\ldots,K\}{\mspace{6mu}\text{and}\mspace{6mu}}j \in \{ 2,\ldots,J\}}
\end{cases}}
\end{array}$$

The model estimates the latent parameters
$\theta_{11},\ldots,\theta_{{(K - 1)}{(J - 1)}}$ with maximum
likelihood.

### Interpretation

$\beta_{kj}$ is a span of time: it is the relative slowing of the
disease progression trajectory. In other words, $\beta_{kj}$ is the
expected amount of time (or quality time) that patients gain in their
lives due to therapy $k$.

$u_{ij}$ is the *effective* time along the disease progression
trajectory of patient $i$ at visit $j$. If the active therapy of patient
$i$ is efficacious, then the patient will experience disease progression
more slowly than they would have in the control group, and the values of
$u_{ij}$ will be less than the corresponding values of $t_{ij}$. In
other words, the treatment effect is a time shift.

If the treatment slows disease, then the fitted response
$f\left( u_{ij}|\xi,\alpha \right)$ is an interpolation of the control
arm at an earlier time point. But if the treatment *accelerates*
disease, then the fitted response is a significant extrapolation, and
the model will not fit well. Thus, the non-proportional slowing model
assumes that no treatment is noticeably worse than control.

### Baseline

At the baseline visit $j = 1$, we have $t_{i1} = 0$ for
$i = 1,\ldots,I$, and thus $u_{i1} = 0$. The outcome for patient $i$
becomes:

$$\begin{aligned}
y_{ij} & {= f\left( 0|\xi,\alpha \right) + W_{i}\gamma + e_{ij}}
\end{aligned}$$

As with the proportional decline model, this property constrains the
expected outcomes of all study arms to be equal at baseline. In other
words, the model uses constrained longitudinal data analysis (cLDA)
(Wang et al. 2022).

### Prediction

The modeling functions in `pmrm` report the estimate and standard error
of each parameter, along wit the mean outcome for each study arm at each
of a set of user-defined time points. The covariate adjustment term
$W_{i}\gamma$ is omitted.

The `RTMB` package facilitates predictions using the `ADVECTOR()`
function, which leverages the gradient and the delta method to calculate
an estimate and standard error of user-defined quantities. This happens
during the model-fitting, so the
[`predict()`](https://rdrr.io/r/stats/predict.html) method cannot accept
new ad hoc data.

## References

Donohue, Michael C, Oliver Langford, Philip S. Insel, Christopher H. van
Dyck, Ronald C Petersen, Suzanne Craft, Gopalan Sethuraman, Rema Raman,
and Paul S. Aisen. 2023. “Natural Cubic Splines for the Analysis of
Alzheimer’s Clinical Trials.” *Pharmaceutical Statistics* 22 (3):
508–19. <https://doi.org/10.1002/pst.2285>.

Raket, Lars Lau. 2022. “Progression Models for Repeated Measures:
Estimating Novel Treatment Effects in Progressive Diseases.” *Statistics
in Medicine* 41 (28): 5537–57. <https://doi.org/10.1002/sim.9581>.

Wang, Guoqiao, Lei Liu, Yan Li, Andrew J Aschenbrenner, Paul Delmer, Lon
S Schneidder, Richard E Kennedy, Gary R Cutter, and Chengjie Xiong.
2022. “Proportional Constrained Longitudinal Data Analysis Models for
Clinical Trials in Sporadic Alzheimer’s Disease.” *Alzheimer’s and
Dementia* 8 (1). <https://doi.org/10.1002/trc2.12286>.

------------------------------------------------------------------------

1.  In R, `RTMB::unstructured(J)$corr(rho)` maps latent parameter vector
    `rho` to the $J \times J$ correlation matrix $LL^{T}$.

2.  The user can select the specific method for fitting the spline.

3.  However, both the discrete visit designations in the data and the
    spline knots in the model may need adjustment if many visits
    occurred off-schedule, as was the case for neurodegeneration studies
    during the COVID-19 pandemic. (See Donohue et al. (2023)).
