cm009 Exercises: tidy data
================

getwd() setwd() read\_csv vs. read.csv. one will keep elements as factors, while the other will keep things as characters.

``` r
suppressPackageStartupMessages(library(tidyverse))
#tidyverse contains readR package and others.
```

Reading and Writing Data: Exercises
-----------------------------------

Make a tibble of letters, their order in the alphabet, and then a pasting of the two columns together.

``` r
tibble(let = letters,
       num = 1:length(letters),
       comb = paste(let, num)) #paste function puts the two together using a space value. you can change the separation by adding sep = , or use paste0 which will have no separation between pasted values. 
```

    ## # A tibble: 26 x 3
    ##    let     num comb 
    ##    <chr> <int> <chr>
    ##  1 a         1 a 1  
    ##  2 b         2 b 2  
    ##  3 c         3 c 3  
    ##  4 d         4 d 4  
    ##  5 e         5 e 5  
    ##  6 f         6 f 6  
    ##  7 g         7 g 7  
    ##  8 h         8 h 8  
    ##  9 i         9 i 9  
    ## 10 j        10 j 10 
    ## # ... with 16 more rows

Make a tibble of three names and commute times. - A way to manually encode all values in your data frame.

``` r
tribble(
  ~name, ~time, # '~' indicates the names of variables we are adding.
  "Frank", 30,
  "Lisa", 15,
  "Fred", 40
  )
```

    ## # A tibble: 3 x 2
    ##   name   time
    ##   <chr> <dbl>
    ## 1 Frank  30.0
    ## 2 Lisa   15.0
    ## 3 Fred   40.0

Write the `iris` data frame as a `csv`.

``` r
write_csv(iris, "iris.csv")
#first arg is data we want, 2nd arg is the path (if you press tab it will lead to files that you currently have, or you can make your own which will be saved in your current working directory)
```

Write the `iris` data frame to a file delimited by a dollar sign.

``` r
write_delim(iris, "iris.txt", delim = "$")
```

Read the dollar-delimited `iris` data to a tibble.

``` r
read_delim("iris.txt", delim = "$")
```

    ## Parsed with column specification:
    ## cols(
    ##   Sepal.Length = col_double(),
    ##   Sepal.Width = col_double(),
    ##   Petal.Length = col_double(),
    ##   Petal.Width = col_double(),
    ##   Species = col_character()
    ## )

    ## # A tibble: 150 x 5
    ##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
    ##  1         5.10        3.50         1.40       0.200 setosa 
    ##  2         4.90        3.00         1.40       0.200 setosa 
    ##  3         4.70        3.20         1.30       0.200 setosa 
    ##  4         4.60        3.10         1.50       0.200 setosa 
    ##  5         5.00        3.60         1.40       0.200 setosa 
    ##  6         5.40        3.90         1.70       0.400 setosa 
    ##  7         4.60        3.40         1.40       0.300 setosa 
    ##  8         5.00        3.40         1.50       0.200 setosa 
    ##  9         4.40        2.90         1.40       0.200 setosa 
    ## 10         4.90        3.10         1.50       0.100 setosa 
    ## # ... with 140 more rows

``` r
#to read the dataset. 
#delim is how the columns are delimited.
```

Read these three LOTR csv's, saving them to `lotr1`, `lotr2`, and `lotr3`:

-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv>
-   <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv>
-   <https://github.com/jennybc/lotr-tidy/blob/master/data/The_Return_Of_The_King.csv>

``` r
LOTR1 = read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv") #can just paste the URL above
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
LOTR2 = read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
LOTR3 = read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

`gather()`
----------

(Exercises largely based off of Jenny Bryan's [gather tutorial](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md))

This function is useful for making untidy data tidy (so that computers can more easily crunch the numbers).

1.  Combine the three LOTR untidy tables (`lotr1`, `lotr2`, `lotr3`) to a single untidy table by stacking them.

``` r
#gather makes untidy data tidy. 
lotr_Untidy = bind_rows(LOTR1, LOTR2, LOTR3)
lotr_Untidy
```

    ## # A tibble: 9 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 4 The Two Towers             Elf       331   513
    ## 5 The Two Towers             Hobbit      0  2463
    ## 6 The Two Towers             Man       401  3589
    ## 7 The Return Of The King     Elf       183   510
    ## 8 The Return Of The King     Hobbit      2  2673
    ## 9 The Return Of The King     Man       268  2459

``` r
# lotr_Untidy may look tidy but it's still not. why? gender is still in two columns but we want to combine it into one. 
```

1.  Convert to tidy. Also try this by specifying columns as a range, and with the `contains()` function.

``` r
gather(lotr_Untidy, key = "Gender", value = "Words Spoken", Female, Male) #value will name the new columns. we also need to specify the columns that currently make up the variables we want to merge (Female and Male in our case). Key is the separation - we will separate by gender male or female. and the values currently inside it we will re-assign as a "words spoken" variable.
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender `Words Spoken`
    ##    <chr>                      <chr>  <chr>           <int>
    ##  1 The Fellowship Of The Ring Elf    Female           1229
    ##  2 The Fellowship Of The Ring Hobbit Female             14
    ##  3 The Fellowship Of The Ring Man    Female              0
    ##  4 The Two Towers             Elf    Female            331
    ##  5 The Two Towers             Hobbit Female              0
    ##  6 The Two Towers             Man    Female            401
    ##  7 The Return Of The King     Elf    Female            183
    ##  8 The Return Of The King     Hobbit Female              2
    ##  9 The Return Of The King     Man    Female            268
    ## 10 The Fellowship Of The Ring Elf    Male              971
    ## 11 The Fellowship Of The Ring Hobbit Male             3644
    ## 12 The Fellowship Of The Ring Man    Male             1995
    ## 13 The Two Towers             Elf    Male              513
    ## 14 The Two Towers             Hobbit Male             2463
    ## 15 The Two Towers             Man    Male             3589
    ## 16 The Return Of The King     Elf    Male              510
    ## 17 The Return Of The King     Hobbit Male             2673
    ## 18 The Return Of The King     Man    Male             2459

``` r
#we can specify a range of columns
gather(lotr_Untidy, key = "Gender", value = "Words Spoken", Female: Male) #use :
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender `Words Spoken`
    ##    <chr>                      <chr>  <chr>           <int>
    ##  1 The Fellowship Of The Ring Elf    Female           1229
    ##  2 The Fellowship Of The Ring Hobbit Female             14
    ##  3 The Fellowship Of The Ring Man    Female              0
    ##  4 The Two Towers             Elf    Female            331
    ##  5 The Two Towers             Hobbit Female              0
    ##  6 The Two Towers             Man    Female            401
    ##  7 The Return Of The King     Elf    Female            183
    ##  8 The Return Of The King     Hobbit Female              2
    ##  9 The Return Of The King     Man    Female            268
    ## 10 The Fellowship Of The Ring Elf    Male              971
    ## 11 The Fellowship Of The Ring Hobbit Male             3644
    ## 12 The Fellowship Of The Ring Man    Male             1995
    ## 13 The Two Towers             Elf    Male              513
    ## 14 The Two Towers             Hobbit Male             2463
    ## 15 The Two Towers             Man    Male             3589
    ## 16 The Return Of The King     Elf    Male              510
    ## 17 The Return Of The King     Hobbit Male             2673
    ## 18 The Return Of The King     Man    Male             2459

``` r
gather(lotr_Untidy, key = "Gender", value = "Words Spoken", contains("ale")) #will return values that contain "ale" which in our case is found in both male and female
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender `Words Spoken`
    ##    <chr>                      <chr>  <chr>           <int>
    ##  1 The Fellowship Of The Ring Elf    Female           1229
    ##  2 The Fellowship Of The Ring Hobbit Female             14
    ##  3 The Fellowship Of The Ring Man    Female              0
    ##  4 The Two Towers             Elf    Female            331
    ##  5 The Two Towers             Hobbit Female              0
    ##  6 The Two Towers             Man    Female            401
    ##  7 The Return Of The King     Elf    Female            183
    ##  8 The Return Of The King     Hobbit Female              2
    ##  9 The Return Of The King     Man    Female            268
    ## 10 The Fellowship Of The Ring Elf    Male              971
    ## 11 The Fellowship Of The Ring Hobbit Male             3644
    ## 12 The Fellowship Of The Ring Man    Male             1995
    ## 13 The Two Towers             Elf    Male              513
    ## 14 The Two Towers             Hobbit Male             2463
    ## 15 The Two Towers             Man    Male             3589
    ## 16 The Return Of The King     Elf    Male              510
    ## 17 The Return Of The King     Hobbit Male             2673
    ## 18 The Return Of The King     Man    Male             2459

1.  Try again (bind and tidy the three untidy data frames), but without knowing how many tables there are originally.
    -   The additional work here does not require any additional tools from the tidyverse, but instead uses a `do.call` from base R -- a useful tool in data analysis when the number of "items" is variable/unknown, or quite large.

`spread()`
----------

(Exercises largely based off of Jenny Bryan's [spread tutorial](https://github.com/jennybc/lotr-tidy/blob/master/03-spread.md))

This function is useful for making tidy data untidy (to be more pleasing to the eye).

Read in the tidy LOTR data (despite having just made it):

``` r
lotr_tidy <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Gender = col_character(),
    ##   Words = col_integer()
    ## )

Get word counts across "Race". Then try "Gender".

Now try combining race and gender. Use `unite()` from `tidyr` instead of `paste()`.

Other `tidyr` goodies
---------------------

Check out the Examples in the documentation to explore the following.

`expand` vs `complete` (trim vs keep everything). Together with `nesting`. Check out the Examples in the `expand` documentation.

`separate_rows`: useful when you have a variable number of entries in a "cell".

`unite` and `separate`.

`uncount` (as the opposite of `dplyr::count()`)

`drop_na` and `replace_na`

`fill`

`full_seq`

Time remaining?
---------------

Time permitting, do [this exercise](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md#exercises) to practice tidying data.
