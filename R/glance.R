#' @title Glance at a PMRM.
#' @export
#' @family model comparison
#' @description Return a one-row `tibble` of model comparison metrics
#'   for a fitted PMRM.
#' @return A `tibble` with one row and columns with the following columns:
#'
#'   * `model`: `"decline"` or `"slowing"`.
#'   * `parameterization`: `"proportional"` or `"nonproportional"`.
#'   * `n_observations`: number of non-missing observations in the data.
#'   * `n_parameters`: number of true model parameters.
#'   * `log_likelihood`: maximized log likelihood of the model fit.
#'   * `deviance`: deviance of the fitted model, defined here as
#'     `-2 * log_likelihood`.
#'   * `aic`: Akaike information criterion.
#'   * `bic`: Bayesian information criterion.
#'
#'   This format is designed for easy comparison of multiple fitted models.
#' @param x A fitted model x of class `"pmrm_fit"`.
#' @param ... Not used.
#' @examples
#'   set.seed(0L)
#'   simulation <- pmrm_simulate_decline_proportional(
#'     visit_times = seq_len(5L) - 1,
#'     gamma = c(1, 2)
#'   )
#'   fit <- pmrm_model_decline_proportional(
#'     data = simulation,
#'     outcome = "y",
#'     time = "t",
#'     patient = "patient",
#'     visit = "visit",
#'     arm = "arm",
#'     covariates = ~ w_1 + w_2
#'   )
#'   glance(fit)
glance.pmrm_fit <- function(x, ...) {
  tibble::tibble(
    model = ifelse(x$constants$slowing, "slowing", "decline"),
    parameterization = ifelse(
      x$constants$proportional,
      "proportional",
      "nonproportional"
    ),
    n_observations = x$metrics$n_observations,
    n_parameters = x$metrics$n_parameters,
    log_likelihood = x$metrics$log_likelihood,
    deviance = x$metrics$deviance,
    aic = x$metrics$aic,
    bic = x$metrics$bic
  )
}

#' @export
generics::glance
