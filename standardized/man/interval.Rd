% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/interval.R
\name{interval}
\alias{interval}
\title{interval}
\usage{
interval(x)
}
\arguments{
\item{x}{a vector of numerric or integer values}
}
\value{
a vector of numerric values
}
\description{
\code{interval} returns a vector of numeric values indicating the difference between
the values and minimum of the vector dvided by the maximum of the vector
}
\examples{
a <- rnorm(10)
interval(a)

}
