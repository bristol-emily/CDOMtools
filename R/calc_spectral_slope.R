#' Calculate CDOM absorption spectral slope
#'
#' This function calculates the slope of log-transformed absorption spectra. Spectral slope within the 275-295 nm region is often used as a proxy for DOM molecular weight.
#'
#' See Helms et al. (2008) "Absorption spectral slopes and slope ratios as indicators of molecular weight, source, and photobleaching of chromophoric dissolved organic matter". https://doi.org/10.4319/lo.2008.53.3.0955
#'
#' @param wavelength (num) Vector of wavelengths (nm)
#' @param absorption (num) Vector of absorption coefficients (m^-1)
#' @param start (num) Start of the slope region (nm). Default value is 275.
#' @param end (num) End of the slope region (nm). Default is value is 295.
#' @param limit_of_quantification (num) Instrument lower limit of quantification for the specified wavelength region (m^-1). Default value is 0 (i.e. no cutoff).
#'
#' @return Log transformed spectral slope in specified region
#' @export
#'
#' @examples

calc_spectral_slope <- function(wavelength,
                                absorption,
                                start = 275,
                                end = 295,
                                limit_of_quantification = 0) {

  stopifnot(is.numeric(wavelength))
  stopifnot(is.numeric(absorption))
  stopifnot(is.numeric(start))
  stopifnot(is.numeric(end))
  stopifnot(is.numeric(limit_of_quantification))

  if (any(is.na(wavelength)) | any(is.na(absorption))) {
    warning("There are NA values in the wavelength and/or absorption vectors.")
  }

  if (limit_of_quantification == 0) {
    warning("Limit of quantification argument defaults to 0.
            Depending on instrument accuracy and sensitivity, spectral slope calculations may not be accurate when absorption is low.")
  }

  if (start %in% wavelength & end %in% wavelength) {
    wl <- wavelength[which(wavelength >= start & wavelength <= end)]
    abs <- absorption[which(wavelength >= start & wavelength <= end)]
  } else {
    stop("Start and end wavelengths must be within the supplied wavelength vector")
  }

  if (any(abs < 0)) {
    stop("There are negative absorption values within this region.
         Spectral slope cannot be calculated.")
  }

  # only calculate slope if absorption in the specified range is greater than
  # the instrument limit of quantification
  if (all(abs > limit_of_quantification)) {
    slope <- coef(lm(log(abs) ~ wl))[[2]]
    return(abs(slope))
  } else {
    message("Absorption values were below the limit of quantification and no slope was calculated.")
    return(NA)
  }
}
