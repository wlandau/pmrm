# Treatment effect parameter covariance matrix

Extract the covariance matrix of the treatment effect parameters of a
progression model for repeated measures.

## Usage

``` r
# S3 method for class 'pmrm_fit'
vcov(object, ...)
```

## Arguments

- object:

  A fitted model object of class `"pmrm_fit"`.

- ...:

  Not used.

## Value

A matrix with covariance of each pair of `theta` parameters. Rows and
columns are labeled (by just study arm for proportional models, arm and
visit for non-proportional models.)

## See also

Other estimates and predictions:
[`VarCorr.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/VarCorr.pmrm_fit.md),
[`coef.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/coef.pmrm_fit.md),
[`fitted.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/fitted.pmrm_fit.md),
[`plot.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/plot.pmrm_fit.md),
[`pmrm_estimates()`](https://wlandau.github.io/pmrm/reference/pmrm_estimates.md),
[`pmrm_marginals()`](https://wlandau.github.io/pmrm/reference/pmrm_marginals.md),
[`predict.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/predict.pmrm_fit.md),
[`residuals.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/residuals.pmrm_fit.md)

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
  vcov(fit)
#>             arm_2       arm_3
#> arm_2 0.002912489 0.001176870
#> arm_3 0.001176870 0.002767405
```
