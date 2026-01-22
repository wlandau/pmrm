test_that("print.pmrm_fit", {
  text <- capture.output(print(fit_decline_nonproportional()))
  expect_true(any(grepl("PMRM type", text)))
})
