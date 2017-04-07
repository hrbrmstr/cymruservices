#' Check to see if Team Cymru WHOIS servers are up
#'
#' @md
#' @param timeout how long to wait for a response (seconds). Default is one second.
#' @param count number of pings to issue. Default is three pings.
#' @param verbose be verbose in output? Default `FALSE`.
#' @export
#' @examples
#' cymru_active()
cymru_active <- function(timeout = 1, count = 3L, verbose = TRUE) {

  if (verbose) message("Testing v4 WHOIS")

  res <- pingr::ping_port("v4.whois.cymru.com", 43L, count=count, verbose=verbose, timeout=timeout)

  if (all(is.na(res))) {
    if (verbose) message("All pings failed, server is likely unavailable.")
    return(FALSE)
  }

  if (any(is.na(res))) {
    if (verbose) message("Some pings were not successful. Server access may be spotty.")
  }

  return(!all(is.na(res)))

}
