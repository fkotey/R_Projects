context("center")

test_that("center handles integers", {
  expect_equal(center(1:3), -1:1)
  expect_equal(center(-(1:3)), 1:-1)
})

context("rescale")

test_that("rescale handles integers", {
  expect_equal(rescale(1:3), 1:3)
  expect_equal(rescale(-(1:3)), -(1:3))
})

context("standardize")

test_that("standardize handles integers", {
  expect_equal(standardize(1:3), -1:1)
  expect_equal(standardize(-(1:3)), 1:-1)
})

context("interval")

test_that("interval handles integers", {
  expect_equal(interval(1:3), c(0, 1/3, 2/3))
  expect_equal(interval(-(1:3)), -(2:0))
})
