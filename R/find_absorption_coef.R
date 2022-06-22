#' Find the absorption at a specific wavelength
#'
#' @param wavelength (num) Vector of wavelengths (nm)
#' @param absorption (num) Vector of absorption coefficients (m^-1)
#' @param specific_wavelength (num) Wavelength (nm) that you want to find CDOM absorption at
#'
#' @return (num) Absorption coefficient the specified wavelength
#' @export
#'
#' @examples

find_absorption_coef <- function(wavelength,
                                 absorption,
                                 specific_wavelength) {

  stopifnot(is.numeric(wavelength))
  stopifnot(is.numeric(absorption))
  stopifnot(is.numeric(specific_wavelength))

  # check to make sure data includes the wavelength of interest
  if (specific_wavelength %in% wavelength) {

    # find absorption value associated with the specified wavelength
    abs <- absorption[[which(wavelength == specific_wavelength)]]

    return(abs)

  } else {
    stop("Your data does not include the wavelength specified")
  }

}
