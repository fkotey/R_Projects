#' interval
#'
#' \code{interval} returns a vector of numeric values indicating the difference between
#' the values and minimum of the vector dvided by the maximum of the vector
#'
#' @param x a vector of numerric or integer values
#'
#' @return a vector of numerric values
#' @export
#'
#' @examples
#' a <- rnorm(10)
#' interval(a)
#'
interval <- function(x) {
    y <- x - min(x)
    y/max(x)
}
