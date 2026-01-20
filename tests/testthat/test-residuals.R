test_that("residuals.pmrm_fit() proportional decline", {
  for (adjust in c(TRUE, FALSE)) {
    expect_equal(
      residuals(fit_decline_proportional(), adjust = adjust),
      fit_decline_proportional()$data$y -
        fitted(fit_decline_proportional(), adjust = adjust)
    )
  }
})

test_that("residuals.pmrm_fit() non-proportional slowing", {
  for (adjust in c(TRUE, FALSE)) {
    expect_equal(
      residuals(fit_slowing_nonproportional(), adjust = adjust),
      fit_slowing_nonproportional()$data$y -
        fitted(fit_slowing_nonproportional(), adjust = adjust)
    )
  }
})
