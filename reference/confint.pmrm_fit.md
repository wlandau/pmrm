# Confidence intervals of parameters

Compute confidence intervals of the family of model parameters specified
in `parm`.

## Usage

``` r
# S3 method for class 'pmrm_fit'
confint(
  object,
  parm = c("theta", "beta", "alpha", "gamma", "sigma", "phi", "rho", "Sigma", "Lambda"),
  level = 0.95,
  ...
)
```

## Arguments

- object:

  A fitted model object of class `"pmrm_fit"`.

- parm:

  Character string, name of a family of parameters to compute confidence
  intervals.

- level:

  Numeric scalar between 0 and 1, confidence level.

- ...:

  Not used.

## Value

The `tibble` returned by
[`pmrm_estimates()`](https://wlandau.github.io/pmrm/reference/pmrm_estimates.md),
except without the columns with point estimates or standard errors.

## Details

See
[`vignette("models", package = "pmrm")`](https://wlandau.github.io/pmrm/articles/models.md)
for details.

## See also

Other model comparison:
[`AIC.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/AIC.pmrm_fit.md),
[`BIC.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/BIC.pmrm_fit.md),
[`deviance.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/deviance.pmrm_fit.md),
[`logLik.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/logLik.pmrm_fit.md),
[`summary.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/summary.pmrm_fit.md)

## Examples

``` r
  set.seed(0L)
  simulation <- pmrm_simulate_decline_proportional(
    visit_times = seq_len(5L) - 1,
    gamma = c(1, 2)
  )
  fit <- pmrm_model_decline_proportional(
    data = simulation,
    outcome = "y",
    time = "t",
    patient = "patient",
    visit = "visit",
    arm = "arm",
    covariates = ~ w_1 + w_2
  )
  confint(fit)
#> # A tibble: 2 × 4
#>   parameter arm    lower upper
#>   <chr>     <ord>  <dbl> <dbl>
#> 1 theta     arm_2 0.0492 0.261
#> 2 theta     arm_3 0.119  0.325
```
