
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CDOMtools

CDOMtools provides various functions for processing UV-visible
absorption spectra for analysis of chromophoric dissolved organic matter
(CDOM).

## Installation

You can install the development version of CDOMtools from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bristol-emily/CDOMtools", build_vignettes = TRUE)
#> * checking for file ‘/private/var/folders/xh/tn8cy5m14qjb1861dc8csc000000gn/T/Rtmp6uQl6c/remotes5cd66796a83c/bristol-emily-CDOMtools-3e3cf30/DESCRIPTION’ ... OK
#> * preparing ‘CDOMtools’:
#> * checking DESCRIPTION meta-information ... OK
#> * installing the package to build vignettes
#> * creating vignettes ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘CDOMtools_0.1.0.tar.gz’

## load library
library(CDOMtools)
```

## Example: Calculate Napierian absorption coefficients

An example for converting optical density/absorbance to Napierian
absorption coefficients
(![m^{-1}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;m%5E%7B-1%7D "m^{-1}")).

``` r
## load example absorption spectra dataset
data("example")

## create a new column that contains napierian absorption coefficients
example$absorption <- calc_absorption_coef(example$absorption, # vector of absorbance values
                                   method = "napierian", # specify napierian or decadic units
                                   path_length = 0.01) # path length (i.e. cuvette diameter)
  
```

## Example: Calculate spectral slope

Calculate the log-transformed spectral slope in the 275-295 nm
wavelength region.

``` r
slope <- calc_spectral_slope(example$wavelength, # vector of wavelength values (nm)
                             example$absorption, # vector of absorption values (m^-1)
                             start = 275, # start of wavelength region
                             end = 295) # end of wavelength region
```

## Example: Calculate specific ultraviolet absorbance

Calculate specific ultraviolet absorbance (decadic units) normalized by
DOC concentration in
![mg L^-1](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;mg%20L%5E-1 "mg L^-1")
(e.g. ![SUVA_254](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;SUVA_254 "SUVA_254")).

``` r
SUVA254 <- calc_SUVA(example$wavelength, # vector of wavelength values (nm)
                     example$absorption, # vector of absorption values 
                     11.3, # DOC concentration
                     specific_wavelength = 254, # specific wavelength of interest 
                     absorption_coef = "napierien", # unit of absorption value provided
                     DOC_unit = "mg") # unit of DOC value provided
```

## Vignettes

See the following vignette for an example workflow to process batches of
CDOM data acquired using OceanView software:

``` r
browseVignettes("oceanview-workflow")
```
