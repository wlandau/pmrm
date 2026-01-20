test_that("VarCorr.pmrm_fit() proportional decline", {
  out <- VarCorr(fit_decline_proportional())
  labels <- pmrm_data_labels(fit_decline_proportional()$data)
  visits <- levels(fit_decline_proportional()$data[[labels$visit]])
  expected <- fit_decline_proportional()$estimates$Sigma
  rownames(expected) <- visits
  colnames(expected) <- visits
  expect_equal(out, expected)
})

test_that("VarCorr.pmrm_fit() non-proportional slowing", {
  out <- VarCorr(fit_slowing_nonproportional())
  labels <- pmrm_data_labels(fit_slowing_nonproportional()$data)
  visits <- levels(fit_slowing_nonproportional()$data[[labels$visit]])
  expected <- fit_slowing_nonproportional()$estimates$Sigma
  rownames(expected) <- visits
  colnames(expected) <- visits
  expect_equal(out, expected)
})
