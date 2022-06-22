#' Calculate Specific Ultraviolet Absorbance (SUVA)
#'
#' Specific ultraviolent absorbance (SUVA) is the UV absorption of a water sample at a particular wavelength, normalized by dissolved organic carbon (DOC) concentration.
#'
#' SUVA at 254 nm is commonly used as an indicator of DOC aromaticity (Weishaar et al. 2003). SUVA should be calculated using decadic rather than Napierien absorption coefficients and DOC concentrations should be milligrams carbon per liter.
#'
#' @param wavelength (num) Vector of integer wavelengths
#' @param absorption (num) Vector of absorption coefficients (m^-1)
#' @param DOC (num) Dissolved organic carbon concentration
#' @param specific_wavelength (num) Wavelength (nm) to calculate SUVA at. Default is 254.
#' @param absorption_coef (chr) Either "napierien" or "decadic". Default is "napierien". If "napierien", will convert to absorption to decadic method for the SUVA calculation.
#' @param DOC_unit (chr) Either "umol" or "mg". Is 'DOC' in units micromol C per liter or milligrams carbon per liter? Default is "mg".
#'
#' @return Specific ultraviolet absorption at the specified wavelength, normalized by dissolved organic carbon concentration
#' @export
#'
#' @examples
#'
#'
calc_SUVA <- function(wavelength,
                      absorption,
                      DOC,
                      specific_wavelength = 254,
                      absorption_coef = "napierien",
                      DOC_unit = "mg") {

  stopifnot(is.numeric(wavelength))
  stopifnot(is.numeric(absorption))
  stopifnot(is.numeric(DOC))
  stopifnot(is.numeric(specific_wavelength))

  if (specific_wavelength < 200 | specific_wavelength > 800) {
    stop("SUVA should be calculated at one wavelength between 200 and 800 nm.
         Typically SUVA is calculated at 254 nm.")
  }

  if (absorption_coef == "napierien") {
    # if input is napierien absorption coefficients, convert to decadic
    abs <- absorption[[which(wavelength == specific_wavelength)]] / 2.303
  } else if (absorption_coef == "decadic") {
    abs <- absorption[[which(wavelength == specific_wavelength)]]
  } else {
    stop("'absorption_coef' argument must be either 'napierien' or 'decadic'")
  }

  if (DOC_unit == "umol") {
    # if DOC unit is micromol C/L, convert to mg C/L
    DOC <- DOC * 12.0107 / 1000
  } else if (DOC_unit == "mg") {
    # if DOC unit is mg C/L, do not convert
    NULL
  } else {
    stop("'DOC_unit' must be either 'umol' or 'mg'")
  }

  SUVA <- abs / DOC
  return(SUVA)

}

