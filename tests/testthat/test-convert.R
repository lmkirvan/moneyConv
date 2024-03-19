vector <- readr::read_lines("tests/money_examples")


test_that("multiplication works", {

  expect_equal(35, moneyConv::convert(vector)[1])

  })
