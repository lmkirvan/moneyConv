strip <- function(chr_vector){
  chr_vector |>
    stringr::str_to_lower() |>
    stringr::str_remove_all(pattern = "\\$|dollar[s]?|cents")
}

# space delimeted tokenization
tokenize <- function(chr_vector){
  tokenizers::tokenize_words(
    chr_vector
    , lowercase = TRUE
    , strip_punct = TRUE
    , strip_numeric = FALSE)
  }


# recursion is easier to write with pseudo lisp
car <- function(x){head(x, 1)}
cdr<- function(x){tail(x, -1)}
type <- function(token) match_table[match(token, match_table$name), "type"][[1]]
value <- function(token) match_table[match(token, match_table$name), "value"][[1]]


evaluate_one <- function(tokens, parens = "first"){

  print(tokens)
  print(parens)

  if(! rlang::is_empty(tokens)){

    if(car(tokens) == "and"){
      if(parens == "close"){
        return( c( ") +",  evaluate_one(cdr(tokens), parens = "close") ))
      } else {
        return( c( " + ",  evaluate_one(cdr(tokens), parens = "close") ))
      }
    }

    if( type(car(tokens)) == "number"){
      if(parens == "first"){
        return( c("((", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close") ))

      } else if(parens == "open") {
        return( c("+ (", value(car(tokens)), evaluate_one(cdr(tokens), parens = "close") ))

      } else {
       return( c("+", value(car(tokens)), ")", evaluate_one( cdr(tokens), parens = "open") ))
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

    if(parens == "close"){
      return("))")
    }
    return( ")")
  }
}



#' convert
#' convert numbers as character, including written out in words into numeric
#'
#' @param chr_vector
#'
#' @return a numeric vector of the same length with NAs for results that couldn't be converted.
#'
#' @export
#'
#' @examples
convert <- function(chr_vector){

  if(! is.character(chr_vector)) {

    stop("bad input")
  }

  res <- as.numeric(chr_vector)
  hard_ones <- is.na(res)

  chr_vector[hard_ones] |>
    strip() |>
    tokenize() |>
    purrr::map(evaluate_one) -> expressions

  print(expressions)

  purrr::map(expressions, \(x) eval(parse(text = x)))[[1]][1]


}

