3
test_that("conversion works", {

  expect_equal(35, convert("thirty five"))
  expect_equal(127, convert("one hundred and twenty seven dollars"))
  expect_equal(1012, convert("one thousand and twelve"))
  expect_equal(3012, convert("3 thousand and twelve"))
  expect_equal(157012 , convert('one hundred fifty seven thousand and twelve'))
  })
