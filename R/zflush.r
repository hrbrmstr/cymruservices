list(
  "origin" = bulk_origin,
  "peer" = bulk_peer,
  "asn" = bulk_origin_asn,
  "v4_bogons" = ipv4_bogons,
  "v6_bogons" = ipv6_bogons,
  "hash" = malware_hash
) -> valid_flushed

#' Flush cached results
#'
#' Within a given R session, it will be highly unlikely that API responses
#' to calls to Team Cymru services will change if the parameters have
#' not varied (i.e. you use the same vector of IP addresses again). To
#' respect the resources that have beeen freely provided, all the API
#' functions cache their results.\cr
#' \cr
#' It may be advantageous or necessary to invalidate one or more of these
#' caches. This function allows for the invalidation of one or more (or all)
#' caches.
#'
#' @param ... strings naming cached results to flush. Can be any of
#'        "\code{origin}", "\code{peer}", "\code{asn}", "\code{v4_bogons}",
#'        "\code{v6_bogons}" or "\code{hash}". If no parameters
#'        are specified all caches will be flushed.
#' @param quiet if \code{TRUE} no diagnostic or informative messages will be
#'        displayed. If \code{FALSE} warnings for unknown cache names and
#'        invalidation progress for valid caches will be displayed if
#'        the session is interactive.
#' @export
#' @note Invalid cache names will be ignored. If \code{quiet} is \code{FALSE}
#'       and \code{flush} was called from an interactive session invalid
#'       cache names will be noted.\cr\cr Also, you will still need to
#'       \code{force} the reloading of bogon lists if you are within the 4
#'       hour window even if you invalided the memoised cache.
#' @examples \dontrun{
#' flush("peer", "origin")
#' flush()
#' }
flush <- function(..., quiet=TRUE) {

  dots <- unlist(list(...), use.names = FALSE)

  can_flush <- names(valid_flushed)
  if (length(dots) == 0) { dots <- can_flush }

  confused <- setdiff(dots, can_flush)
  if (length(confused) > 0 & (!quiet) & interactive()) {
    warning(sprintf("Ignoring unrecognized caches: %s",
                    paste(sprintf("'%s'", confused), sep="", collapse=", ")))
  }

  ok <- intersect(can_flush, dots)
  if (length(ok) > 0) {
    for(x in ok) {
      if ((!quiet) & interactive()) message(sprintf("Flushing '%s'...", x))
      memoise::forget(valid_flushed[[x]])
    }
  }

}

