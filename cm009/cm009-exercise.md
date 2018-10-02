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
gather(lotr_Untidy, key = "Gender", value = "Words", Female: Male) #use :
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender Words
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Two Towers             Elf    Female   331
    ##  5 The Two Towers             Hobbit Female     0
    ##  6 The Two Towers             Man    Female   401
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Two Towers             Elf    Male     513
    ## 14 The Two Towers             Hobbit Male    2463
    ## 15 The Two Towers             Man    Male    3589
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

``` r
gather(lotr_Untidy, key = "Gender", value = "Words", contains("ale")) #will return values that contain "ale" which in our case is found in both male and female
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender Words
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Two Towers             Elf    Female   331
    ##  5 The Two Towers             Hobbit Female     0
    ##  6 The Two Towers             Man    Female   401
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Two Towers             Elf    Male     513
    ## 14 The Two Towers             Hobbit Male    2463
    ## 15 The Two Towers             Man    Male    3589
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

1.  Try again (bind and tidy the three untidy data frames), but without knowing how many tables there are originally.
    -   The additional work here does not require any additional tools from the tidyverse, but instead uses a `do.call` from base R -- a useful tool in data analysis when the number of "items" is variable/unknown, or quite large.

``` r
lotr_list = list(LOTR1, LOTR2, LOTR3)
lotr_list
```

    ## [[1]]
    ## # A tibble: 3 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 
    ## [[2]]
    ## # A tibble: 3 x 4
    ##   Film           Race   Female  Male
    ##   <chr>          <chr>   <int> <int>
    ## 1 The Two Towers Elf       331   513
    ## 2 The Two Towers Hobbit      0  2463
    ## 3 The Two Towers Man       401  3589
    ## 
    ## [[3]]
    ## # A tibble: 3 x 4
    ##   Film                   Race   Female  Male
    ##   <chr>                  <chr>   <int> <int>
    ## 1 The Return Of The King Elf       183   510
    ## 2 The Return Of The King Hobbit      2  2673
    ## 3 The Return Of The King Man       268  2459

``` r
#returns 3 outputs, each of which are a dataframe.

do.call(bind_rows, lotr_list) # first arg is the function, second argument is applying function to all datasets.
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

`spread()`
----------

(Exercises largely based off of Jenny Bryan's [spread tutorial](https://github.com/jennybc/lotr-tidy/blob/master/03-spread.md))

This function is useful for making tidy data untidy (to be more pleasing to the eye).

Read in the tidy LOTR data (despite having just made it):

``` r
lotr_tidy <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv") #bring in the tidy data (done already here for us)
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Gender = col_character(),
    ##   Words = col_integer()
    ## )

``` r
#we want to spread out the race catetogy onto different columns. new column for each race w/ word count under each. 
spread(lotr_tidy, key = "Race", value = "Words") #the key we want to spread into columns is Race and the value we want to put into that column is "Words"
```

    ## # A tibble: 6 x 5
    ##   Film                       Gender   Elf Hobbit   Man
    ## * <chr>                      <chr>  <int>  <int> <int>
    ## 1 The Fellowship Of The Ring Female  1229     14     0
    ## 2 The Fellowship Of The Ring Male     971   3644  1995
    ## 3 The Return Of The King     Female   183      2   268
    ## 4 The Return Of The King     Male     510   2673  2459
    ## 5 The Two Towers             Female   331      0   401
    ## 6 The Two Towers             Male     513   2463  3589

Get word counts across "Race". Then try "Gender".

``` r
spread(lotr_tidy, key = "Race", value = "Words") #the key we want to spread into columns is Race and the value we want to put into that column is "Words"
```

    ## # A tibble: 6 x 5
    ##   Film                       Gender   Elf Hobbit   Man
    ## * <chr>                      <chr>  <int>  <int> <int>
    ## 1 The Fellowship Of The Ring Female  1229     14     0
    ## 2 The Fellowship Of The Ring Male     971   3644  1995
    ## 3 The Return Of The King     Female   183      2   268
    ## 4 The Return Of The King     Male     510   2673  2459
    ## 5 The Two Towers             Female   331      0   401
    ## 6 The Two Towers             Male     513   2463  3589

Now try combining race and gender. Use `unite()` from `tidyr` instead of `paste()`.

``` r
#first arg of unite are the name of the new column to make.
lotr_tidy %>% 
  unite(Race_Gender, Race, Gender) %>% #Race_Gender = name of new column. and then we specify the columns we want to unite.
  spread(key = "Race_Gender", value = "Words")
```

    ## # A tibble: 3 x 7
    ##   Film                       Elf_Female Elf_Male Hobbi… Hobbi… Man_… Man_…
    ## * <chr>                           <int>    <int>  <int>  <int> <int> <int>
    ## 1 The Fellowship Of The Ring       1229      971     14   3644     0  1995
    ## 2 The Return Of The King            183      510      2   2673   268  2459
    ## 3 The Two Towers                    331      513      0   2463   401  3589

``` r
lotr_tidy %>% 
  mutate(x = rnorm(nrow(lotr_tidy))) %>% 
  spread(key = "Gender", value ="x") #why if we do this did it keep NAs? The words variable doesnt have a unique combination
```

    ## # A tibble: 18 x 5
    ##    Film                       Race   Words   Female    Male
    ##  * <chr>                      <chr>  <int>    <dbl>   <dbl>
    ##  1 The Fellowship Of The Ring Elf      971  NA        2.24 
    ##  2 The Fellowship Of The Ring Elf     1229   0.0599  NA    
    ##  3 The Fellowship Of The Ring Hobbit    14 - 0.327   NA    
    ##  4 The Fellowship Of The Ring Hobbit  3644  NA        0.271
    ##  5 The Fellowship Of The Ring Man        0   0.784   NA    
    ##  6 The Fellowship Of The Ring Man     1995  NA        0.743
    ##  7 The Return Of The King     Elf      183 - 0.332   NA    
    ##  8 The Return Of The King     Elf      510  NA        1.02 
    ##  9 The Return Of The King     Hobbit     2   0.535   NA    
    ## 10 The Return Of The King     Hobbit  2673  NA        0.677
    ## 11 The Return Of The King     Man      268   0.231   NA    
    ## 12 The Return Of The King     Man     2459  NA        0.567
    ## 13 The Two Towers             Elf      331   0.332   NA    
    ## 14 The Two Towers             Elf      513  NA      - 1.01 
    ## 15 The Two Towers             Hobbit     0 - 1.29    NA    
    ## 16 The Two Towers             Hobbit  2463  NA      - 0.485
    ## 17 The Two Towers             Man      401 - 0.253   NA    
    ## 18 The Two Towers             Man     3589  NA        1.05

Other `tidyr` goodies
---------------------

Check out the Examples in the documentation to explore the following.

`expand` vs `complete` (trim vs keep everything). Together with `nesting`. Check out the Examples in the `expand` documentation.

``` r
expand(mtcars,vs,cyl) #returns all possible combinations of these two varaibles in the mtcars dataframe. if you use 
```

    ## # A tibble: 6 x 2
    ##      vs   cyl
    ##   <dbl> <dbl>
    ## 1  0     4.00
    ## 2  0     6.00
    ## 3  0     8.00
    ## 4  1.00  4.00
    ## 5  1.00  6.00
    ## 6  1.00  8.00

``` r
expand(mtcars, nesting(vs, cyl)) #it only returns combos in the df.
```

    ## # A tibble: 5 x 2
    ##      vs   cyl
    ##   <dbl> <dbl>
    ## 1  0     4.00
    ## 2  0     6.00
    ## 3  0     8.00
    ## 4  1.00  4.00
    ## 5  1.00  6.00

``` r
df <- tibble(
  year   = c(2010, 2010, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   1,    2,    3,    4,    1,    2,    3),
  return = rnorm(7))
  
df %>% 
  expand(year, qtr)
```

    ## # A tibble: 8 x 2
    ##    year   qtr
    ##   <dbl> <dbl>
    ## 1  2010  1.00
    ## 2  2010  2.00
    ## 3  2010  3.00
    ## 4  2010  4.00
    ## 5  2012  1.00
    ## 6  2012  2.00
    ## 7  2012  3.00
    ## 8  2012  4.00

``` r
#full seq = ex. full_seq(year) expands all years by increments of 1. 
df %>% expand(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <dbl> <dbl>
    ##  1  2010  1.00
    ##  2  2010  2.00
    ##  3  2010  3.00
    ##  4  2010  4.00
    ##  5  2011  1.00
    ##  6  2011  2.00
    ##  7  2011  3.00
    ##  8  2011  4.00
    ##  9  2012  1.00
    ## 10  2012  2.00
    ## 11  2012  3.00
    ## 12  2012  4.00

``` r
#nesting:
#patients receiving various treatments... some have 3 measurements, others have 2. the goal is to fill in the ones with two with NAs. 
#we don't want to look at all combos ex. Robert with A since robert didn't take tmt A. we can ne
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurment_1 = runif(6),
  measurment_2 = runif(6))
  
  #nesting.
  experiment
```

    ## # A tibble: 6 x 5
    ##   name   trt     rep measurment_1 measurment_2
    ##   <chr>  <chr> <dbl>        <dbl>        <dbl>
    ## 1 Alex   a      1.00       0.580        0.853 
    ## 2 Alex   a      2.00       0.0637       0.236 
    ## 3 Alex   a      3.00       0.462        0.390 
    ## 4 Robert b      1.00       0.512        0.775 
    ## 5 Robert b      2.00       0.304        0.176 
    ## 6 Sam    a      1.00       0.947        0.0375

``` r
  experiment %>% expand(nesting(name,trt), rep)
```

    ## # A tibble: 9 x 3
    ##   name   trt     rep
    ##   <chr>  <chr> <dbl>
    ## 1 Alex   a      1.00
    ## 2 Alex   a      2.00
    ## 3 Alex   a      3.00
    ## 4 Robert b      1.00
    ## 5 Robert b      2.00
    ## 6 Robert b      3.00
    ## 7 Sam    a      1.00
    ## 8 Sam    a      2.00
    ## 9 Sam    a      3.00

`separate_rows`: useful when you have a variable number of entries in a "cell".

``` r
df <- data.frame(
  x = 1:3,
  y = c("a", "d,e,f", "g,h"),
  z = c("1", "2,3,4", "5,6"),
  stringsAsFactors = FALSE
)
separate_rows(df, y, z, convert = TRUE)
```

    ##   x y z
    ## 1 1 a 1
    ## 2 2 d 2
    ## 3 2 e 3
    ## 4 2 f 4
    ## 5 3 g 5
    ## 6 3 h 6

`unite` and `separate`.

`uncount` (as the opposite of `dplyr::count()`) \#opposite of count. makes a repeated row for the number of observations tht you have.

`drop_na` and `replace_na` \#drops NAs by just dropping the rows. \#replace\_na will replace with whatever you want.

`fill` \#fill rows? ex. fills in NAs with the nearest previous non- NA entry. ????? Avoid?

`full_seq`

Time remaining?
---------------

Time permitting, do [this exercise](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md#exercises) to practice tidying data.
