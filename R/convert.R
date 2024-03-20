vector <- readr::read_lines("tests/money_examples")

example_token <- tokenize(vector[length(vector)])[[1]]

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

# space delimeted
tokenize <- function(chr_vector){
  tokenizers::tokenize_words(
    chr_vector
    , lowercase = TRUE
    , strip_punct = TRUE
    , strip_numeric = FALSE
    )
}

# tag for role
# roles are
# 1) numbers
# 2) place (i.e. hundreds)
# 3) denomination (dollars/cents


car <- function(x){head(x, 1)}
cdr<- function(x){tail(x, -1)}
type <- function(token) match_table[match(token, match_table$name), "type"][[1]]
value <- function(token) match_table[match(token, match_table$name), "value"][[1]]


evaluate_one <- function(tokens, parens = "first"){

  print(tokens)

  if(! rlang::is_empty(tokens)){

    if( type(car(tokens)) == "number"){
      if(parens == "first"){
        return( c("((", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close")) )

      } else if(parens == "open") {
        return( c("+ (", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close")) )

      } else {
       return( c("+", value(car(tokens)), ")", evaluate_one( cdr(tokens), parens = "open")) )
      }
    }
    if( type(car(tokens)) == "place" ){
      if(parens == "first"){
        return( c("((", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close")) )
      } else if(parens == "open"){
        return( c(") * (", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close")) )
      } else {
        return ( c("*", value(car(tokens)), ")", evaluate_one(cdr(tokens), parens = "open")))
      }
    }
  } else {
    return( ")")
  }
}

parse_text_first <- function(text){
  parse(file = "", text = text)
}

temp <- temp |>  stringr::str_c(collapse = "")  |>  parse_text_first() |>  eval()

temp <- evaluate_one( tokens = c("2", "hundred", "thousand"))

purrr::map(purrr::map(vector, tokenize), evaluate_one)

# so I think that the rules are relatively simple here: if the current sequence
# is a number and the next token is a number combine with addition if the
# current token is a number and the next token is a place combine by multiplying
# if the current token is a place and the next token is a place combine by
# mulitplying. The additions just need parens around them for this to work?
convert_single_expression <- function(tagged_tokens){




}




convert <- function(chr_vector){

  if(! is.character(chr_vector)) {

    stop("bad input")
  }




}
