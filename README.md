
<!-- README.md is generated from README.Rmd. Please edit that file -->

# songify

<!-- badges: start -->

[![R-CMD-check](https://github.com/kbacigalupi/songify/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kbacigalupi/songify/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of songify is to allow users to generate a recommended song or
playlist with inputs that they set.

## Installation

You can install the development version of songify from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
#> Installing package into '/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/RtmpB3ksG7/temp_libpath10e14020759c'
#> (as 'lib' is unspecified)
#> 
#> The downloaded binary packages are in
#>  /var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T//Rtmpw8ATcQ/downloaded_packages
devtools::install_github("kbacigalupi/songify")
#> Downloading GitHub repo kbacigalupi/songify@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/Rtmpw8ATcQ/remotes1d2c570d7afc/kbacigalupi-songify-dc8e77b/DESCRIPTION’ ... OK
#> * preparing ‘songify’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘songify_0.0.0.9000.tar.gz’
#> Installing package into '/private/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T/RtmpB3ksG7/temp_libpath10e14020759c'
#> (as 'lib' is unspecified)
#> Warning in i.p(...): installation of package
#> '/var/folders/59/4vj2jn9j0qs9r8tmgl5d093m0000gn/T//Rtmpw8ATcQ/file1d2c3605630a/songify_0.0.0.9000.tar.gz'
#> had non-zero exit status
```

## Using Songify

Use the `song_rec()` function with a variety of potential inputs to get
a single song reccomendation.

``` r
library(songify)
#> Registered S3 method overwritten by 'songify':
#>   method         from    
#>   print.playlist spotifyr
## basic example code
```

Use the `playlist_rec()` function with a variety of potential inputs to
get a full playlist reccomednation.

## Data Set

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this.

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
