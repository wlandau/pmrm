# Estimated covariance matrix

Extract estimated covariance matrix among visits within patients.

## Usage

``` r
# S3 method for class 'pmrm_fit'
VarCorr(x, sigma = NA, ...)
```

## Arguments

- x:

  A fitted model object of class `"pmrm_fit"` produced by
  [`pmrm_model_decline()`](https://wlandau.github.io/pmrm/reference/pmrm_model_decline.md)
  or
  [`pmrm_model_slowing()`](https://wlandau.github.io/pmrm/reference/pmrm_model_slowing.md).

- sigma:

  Not used for `pmrm`.

- ...:

  Not used.

## Value

A matrix `J` rows and `J` columns, where `J` is the number of scheduled
visits in the clinical trial.

## See also

Other estimates and predictions:
[`coef.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit_decline.md),
[`coef.pmrm_fit_slowing()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit_slowing.md),
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
  simulation <- pmrm_simulate_decline(
    visit_times = seq_len(5L) - 1,
    gamma = c(1, 2)
  )
  fit <- pmrm_model_decline(
    data = simulation,
    outcome = "y",
    time = "t",
    patient = "patient",
    visit = "visit",
    arm = "arm",
    covariates = ~ w_1 + w_2
  )
  VarCorr(fit)
#>              visit_1      visit_2     visit_3      visit_4      visit_5
#> visit_1  1.014197254 -0.005377563 -0.06587390  0.029608749 -0.100061354
#> visit_2 -0.005377563  0.944702148 -0.08021265 -0.073493333  0.056003869
#> visit_3 -0.065873896 -0.080212654  1.04399327 -0.045969231  0.148149051
#> visit_4  0.029608749 -0.073493333 -0.04596923  0.946986875  0.001358265
#> visit_5 -0.100061354  0.056003869  0.14814905  0.001358265  1.015609461
```
