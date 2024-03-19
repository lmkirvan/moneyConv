

vector <- readr::read_lines("tests/money_examples")


word_names <-  tibble::tibble(

  names = c(
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
  , numeric = c(0:20, 30, 40, 50, 60, 70, 80, 90)
)

place <- tibble::tibble(
  place = c("hundred", "thousand", "million", "billion")
  , value = c(100, 1e3, 1e6, 1e9)
)

# space delimeted
tokenize <- function(chr_vector){
  tokenizers::tokenize_words(
    chr_vector
    , lowercase = TRUE
    , strip_punct = TRUE
    , strip_numeric = FALSE
    )
}


tokenize(vector)

# tag for role
# roles are
# 1) numbers
# 2) place (i.e. hundreds)
# 3) denomination (dollars/cents

tag <- function(tokens){






}



# this is the final thing
resolve_tagged_tokens <- function(tagged_tokens){


}




convert <- function(chr_vector){

  if(! is.character(chr_vector)) {

    stop("bad input")
  }




}
