#' rescale
#'
#' \code{rescale} returns a scaled copy of a vector of values. To do this, it
#' vector from the value by the standard deviation.
#'
#' @param x a vector of numerric or integer values
#'
#' @return a vector of numerric values
#' @export
#'
#' @examples
#' a <- 50:100
#' rescale(a)
#'
rescale <- function(x) {
  x / sd(x)
}
