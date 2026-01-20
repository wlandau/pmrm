# Nonlinear fixed effects covariance matrix: non-proportional slowing model

Extract the covariance matrix of the non-proportional slowing model.

## Usage

``` r
# S3 method for class 'pmrm_fit_slowing'
vcov(object, ...)
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

A matrix with covariance of each pair of `theta` parameters. Rows and
columns are labeled by study arm and scheduled visit.

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
[`predict.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/predict.pmrm_fit.md),
[`residuals.pmrm_fit()`](https://wlandau.github.io/pmrm/reference/residuals.pmrm_fit.md),
[`vcov.pmrm_fit_decline()`](https://wlandau.github.io/pmrm/reference/vcov.pmrm_fit_decline.md)

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
  vcov(fit)
#>               arm_2:visit_2 arm_2:visit_3 arm_2:visit_4 arm_2:visit_5
#> arm_2:visit_2  2.163025e-02  -0.006151973  -0.002400914  6.504138e-05
#> arm_2:visit_3 -6.151973e-03   0.024404153   0.003697154  2.563606e-03
#> arm_2:visit_4 -2.400914e-03   0.003697154   0.005534160  1.801520e-03
#> arm_2:visit_5  6.504138e-05   0.002563606   0.001801520  4.369982e-03
#> arm_3:visit_2  7.790585e-03  -0.003979150  -0.001532885 -1.946021e-04
#> arm_3:visit_3 -2.771914e-02   0.026919550   0.009826424  2.858112e-03
#> arm_3:visit_4 -2.109426e-03   0.004426687   0.002338657  1.681430e-03
#> arm_3:visit_5 -2.530970e-04   0.001439500   0.001720979  2.056983e-03
#>               arm_3:visit_2 arm_3:visit_3 arm_3:visit_4 arm_3:visit_5
#> arm_2:visit_2  0.0077905846  -0.027719142  -0.002109426 -0.0002530970
#> arm_2:visit_3 -0.0039791495   0.026919550   0.004426687  0.0014394995
#> arm_2:visit_4 -0.0015328847   0.009826424   0.002338657  0.0017209785
#> arm_2:visit_5 -0.0001946021   0.002858112   0.001681430  0.0020569832
#> arm_3:visit_2  0.0182260000  -0.022797332  -0.002189729  0.0001138124
#> arm_3:visit_3 -0.0227973318   0.633508139   0.010984008  0.0024810864
#> arm_3:visit_4 -0.0021897289   0.010984008   0.005772000  0.0016207465
#> arm_3:visit_5  0.0001138124   0.002481086   0.001620747  0.0043727686
```
