#' Calculate the spectral slope ratio
#'
#' Calculates the ratio of log-transformed slopes in the 275-295 to 350-400 nm regions
#'
#' @param wavelength (num) Vector of wavelengths (nm)
#' @param absorption (num) Vector of absorption coefficients (m^-1)
#' @param limit_of_quantification (num) Instrument lower limit of quantification (m^-1) for the 275-400 nm region. Defaults to 0.
#'
#' @return (num) Ratio of spectral slopes in the 275-295 to 350-400 nm regions
#'
#'


calc_slope_ratio <- function(wavelength,
                             absorption,
                             limit_of_quantification = 0) {


  stopifnot(is.numeric(wavelength))
  stopifnot(is.numeric(absorption))

  if (any(is.na(wavelength)) | any(is.na(absorption))) {
    warning("There are NA values in the wavelength and/or absorption vectors.")
  }

  if (limit_of_quantification == 0) {
    warning("Limit of quantification argument defaults to 0.
            Spectral slope calculations may not be accurate when absorption is low.")
  }

  # check if data includes necessary wavelengths
  stopifnot("Data does not contain all data in the 275-295 and/or 350-400 nm regions" =
              c(275:295, 350:400) %in% wavelength)

  # check if wavelength and absorption vectors are the same length
  stopifnot("Wavelength and absorption vectors are not the same length" =
              length(wavelength) == length(absorption))

  # define wavelength ranges
  wl1 <- 275:295
  wl2 <- 350:400

  # find absorption values within wavelength regions
  abs1 <- absorption[which (wavelength >= 275 & wavelength <= 295)]
  abs2 <- absorption[which (wavelength >= 350 & wavelength <= 400)]

  # calculates slope ratio if all absorbance values are greater than limit of quantification
  if (all(abs1 > limit_of_quantification) &
      all(abs2 > limit_of_quantification)) {

    # calculate slope of log transformed absorbance
    slope1 <- coef(lm(log(abs1) ~ wl1))[[2]]
    slope2 <- coef(lm(log(abs2) ~ wl2))[[2]]

    # return ratio of two slopes
    return(abs(slope1/slope2))

  } else {
    # if absorption is low at 400 nm, function returns NA
    warning("Some absorption values were below the limit of quantification \n
            so the spectral slope was not calculated")
    return(NA)
  }
}
