#' Convert absorbance units to Napierian or decadic absorption coefficients
#'
#' @param absorbance (num) Absorbance unit
#' @param method (chr) Either "napierian" or "decadic". Default method is "napierian".
#' @param path_length (num) Cuvette path length in meters. Default is 0.01 m (1 cm).
#'
#' @return Absorption coefficient(s) (m^-1)
#' @export
#'
#' @examples

calc_absorption_coef <- function(absorbance,
                                 method = "napierian",
                                 path_length = 0.01) {

  stopifnot(is.numeric(absorbance))
  stopifnot(is.numeric(path_length))

  if (path_length != "0.01" | path_length != "0.1") {
    warning("Cuvette path length is typically 0.01 m or 0.1 m.")
  }

  if (method == "napierian") {
    # calculate napierian absorption coefficient (m^-1)
    a <- absorbance * 2.303 / path_length
  } else if (method == "decadic") {
    # calculate decadic absorption coefficient (m^-1)
    a <- absorbance / path_length
  } else {
    stop("Argument 'type' must be either be 'napierian' or 'decadic'.")
  }

  return(a)

}
