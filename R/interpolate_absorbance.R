#' Interpolate absorbance values to obtain absorance at integer wavelengths
#'
#' Some spectrophotometers return data where wavelengths are not whole numbers. This function uses linear interpolation to produce absorbance values at integer wavelengths.
#'
#' @param wavelength (num) Vector of wavelength values
#' @param absorbance (num) Vector of absorbance values
#' @param start (num)
#' @param end
#'
#' @return
#' @export
#'
#' @examples
interpolate_absorbance <- function(wavelength,
                                   absorbance,
                                   start = 200,
                                   end = 800) {

  integer_wl <- c(start:end) # create vector with integer wavelengths
  interpolated_abs <- vector("double", length(integer_wl)) # create empty vector for interpolate absorbances

  # loop to calculate interpolated absorbance at each wavelength
  for (i in seq_along(integer_wl)) {

    # if wavelength is already a whole number, no interpolated needed
    if (integer_wl[[i]] %in% wavelength) {
      interpolated_abs[[i]] <- absorbance[[ which(integer_wl[[i]] == wavelength)]]

    # if not a whole number, interpolate using choosing absorption values just above and below integer wavelength
    } else {
      x1 = max(wavelength [wavelength < integer_wl[[i]] ]) # choose raw wavelength that is just below integer
      x2 = min(wavelength [wavelength > integer_wl[[i]] ]) # choose raw wavelength that is just above integer
      y1 = absorbance[[ which(wavelength == x1) ]] # absorbance associated with wavelength just below integer
      y2 = absorbance[[ which(wavelength == x2) ]] # absorbance associated with wavelength just above integer

      m = (y2-y1)/(x2-x1) # slope for linear interpolation
      b = -m*x1+y1 # y-intercept for linear interpolation
      interpolated_abs[i] <-  m * integer_wl[i] + b # interpolated absorbance
    }
  }

  # combine wavelength and absorbance vectors into a dataframe
  output <- cbind(integer_wl, interpolated_abs)
  output <- as.data.frame(output)
  return(output)

}

