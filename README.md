<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/hrbrmstr/cymruservices.svg)](https://travis-ci.org/hrbrmstr/cymruservices) [![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/cymruservices)](http://cran.r-project.org/package=cymruservices) ![downloads](http://cranlogs.r-pkg.org/badges/grand-total/cymruservices)

![img](dragonr.jpg)

cymruservices is an R package that provides interfaces to various [Team Cymru Services](http://www.team-cymru.org/services.html) including:

-   [The Bogon Reference](http://www.team-cymru.org/bogon-reference.html)
-   [The IP to ASN Mapping Project](http://www.team-cymru.org/IP-ASN-mapping.html)
-   [The Malware Hash Registry](http://www.team-cymru.org/MHR.html)

The following functions are implemented:

-   `bulk_origin`: Retrieves BGP Origin ASN info for a list of IPv4 addresses
-   `bulk_origin_asn`: Retrieves BGP Origin ASN info for a list of ASN ids
-   `bulk_peer`: Retrieves BGP Peer ASN info for a list of IPv4 addresses
-   `ipv4_bogons`: Retrieve list of IPv4 "full bogons" from Team Cymru webservice
-   `ipv6_bogons`: Retrieve list of IPv6 "full bogons" from Team Cymru webservice
-   `malware_hash`: Retrieves malware hash metadata from the Malware Hash Registry
-   `flush`: flush one or more API caches

### News

-   Version 0.3.0 uses `memoise` to cache API responses. See `flush()` for details. functions that used to return `data.frame`s now return `tbl_df`s
-   Version 0.2.0 `timeout` parameter added to `whois`-based functions
-   Version 0.1.0 is on CRAN
-   Version 0.1.0.9999 released

### Installation

``` r
devtools::install_github("hrbrmstr/cymruservices")
# OR
install.packages("cymruservices")
```

### Usage

``` r
library(cymruservices)
#> 
#> Attaching package: 'cymruservices'
#> The following object is masked from 'package:base':
#> 
#>     flush

# current verison
packageVersion("cymruservices")
#> [1] '0.3.0'
```

### Test Results

``` r
library(cymruservices)
library(testthat)

date()
#> [1] "Sun Mar  6 09:35:09 2016"

# only using `force=TRUE` to ensure output for the example
# see the help for each function to see why this is a bad
# idea to run force all the time
head(ipv4_bogons(force=TRUE))
#> [1] "0.0.0.0/8"     "2.56.0.0/14"   "5.8.248.0/21"  "5.45.32.0/20"  "5.133.64.0/18" "5.180.0.0/14"

head(ipv6_bogons(force=TRUE))
#> [1] "::/8"     "100::/8"  "200::/7"  "400::/6"  "800::/5"  "1000::/4"

bulk_origin(c("68.22.187.5", "207.229.165.18", "198.6.1.65"))
#> Source: local data frame [3 x 7]
#> 
#>      as             ip       bgp_prefix    cc registry  allocated
#>   (dbl)          (chr)            (chr) (chr)    (chr)      (chr)
#> 1 23028    68.22.187.5   68.22.187.0/24    US     arin 2002-03-15
#> 2  6079 207.229.165.18 207.229.128.0/18    US     arin           
#> 3   701     198.6.1.65     198.6.0.0/16    US     arin           
#> Variables not shown: as_name (chr)

bulk_peer(c("68.22.187.5", "207.229.165.18", "198.6.1.65"))
#> Source: local data frame [13 x 7]
#> 
#>    peer_as             ip       bgp_prefix    cc registry  allocated                                   peer_as_name
#>      (dbl)          (chr)            (chr) (chr)    (chr)      (chr)                                          (chr)
#> 1      174    68.22.187.5   68.22.187.0/24    US     arin 2002-03-15          COGENT-174 - Cogent Communications,US
#> 2     2381    68.22.187.5   68.22.187.0/24    US     arin 2002-03-15                       WISCNET1-AS - WiscNet,US
#> 3     1273 207.229.165.18 207.229.128.0/18    US     arin                    CW Cable and Wireless Worldwide plc,GB
#> 4     2381 207.229.165.18 207.229.128.0/18    US     arin                                  WISCNET1-AS - WiscNet,US
#> 5     2603 207.229.165.18 207.229.128.0/18    US     arin                                      NORDUNET NORDUnet,NO
#> 6     3257 207.229.165.18 207.229.128.0/18    US     arin                                 GTT-BACKBONE Tinet Spa,DE
#> 7     3356 207.229.165.18 207.229.128.0/18    US     arin                  LEVEL3 - Level 3 Communications, Inc.,US
#> 8      174     198.6.1.65     198.6.0.0/16    US     arin                     COGENT-174 - Cogent Communications,US
#> 9     1299     198.6.1.65     198.6.0.0/16    US     arin                                TELIANET TeliaSonera AB,SE
#> 10    2914     198.6.1.65     198.6.0.0/16    US     arin            NTT-COMMUNICATIONS-2914 - NTT America, Inc.,US
#> 11    3257     198.6.1.65     198.6.0.0/16    US     arin                                 GTT-BACKBONE Tinet Spa,DE
#> 12    3356     198.6.1.65     198.6.0.0/16    US     arin                  LEVEL3 - Level 3 Communications, Inc.,US
#> 13    3549     198.6.1.65     198.6.0.0/16    US     arin               LVLT-3549 - Level 3 Communications, Inc.,US

bulk_origin_asn(c(22822, 1273, 2381, 2603, 2914, 3257, 3356, 11164,
                  174, 286, 1299, 2914, 3257, 3356, 3549, 22822))
#> Source: local data frame [16 x 5]
#> 
#>       as    cc registry  allocated                                        as_name
#>    (dbl) (chr)    (chr)      (chr)                                          (chr)
#> 1  22822    US     arin 2001-11-28             LLNW - Limelight Networks, Inc.,US
#> 2   1273    EU  ripencc                    CW Cable and Wireless Worldwide plc,GB
#> 3   2381    US     arin                                  WISCNET1-AS - WiscNet,US
#> 4   2603    NO  ripencc                                      NORDUNET NORDUnet,NO
#> 5   2914    US     arin            NTT-COMMUNICATIONS-2914 - NTT America, Inc.,US
#> 6   3257    DE  ripencc                                 GTT-BACKBONE Tinet Spa,DE
#> 7   3356    US     arin 2000-03-10       LEVEL3 - Level 3 Communications, Inc.,US
#> 8  11164    US     arin 2014-07-11       INTERNET2-TRANSITRAIL-CPS - Internet2,US
#> 9    174    US     arin                     COGENT-174 - Cogent Communications,US
#> 10   286    NL  ripencc                                           KPN KPN B.V.,NL
#> 11  1299    EU  ripencc                                TELIANET TeliaSonera AB,SE
#> 12  2914    US     arin            NTT-COMMUNICATIONS-2914 - NTT America, Inc.,US
#> 13  3257    DE  ripencc                                 GTT-BACKBONE Tinet Spa,DE
#> 14  3356    US     arin 2000-03-10       LEVEL3 - Level 3 Communications, Inc.,US
#> 15  3549    US     arin 2000-03-21    LVLT-3549 - Level 3 Communications, Inc.,US
#> 16 22822    US     arin 2001-11-28             LLNW - Limelight Networks, Inc.,US

malware_hash(c("1250ac278944a0737707cf40a0fbecd4b5a17c9d",
              "7697561ccbbdd1661c25c86762117613",
              "cbed16069043a0bf3c92fff9a99cccdc",
              "e6dc4f4d5061299bc5e76f5cd8d16610",
              "e1112134b6dcc8bed54e0e34d8ac272795e73d74"))
#> Source: local data frame [5 x 3]
#> 
#>                                   sha1_md5 last_known_timestamp detection_pct
#>                                      (chr)               (time)         (dbl)
#> 1 1250ac278944a0737707cf40a0fbecd4b5a17c9d  2016-03-06 14:35:12            NA
#> 2         7697561ccbbdd1661c25c86762117613  2016-03-06 14:35:12            NA
#> 3         cbed16069043a0bf3c92fff9a99cccdc  2016-03-06 14:35:12            NA
#> 4         e6dc4f4d5061299bc5e76f5cd8d16610  2016-03-06 14:35:12            NA
#> 5 e1112134b6dcc8bed54e0e34d8ac272795e73d74  2016-03-06 14:35:12            NA

test_dir("tests/")
#> testthat results ========================================================================================================
#> OK: 6 SKIPPED: 0 FAILED: 0
```

### Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
