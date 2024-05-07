# songify

<!-- badges: start -->

[![R-CMD-check](https://github.com/kbacigalupi/songify/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kbacigalupi/songify/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

The goal of songify is to allow users to generate a recommended song or playlist with inputs that they set.

## Installation

You can install the development version of songify from [GitHub](https://github.com/) with:

``` r
install.packages("devtools")
#> Installing package into '/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/RtmppD4oTu/temp_libpath1041912fafd88'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T//Rtmp3Sd9ua/downloaded_packages
devtools::install_github("kbacigalupi/songify")
#> Downloading GitHub repo kbacigalupi/songify@HEAD
#> rlang       (1.1.1  -> 1.1.3) [CRAN]
#> cli         (3.6.1  -> 3.6.2) [CRAN]
#> utf8        (1.2.3  -> 1.2.4) [CRAN]
#> fansi       (1.0.4  -> 1.0.6) [CRAN]
#> withr       (2.5.0  -> 3.0.0) [CRAN]
#> cpp11       (0.4.6  -> 0.4.7) [CRAN]
#> timechange  (0.2.0  -> 0.3.0) [CRAN]
#> glue        (1.6.2  -> 1.7.0) [CRAN]
#> tidyr       (1.3.0  -> 1.3.1) [CRAN]
#> tidyselect  (1.2.0  -> 1.2.1) [CRAN]
#> stringr     (1.5.0  -> 1.5.1) [CRAN]
#> stringi     (1.7.12 -> 1.8.4) [CRAN]
#> lubridate   (1.9.2  -> 1.9.3) [CRAN]
#> lifecycle   (1.0.3  -> 1.0.4) [CRAN]
#> openssl     (2.1.0  -> 2.1.2) [CRAN]
#> curl        (5.2.0  -> 5.2.1) [CRAN]
#> xml2        (1.3.5  -> 1.3.6) [CRAN]
#> prettyunits (1.1.1  -> 1.2.0) [CRAN]
#> progress    (1.2.2  -> 1.2.3) [CRAN]
#> vroom       (1.6.3  -> 1.6.5) [CRAN]
#> readr       (2.1.4  -> 2.1.5) [CRAN]
#> Installing 21 packages: rlang, cli, utf8, fansi, withr, cpp11, timechange, glue, tidyr, tidyselect, stringr, stringi, lubridate, lifecycle, openssl, curl, xml2, prettyunits, progress, vroom, readr
#> Installing packages into '/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/RtmppD4oTu/temp_libpath1041912fafd88'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T//Rtmp3Sd9ua/downloaded_packages
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/Rtmp3Sd9ua/remotes104e07b397e4a/kbacigalupi-songify-4884a76/DESCRIPTION’ ... OK
#> * preparing ‘songify’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘songify_0.0.0.9000.tar.gz’
#> Installing package into '/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/RtmppD4oTu/temp_libpath1041912fafd88'
#> (as 'lib' is unspecified)
library(songify)
#> Registered S3 method overwritten by 'songify':
#>   method         from    
#>   print.playlist spotifyr
```

## Using Songify

Use the `rec_song()` function with a variety of potential inputs to get a single song recommendation.

``` r
rec_song("pop", instrumentalness = 1)
```

Use the `rec_playlist()` function with a variety of potential inputs to get a full playlist recommendation.

``` r
rec_playlist("hip hop", nsongs = 10)
```

## Data Set

Songify also includes a data set of Taylor Swift Songs with a variety of measures of song type.

``` r
songify::song_bank
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this.
