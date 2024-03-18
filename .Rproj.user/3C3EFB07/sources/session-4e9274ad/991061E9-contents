## moneyConv

A quick package to money in various formats that people write in, into numbers and stuff.

This is just a design document. 

The goal is to convert between rough written down character vectors and integers. For exmple the string vec below should convert to `c(10000, 35, 45.17, 300, 1000000000)`


```{r}

vec <- c("ten thousand", "35", "45.17", "three hundred" "$1 Billion")

```

We can take this on by partition.

First we get the indexes of those that convert directly.
And we get the other indexes implicitly. 

We convert the remaining stuff to expressions and then convert? 
so for 'ten billion' we create the expression:
'10 * 1000000000'

Then we evaluate each expression in order? 

We seperate and then recombine with the indexing. 
