# Simulation

This vignette explains how to simulate longitudinal clinical disease
progression datasets from each of the models in `pmrm`. For details
about the models, including definitions of all the notation used below,
please see the “Models” vignette.

## Residuals

The user supplies the $J \times J$ residual covariance matrix
$\Sigma$[¹](#fn1). Independently for each patient $i$
($i = 1,\ldots,I$), the package simulates a vector of patient-specific
residuals from a multivariate normal distribution:

$$\begin{array}{r}
{\begin{bmatrix}
e_{i1} \\
\vdots \\
e_{iJ}
\end{bmatrix} \sim \text{MVN}(0,\Sigma)}
\end{array}$$

## Covariates

Each column of the covariate adjustment model matrix $W$ is constructed
by simulating independent draws from a Normal(0, 1) distribution and
then subtracting the mean. The columns of $W$ are independent and
centered at zero. The user chooses the fixed effect vector $\gamma$ to
generate data.

## Continuous time

As previously mentioned, time $j = 1$ denotes the baseline visit, and so
$t_{i1} = 0$ for $i = 1,\ldots,I$. For $j > 1$, we simulate each
observation time $t_{ij}$ as follows:

$$\begin{aligned}
t_{ij}^{*} & {\sim \text{Normal}\left( t_{j}^{*},\tau^{2} \right)} \\
t_{ij} & {= \left| t_{ij}^{*} \right|}
\end{aligned}$$

where $t_{1}^{*}$ ($j = 1,\ldots,J$) are user-specified visit times
(which could be different from the knots $\xi$) and $\tau^{2}$ is a
user-specified variance.

## Splines

The knot vector $\xi = \left( \xi_{1},\ldots,\xi_{S} \right)$ and
corresponding outcome vector
$\alpha = \left( \alpha_{1},\ldots,\alpha_{S} \right)$ uniquely
determine a fitted spline. Both vectors are supplied by the user. We
compute $f\left( t|\xi,\alpha \right)$ using the function provided by
`RTMB::splinefun()`.

## Proportional decline outcomes

For the proportional decline model, we use the spline basis to calculate
the value $m_{ij}$ of the mean function for each simulated continuous
time point $t_{ij}$:

$$\begin{aligned}
m_{ij} & {= f\left( t_{ij}|\xi,\alpha \right)}
\end{aligned}$$

The user supplies values for parameters
$\theta_{1},\ldots,\theta_{K - 1}$. This gives us known values for all
of $\beta_{1},\ldots,\beta_{K}$. We calculate $y_{ij}$ as follows:

$$\begin{aligned}
y_{ij} & {= \left( 1 - \beta_{b{(i)}} \right)\left( m_{ij} - m_{i1} \right) + m_{i1} + W_{i}\gamma + e_{ij}}
\end{aligned}$$

The output dataset includes simulated clinical outcomes $y_{ij}$,
simulated observed times $t_{ij}$, the columns of $W$, the values
$m_{ij}$ of the mean function, the evaluated values
$h_{s}\left( t_{ij}|\xi \right)$ of the spline basis functions, and the
residuals $e_{ij}$.

## Non-proportional slowing outcomes

For the non-proportional slowing model, the user supplies the values of
true parameters $\theta_{11},\ldots,\theta_{{(K - 1)}{(J - 1)}}$. This
gives us a known value of $\beta_{kj}$ for $k = 1,\ldots,K$ and
$j = 1,\ldots,J$. Recall that $u_{ij}$ is the effective time point along
the disease progression trajectory of patient $i$ at visit $j$:

$$\begin{array}{r}
{u_{ij} = \left( 1 - \beta_{b{(i)}j} \right)t_{ij}}
\end{array}$$

We calculate each value $m_{ij}$ of the mean function by evaluating the
spline at $u_{ij}$ instead of $t_{ij}$:

$$\begin{aligned}
m_{ij} & {= f\left( u_{ij}|\xi,\alpha \right)}
\end{aligned}$$

Then, $y_{ij}$ for the non-proportional slowing model is:

$$\begin{aligned}
y_{ij} & {= m_{ij} + W_{i}\gamma + e_{ij}}
\end{aligned}$$

The output dataset includes simulated clinical outcomes $y_{ij}$,
simulated observed times $t_{ij}$, the corresponding effective times
$u_{ij}$, the columns of $W$, the values $m_{ij}$ of the mean function
evaluated at the effective times $u_{ij}$, the values
$h_{s}\left( u_{ij}|\xi \right)$ of the spline basis functions evaluated
at the effective times, and the residuals $e_{ij}$.

------------------------------------------------------------------------

1.  $\Sigma$ can be computed from latent parameter vectors $\sigma$ and
    $\rho$ using `pmrm_compute_Sigma()`.
