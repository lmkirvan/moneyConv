## code to prepare `match_table` dataset goes here

# need to add to this table another set of strings as characters?
number_names <-  tibble::tibble(
  name = c(
    "zero"
    , "one"
    , "two"
    , "three"
    , "four"
    , "five"
    , "six"
    , "seven"
    , "eight"
    , "nine"
    , "ten"
    , "eleven"
    , "twelve"
    , "thirteen"
    , "fourteen"
    , "fifteen"
    , "sixteen"
    , "seventeen"
    , "eighteen"
    , "nineteen"
    , "twenty"
    , "thirty"
    , "forty"
    , "fifty"
    , "sixty"
    , "seventy"
    , "eighty"
    , "ninety"
  )
  , value = c(0:20, 30, 40, 50, 60, 70, 80, 90)
  , type = "number"
)

number_numbers <- tibble::tibble(
  name = as.character(c(0:20, 30, 40, 50, 60, 70, 80, 90))
  , value = c(0:20, 30, 40, 50, 60, 70, 80, 90)
  , type = "number"
)

place <- tibble::tibble(
  name = c("hundred", "thousand", "million", "billion")
  , value = c(100, 1e3, 1e6, 1e9)
  , type = "place"
)


match_table <- dplyr::bind_rows(number_names, number_numbers, place)

usethis::use_data(match_table, overwrite = TRUE, internal = TRUE)

