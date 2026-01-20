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
#> arm_2:visit_2  2.162408e-02  -0.006144915  -0.002398874  6.527632e-05
#> arm_2:visit_3 -6.144915e-03   0.024392855   0.003694716  2.563170e-03
#> arm_2:visit_4 -2.398874e-03   0.003694716   0.005533157  1.801210e-03
#> arm_2:visit_5  6.527632e-05   0.002563170   0.001801210  4.369551e-03
#> arm_3:visit_2  7.785745e-03  -0.003973480  -0.001531219 -1.943808e-04
#> arm_3:visit_3 -2.758552e-02   0.026828510   0.009792350  2.847549e-03
#> arm_3:visit_4 -2.106773e-03   0.004423366   0.002337678  1.681271e-03
#> arm_3:visit_5 -2.528120e-04   0.001439254   0.001720737  2.056847e-03
#>               arm_3:visit_2 arm_3:visit_3 arm_3:visit_4 arm_3:visit_5
#> arm_2:visit_2  0.0077857449  -0.027585519  -0.002106773 -0.0002528120
#> arm_2:visit_3 -0.0039734804   0.026828510   0.004423366  0.0014392537
#> arm_2:visit_4 -0.0015312190   0.009792350   0.002337678  0.0017207370
#> arm_2:visit_5 -0.0001943808   0.002847549   0.001681271  0.0020568474
#> arm_3:visit_2  0.0182218609  -0.022692757  -0.002187549  0.0001140122
#> arm_3:visit_3 -0.0226927566   0.630858304   0.010943061  0.0024761795
#> arm_3:visit_4 -0.0021875491   0.010943061   0.005770513  0.0016206441
#> arm_3:visit_5  0.0001140122   0.002476180   0.001620644  0.0043726338
```
