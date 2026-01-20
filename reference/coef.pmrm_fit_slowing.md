# Nonlinear fixed effects: non-proportional slowing model.

Extract the `theta` parameter matrix from the non-proportional slowing
model. `theta` measures the slowing of disease progression at each visit
relative to control. Does not include the covariate adjustment
parameters `gamma`.

## Usage

``` r
# S3 method for class 'pmrm_fit_slowing'
coef(object, ...)
```

## Arguments

- object:

  A fitted model object of class `"pmrm_fit"` produced by
  [`pmrm_model_decline()`](https://wlandau.github.io/pmrm/reference/pmrm_model_decline.md)
  or
  [`pmrm_model_slowing()`](https://wlandau.github.io/pmrm/reference/pmrm_model_slowing.md).

- ...:

  Not used.

## Value

A named matrix of `theta` estimates with one row for each active study
arm and one column for each post-baseline scheduled visit. Row and
column names label the arms and visits, respectively.

## Details

See
[`vignette("models", package = "pmrm")`](https://wlandau.github.io/pmrm/articles/models.md)
for details.

## See also

Other estimates and predictions:
[`VarCorr.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/VarCorr.pmrm_fit.md),
[`coef.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit_decline.md),
[`fitted.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/fitted.pmrm_fit_decline.md),
[`fitted.pmrm_fit_slowing()`](https://wlandau.github.io/pmrm/reference/fitted.pmrm_fit_slowing.md),
[`plot.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/plot.pmrm_fit.md),
[`pmrm_estimates()`](https://wlandau.github.io/pmrm/reference/pmrm_estimates.md),
[`pmrm_marginals()`](https://wlandau.github.io/pmrm/reference/pmrm_marginals.md),
[`predict.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/predict.pmrm_fit.md),
[`residuals.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/residuals.pmrm_fit.md),
[`vcov.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/vcov.pmrm_fit_decline.md),
[`vcov.pmrm_fit_slowing()`](https://wlandau.github.io/pmrm/reference/vcov.pmrm_fit_slowing.md)

## Examples

``` r
  set.seed(0L)
  simulation <- pmrm_simulate_slowing(
    visit_times = seq_len(5L) - 1,
    gamma = c(1, 2)
  )
  fit <- pmrm_model_slowing(
    data = simulation,
    outcome = "y",
    time = "t",
    patient = "patient",
    visit = "visit",
    arm = "arm",
    covariates = ~ w_1 + w_2
  )
  coef(fit)
#>         visit_2    visit_3   visit_4   visit_5
#> arm_2 0.5065435 -0.1085924 0.1513809 0.2735157
#> arm_3 0.5782039  0.1676738 0.1685848 0.2740861
```
