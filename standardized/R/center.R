#' center
#'
#' \code{center} returns a centered copy of a vector of values. To do this, it
#' subtracts the mean of the vector from the value
#'
#' @param x a vector of numerric or integer values
#'
#' @return a vector of numerric values
#' @export
#'
#' @examples
#' a <- 50:100
#' center(a)
#'
center <- function(x) {
  x - mean(x)
}
