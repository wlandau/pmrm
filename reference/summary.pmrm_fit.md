# Summarize a PMRM.

Summarize a progression model for repeated measures (PMRM).

## Usage

``` r
# S3 method for class 'pmrm_fit'
summary(object, ...)
```

## Arguments

- object:

  A fitted model object of class `"pmrm_fit"`.

- ...:

  Not used.

## Value

A `tibble` with one row and columns with the following columns:

- `model`: `"decline"` or `"slowing"`.

- `parameterization`: `"proportional"` or `"nonproportional"`.

- `log_likelihood`: maximized log likelihood of the model fit.

- `n_observations`: number of non-missing observations in the data.

- `n_parameters`: number of true model parameters.

- `aic`: Akaike information criterion.

- `bic`: Bayesian information criterion.

This format is designed for easy comparison of multiple fitted models.

## See also

Other model comparison:
[`AIC.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/AIC.pmrm_fit.md),
[`BIC.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/BIC.pmrm_fit.md),
[`confint.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/confint.pmrm_fit.md),
[`deviance.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/deviance.pmrm_fit.md),
[`logLik.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/logLik.pmrm_fit.md)

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
  summary(fit)
#> # A tibble: 1 × 7
#>   model  parameterization log_likelihood n_observations n_parameters   aic   bic
#>   <chr>  <chr>                     <dbl>          <int>        <int> <dbl> <dbl>
#> 1 decli… proportional             -2114.           1500           24 4277. 4404.
```
