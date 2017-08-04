#' standardize
#'
#' \code{standardize} returns a standardized copy of a vector of values. To do this, it
#' subtracts the mean of the vector from the value and divide the results by the
#' the standard deviation.
#'
#' @param x a vector of numerric or integer values
#'
#' @return a vector of numerric values
#' @export
#'
#' @examples
#' a <- 50:100
#' standardize(a)
#'
standardize <- function(x) {
  rescale(center(x))
}
