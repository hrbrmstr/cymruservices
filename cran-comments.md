## Test environments
* local OS X install, R 3.2.3
* ubuntu 12.04 (on travis-ci), R 3.2.3
* ubuntu 14.04 R-devel
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

The NOTE is that words may be mis-spelled. They are not. ASN and BGP are
acronyms that I spell out and even have them in '' quotes but the checker
still whines. 

* This is a maintenance release to address socket connection issues causing
  error messages on CRAN. I've wrapped the examples in \dontrun{} but
  left the tests in place. purrr::safely is now used for all socket-y
  operations and a timeout parameter has been added to core functions since
  not many R folk are aware of the timeout option setting.
