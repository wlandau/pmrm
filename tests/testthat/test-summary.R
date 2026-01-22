test_that("summary.pmrm_fit() non-proportional decline", {
  out <- summary(fit_decline_nonproportional())
  expect_true(tibble::is_tibble(out))
  expect_equal(dim(out), c(1L, 8L))
  expect_equal(out$model, "decline")
  expect_equal(out$parameterization, "nonproportional")
  for (field in names(fit_decline_nonproportional()$metrics)) {
    expect_equal(out[[field]], fit_decline_nonproportional()$metrics[[field]])
  }
})

test_that("summary.pmrm_fit() proportional decline", {
  out <- summary(fit_decline_proportional())
  expect_true(tibble::is_tibble(out))
  expect_equal(dim(out), c(1L, 8L))
  expect_equal(out$model, "decline")
  expect_equal(out$parameterization, "proportional")
  for (field in names(fit_decline_proportional()$metrics)) {
    expect_equal(out[[field]], fit_decline_proportional()$metrics[[field]])
  }
})

test_that("summary.pmrm_fit() non-proportional slowing", {
  out <- summary(fit_slowing_nonproportional())
  expect_true(tibble::is_tibble(out))
  expect_equal(dim(out), c(1L, 8L))
  expect_equal(out$model, "slowing")
  expect_equal(out$parameterization, "nonproportional")
  for (field in names(fit_slowing_nonproportional()$metrics)) {
    expect_equal(out[[field]], fit_slowing_nonproportional()$metrics[[field]])
  }
})

test_that("summary.pmrm_fit() proportional slowing", {
  out <- summary(fit_slowing_proportional())
  expect_true(tibble::is_tibble(out))
  expect_equal(dim(out), c(1L, 8L))
  expect_equal(out$model, "slowing")
  expect_equal(out$parameterization, "proportional")
  for (field in names(fit_slowing_proportional()$metrics)) {
    expect_equal(out[[field]], fit_slowing_proportional()$metrics[[field]])
  }
})
