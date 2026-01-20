test_that("vcov.pmrm_fit() proportional decline", {
  out <- vcov(fit_decline_proportional())
  expect_true(is.matrix(out))
  expect_equal(dim(out), c(2L, 2L))
  arms <- levels(fit_decline_proportional()$data$arm)[-1L]
  expect_equal(rownames(out), arms)
  expect_equal(colnames(out), arms)
  expect_equal(
    unname(sqrt(diag(out))),
    pmrm_estimates(fit_decline_proportional(), "theta")$standard_error
  )
})

test_that("vcov.pmrm_fit() non-proportional slowing", {
  out <- vcov(fit_slowing_nonproportional())
  expect_true(is.matrix(out))
  expect_equal(dim(out), c(8L, 8L))
  arms <- rep(levels(fit_slowing_nonproportional()$data$arm)[-1L], each = 4L)
  visits <- rep(
    levels(fit_slowing_nonproportional()$data$visit)[-1L],
    times = 2L
  )
  names <- paste(arms, visits, sep = ":")
  expect_equal(rownames(out), names)
  expect_equal(colnames(out), names)
  expect_equal(
    unname(sqrt(diag(out))),
    pmrm_estimates(fit_slowing_nonproportional(), "theta")$standard_error
  )
})
