# Predict new outcomes

Return the expected values, standard errors, and confidence intervals of
new outcomes.

## Usage

``` r
# S3 method for class 'pmrm_fit'
predict(object, data = object$data, adjust = TRUE, confidence = 0.95, ...)
```

## Arguments

- object:

  A fitted model object of class `"pmrm_fit"` produced by
  [`pmrm_model_decline()`](https://wlandau.github.io/pmrm/reference/pmrm_model_decline.md)
  or
  [`pmrm_model_slowing()`](https://wlandau.github.io/pmrm/reference/pmrm_model_slowing.md).

- data:

  A `tibble` or data frame with one row per patient visit. This is the
  new data for making predictions. It must have all the same columns as
  the original you fit with the model, except that the outcome column
  can be entirely absent. `object$data` is an example dataset that will
  work. It is just like the original data, except that rows with missing
  responses are removed, and the remaining rows are sorted by patient ID
  and categorical scheduled visit.

- adjust:

  `TRUE` or `FALSE`. `adjust = TRUE` returns estimates and inference for
  covariate-adjusted `mu_ij` values (defined in
  [`vignette("models", package = "pmrm")`](https://wlandau.github.io/pmrm/articles/models.md))
  for new data. `adjust = FALSE` instead returns inference on
  `mu_ij - W %*% gamma`, the non-covariate-adjusted predictions useful
  in plotting a continuous disease progression trajectory in
  [`plot.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/plot.pmrm_fit.md).

- confidence:

  Numeric between 0 and 1, the confidence level to use in the 2-sided
  confidence intervals.

- ...:

  Not used.

## Value

A `tibble` with one row for each row in the `data` argument and columns
`"estimate"`, `"standard_error"`, `"lower"`, and `"upper"`. Columns
`"lower"` and `"upper"` are lower and upper bounds of 2-sided confidence
intervals on the means. (The confidence intervals are not actually truly
prediction intervals because they do not include variability from
residuals.)

## See also

Other estimates and predictions:
[`VarCorr.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/VarCorr.pmrm_fit.md),
[`coef.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit_decline.md),
[`coef.pmrm_fit_slowing()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit_slowing.md),
[`fitted.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/fitted.pmrm_fit_decline.md),
[`fitted.pmrm_fit_slowing()`](https://wlandau.github.io/pmrm/reference/fitted.pmrm_fit_slowing.md),
[`plot.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/plot.pmrm_fit.md),
[`pmrm_estimates()`](https://wlandau.github.io/pmrm/reference/pmrm_estimates.md),
[`pmrm_marginals()`](https://wlandau.github.io/pmrm/reference/pmrm_marginals.md),
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
  new_data <- pmrm_simulate_decline(
    patients = 1,
    visit_times = seq_len(5L) - 1,
    gamma = c(1, 2)
  )
  new_data$y <- NULL # Permitted but not strictly necessary.
  predict(fit, new_data)
#> # A tibble: 5 × 7
#>   arm   visit    time estimate standard_error  lower  upper
#>   <ord> <ord>   <dbl>    <dbl>          <dbl>  <dbl>  <dbl>
#> 1 arm_1 visit_1     0   -2.52          0.0670 -2.65  -2.39 
#> 2 arm_1 visit_2     1    1.74          0.0705  1.60   1.88 
#> 3 arm_1 visit_3     2    4.12          0.0824  3.96   4.28 
#> 4 arm_1 visit_4     3   -0.432         0.0804 -0.589 -0.274
#> 5 arm_1 visit_5     4    1.86          0.0835  1.70   2.03 
```
