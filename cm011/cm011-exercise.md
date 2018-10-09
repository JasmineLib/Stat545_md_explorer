cm011 Exercises: R as a programming language
================

Part I
======

Types and Modes and Classes, Oh My!
-----------------------------------

R objects have a *type*, a *mode*, and a *class*. This can be confusing:

``` r
a <- 3
print(typeof(a))
```

    ## [1] "double"

``` r
print(mode(a))
```

    ## [1] "numeric"

``` r
print(class(a))
```

    ## [1] "numeric"

``` r
print(typeof(iris))
```

    ## [1] "list"

``` r
print(mode(iris))
```

    ## [1] "list"

``` r
print(class(iris))
```

    ## [1] "data.frame"

``` r
print(typeof(sum))
```

    ## [1] "builtin"

``` r
print(mode(sum))
```

    ## [1] "function"

``` r
print(class(sum))
```

    ## [1] "function"

Usually, there's no need to fuss about these differences: just use the `is.*()` family of functions. Give it a try:

``` r
is.numeric(a)
```

    ## [1] TRUE

``` r
is.data.frame(iris)
```

    ## [1] TRUE

We can also coerce objects to take on a different form, typically using the `as.*()` family of functions. We can't always coerce! You'll get a sense of this over time, but try:

-   Coercing a number to a character.
-   Coercing a character to a number.
-   Coercing a number to a data.frame. `letters` to a data.frame.

``` r
as.character(100)
```

    ## [1] "100"

``` r
as.numeric("100")*10
```

    ## [1] 1000

``` r
as.numeric("hello") #can't convert strings to numeric. 
```

    ## Warning: NAs introduced by coercion

    ## [1] NA

``` r
as.data.frame(letters)
```

    ##    letters
    ## 1        a
    ## 2        b
    ## 3        c
    ## 4        d
    ## 5        e
    ## 6        f
    ## 7        g
    ## 8        h
    ## 9        i
    ## 10       j
    ## 11       k
    ## 12       l
    ## 13       m
    ## 14       n
    ## 15       o
    ## 16       p
    ## 17       q
    ## 18       r
    ## 19       s
    ## 20       t
    ## 21       u
    ## 22       v
    ## 23       w
    ## 24       x
    ## 25       y
    ## 26       z

There is also a slight difference between coercion and conversion, but this is usually not important.

Vectors
-------

Vectors store multiple entries of a data type. You'll discover that they show up just about everywhere in R, so they're fundamental and extremely important.

### Vector Construction and Basic Subsetting

We've seen vectors as columns of data frames:

``` r
mtcars$hp #vector of horspower of cars in mtcars dataframe.
```

    ##  [1] 110 110  93 110 175 105 245  62  95 123 123 180 180 180 205 215 230
    ## [18]  66  52  65  97 150 150 245 175  66  91 113 264 175 335 109

Use the `c()` function to make a vector consisting of the course code (`"STAT"` and `545`). Notice the coercion. Vectors must be homogeneous.

``` r
(course = c("STAT", 545))
```

    ## [1] "STAT" "545"

``` r
#second entry we input as numeric, but comes out as a character. vectors can only hold 1 type of data/info. 
```

Subset the first entry. Remove the first entry. Note the base-1 system.

``` r
#subsetting: put the index of the entry that you want. 
#here there is a base-1 numbering system, no base 0 system here.
course[1]
```

    ## [1] "STAT"

``` r
course[-1] #will remove the first entry
```

    ## [1] "545"

``` r
sort(course)[1]
```

    ## [1] "545"

``` r
course #original vector remains the same. unless you reassign it...
```

    ## [1] "STAT" "545"

Use `<-` to change the second entry to "545A". Using the same approach, add a third entry, "S01".

``` r
#can edit entries or change entries.
course[2] = "545A" #this will change the vector entries. 
course[3] = "S01"
course[6] = "test"
course
```

    ## [1] "STAT" "545A" "S01"  NA     NA     "test"

Subset the first and third entry. Order matters! Subset the third and first entry.

``` r
course[c(3,1)] #subsetting a vector with a vector. we want the 3rd entry followed by the 1st.
```

    ## [1] "S01"  "STAT"

Explore integer sequences, especially negatives and directions. Especially `1:0` that might show up in loops!

``` r
3:10 #gives a vector from 3-10.
```

    ## [1]  3  4  5  6  7  8  9 10

``` r
10:-5 
```

    ##  [1] 10  9  8  7  6  5  4  3  2  1  0 -1 -2 -3 -4 -5

``` r
1:0 #will not return a vector of length 0. 
```

    ## [1] 1 0

``` r
#vector length 0: 
seq_len(0)
```

    ## integer(0)

``` r
#vector length 10 (from 1-10)
seq_len(10)
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

Singletons are also vectors. Check using `is.vector`.

``` r
is.vector(6)
```

    ## [1] TRUE

``` r
paste("hi", "you")
```

    ## [1] "hi you"

### Vectorization and Recycling

A key aspect of R is its vectorization. Let's work with the vector following vector:

``` r
(a <- 7:-2) #reassign values in vector a. 
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a)) #
```

    ## [1] 10

Square each component:

``` r
a^2 #squares each component of vector a. in base python we'd need to write a for loop. 
```

    ##  [1] 49 36 25 16  9  4  1  0  1  4

Multiply each component by 1 through to its length: (1st entry by 1, 2nd entry by 2, etc... )

``` r
a*1:10 #multiply through the vector 1-10 #pairs each component, and multiplies this way.
```

    ##  [1]   7  12  15  16  15  12   7   0  -9 -20

It's important to know that R will silently recycle! Unless the length of one vector is not divisible by the other. Let's see:

``` r
a*1:3 #will duplicate the 1:3 vector and keep duplicating it until it reaches the same length as a.
```

    ## Warning in a * 1:3: longer object length is not a multiple of shorter
    ## object length

    ##  [1]  7 12 15  4  6  6  1  0 -3 -2

``` r
a*1:12 #notice how it adds two values to the vector corresponding to a[1]*11 and a[2]*12
```

    ## Warning in a * 1:12: longer object length is not a multiple of shorter
    ## object length

    ##  [1]   7  12  15  16  15  12   7   0  -9 -20  77  72

``` r
a*1:2 #will not throw a warning, because 10/2 divides. but it still recycles over 5 times.
```

    ##  [1]  7 12  5  8  3  4  1  0 -1 -4

This is true of comparison operators, too. Make a vector of logicals using a comparison operator.

``` r
a>0
```

    ##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE

Now try a boolean operator. Note that && and || are NOT vectorized!

``` r
a >0 & a<5
```

    ##  [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE

``` r
#first does a>0 then does a<5 and then compares which one is both true, and if we have 2 true it reutrns TRUE in vector.

a >0 && a<5  #not vectorized. used in if statements because you want a true or false and not a vector. it only looks at the first entry of both vectors so a>0[1] =TRUE but a<5[1]= FALSE so overall it is false.
```

    ## [1] FALSE

``` r
#use functions "all" or "any" to reduce a vector of non-1 length
#are any objects in a> 0 and <5?
any(a>0 & a<5)
```

    ## [1] TRUE

``` r
all(a>0 & a<5) 
```

    ## [1] FALSE

Recycling works with assignment, too. Replace the entire vector a with 1:2 repeated:

``` r
a[1:n] = 1:2 #subset positions 1 to n in our vector (length 10) and we replace it with vector of length 2 which gets recycled 5 times.
a
```

    ##  [1] 1 2 1 2 1 2 1 2 1 2

``` r
(a[1:n]=1:2) #returns vector of length 2... we dont know why.
```

    ## [1] 1 2

### Special Subsetting

We can subset vectors by names and logicals, too.

Recall the course vector:

``` r
course <- c("STAT", "545A", "S01")
```

Let's give the components some names ("subject", "code", and "section") using **three** methods:

1.  Using the setNames function.

-   Notice that the vector does not change!!

``` r
setNames(course,c("subject", "code", "section")) #something that sits on top of vector. can ignore this. 
```

    ## subject    code section 
    ##  "STAT"  "545A"   "S01"

1.  Using the names function with `<-`. Also, just explore the names function.

``` r
names(course) = c("subject", "code", "section")
course
```

    ## subject    code section 
    ##  "STAT"  "545A"   "S01"

``` r
names(course) #extracts names and returns character vector of the names if you need this.
```

    ## [1] "subject" "code"    "section"

1.  Re-constructing the vector, specifying names within `c()`.

``` r
course = c(subject = "STAT",code= "545",section= "S01")
course
```

    ## subject    code section 
    ##  "STAT"   "545"   "S01"

Subset the entry labelled "section" and "subject".

``` r
#can subset vector according to names
course["section"]
```

    ## section 
    ##   "S01"

``` r
course["subject"]
```

    ## subject 
    ##  "STAT"

``` r
course[c("section", "code")]
```

    ## section    code 
    ##   "S01"   "545"

``` r
#what happens if we have same names in vector:
foo = c(a = 5, a=6, b = 7)
foo["a"] #only returns the first value
```

    ## a 
    ## 5

``` r
foo[["a"]] #same as above.
```

    ## [1] 5

Amazingly, we can also subset by a vector of logicals (which will be recycled!). Let's work with our integer sequence vector again:

``` r
(a <- 7:-2)
```

    ##  [1]  7  6  5  4  3  2  1  0 -1 -2

``` r
(n <- length(a))
```

    ## [1] 10

``` r
#subset a to all positive entries:
a[a>0] #omits all entries that don't return TRUE. 
```

    ## [1] 7 6 5 4 3 2 1

Lists
-----

Unlike vectors, which are atomic/homogeneous, a list in R is heterogeneous.

Try storing the course code (`"STAT"` and `545`) again, but this time in a list. Use the `list()` function.

``` r
course = list("STAT", 545)
course #first entry a character vector of length 1 and 2nd entry a numeric vector of length 1
```

    ## [[1]]
    ## [1] "STAT"
    ## 
    ## [[2]]
    ## [1] 545

Lists can hold pretty much anything, and can also be named. Let's use the following list:

``` r
(my_list <- list(year=2018, instructor=c("Vincenzo", "Coia"), fav_fun=typeof))
```

    ## $year
    ## [1] 2018
    ## 
    ## $instructor
    ## [1] "Vincenzo" "Coia"    
    ## 
    ## $fav_fun
    ## function (x) 
    ## .Internal(typeof(x))
    ## <bytecode: 0x7fbfd4b2b2a0>
    ## <environment: namespace:base>

``` r
#lists can hold functions, characters, numerics, etc. 
```

Subsetting a list works similarly to vectors. Try subsetting the first element of `my_list`; try subsettig the first *component* of the list. Notice the difference!

``` r
my_list[1]
```

    ## $year
    ## [1] 2018

``` r
#subsets the list. 
my_list[[2]] #sheds that list structure.
```

    ## [1] "Vincenzo" "Coia"

``` r
my_list[2] #a list of length 1 that returns a vector of lenght 1.
```

    ## $instructor
    ## [1] "Vincenzo" "Coia"

``` r
my_list[[2]][1] #subset the first position of the vector from list position 2
```

    ## [1] "Vincenzo"

Try also subsetting by name:

``` r
my_list["year"]
```

    ## $year
    ## [1] 2018

``` r
my_list[["year"]] #returns the content of that list position. 
```

    ## [1] 2018

``` r
my_list$year #$ is common. returns whatever is in that list (ie a vector of length 1). 
```

    ## [1] 2018

Smells a little like `data.frame`s. It turns out a `data.frame` is a special type of list:

``` r
(small_df <- tibble::tibble(x=1:5, y=letters[1:5]))
```

    ## # A tibble: 5 x 2
    ##       x y    
    ##   <int> <chr>
    ## 1     1 a    
    ## 2     2 b    
    ## 3     3 c    
    ## 4     4 d    
    ## 5     5 e

``` r
#is it a list? YES
is.list(small_df)
```

    ## [1] TRUE

``` r
#let's coerce it to a list (notice the change in output in this way)
as.list(small_df)
```

    ## $x
    ## [1] 1 2 3 4 5
    ## 
    ## $y
    ## [1] "a" "b" "c" "d" "e"

``` r
as.vector(small_df)
```

    ## # A tibble: 5 x 2
    ##       x y    
    ##   <int> <chr>
    ## 1     1 a    
    ## 2     2 b    
    ## 3     3 c    
    ## 4     4 d    
    ## 5     5 e

``` r
as.vector(small_df)[1]
```

    ## # A tibble: 5 x 1
    ##       x
    ##   <int>
    ## 1     1
    ## 2     2
    ## 3     3
    ## 4     4
    ## 5     5

``` r
as.vector(small_df)[2]
```

    ## # A tibble: 5 x 1
    ##   y    
    ##   <chr>
    ## 1 a    
    ## 2 b    
    ## 3 c    
    ## 4 d    
    ## 5 e

``` r
#making a matrix:
diag(2) #in matrices you have rows and columns, but must all be the same type. 
```

    ##      [,1] [,2]
    ## [1,]    1    0
    ## [2,]    0    1

Note that there's a difference between a list of one object, and that object itself! This is different from vectors.

``` r
identical(list(4), 4) #list 4 does not = 4
```

    ## [1] FALSE

``` r
identical(c(4), 4) #vector 4 = 4 (vectors dno't have extra baggage around them, lists do.)
```

    ## [1] TRUE

``` r
#identical checks if two arguments are identical. 
```

Part II
=======

Global Environment
------------------

When you assign variables in R, the variable name and contents are stored in an R environment called a global environment.

See what's in the Global Environment by:

-   Executing `ls()`.
-   Looking in RStudio, in the "Environments" pane.

Making an assignment "binds" an object to a name within an environment. For example, writing `a <- 5` assigns the object `5` to the name `a` in the global environment.

The act of "searching for the right object to return" is called scoping.

By the way: the global environment is an object, too! It's the output of `globalenv()`, and is also stored in the variable `.GlobalEnv`:

``` r
globalenv()
```

    ## <environment: R_GlobalEnv>

``` r
.GlobalEnv
```

    ## <environment: R_GlobalEnv>

The Search Path
---------------

How does R know what `iris` is, yet `iris` does not appear in the global environment? What about functions like `length`, `sum`, and `print` (which are all objects, too)?

Let's explore.

1.  Each package has its own environment.
    -   Install and load the `pryr` package, and use `ls()` to list its bindings (its name is "package:pryr").
2.  There's a difference between an *environment* and its *name*. Get the environment with name "package:pryr" using the `as.environment()` function.

3.  Each environment has a parent. Use `parent.env()` to find the parent of the global environment.

4.  There are packages that come pre-loaded with R, and they're loaded in a sequence called the search path. Use `search()` to identify that path; then see it in RStudio.

First scoping rule: R looks to the parent environment if it can't find an object where it is.

1.  Use `pryr::where()` to determine where the first binding to the name `iris` is located.

2.  Override `iris` with, say, a numeric. Now `where()` is it? Can you extract the original?

3.  Override `sum` with, say, a numeric. `where()` is `sum` now? Can you still use the original `sum()` function?

Special scoping rule for functions! R knows whether or not to look for a function.

1.  Look at the source code of the `pryr:where()` function. It contains a line that creates a binding for "env". Why, then, is `env` nowhere to be found? Answer: execution environments.

``` r
#pryr::where
```
