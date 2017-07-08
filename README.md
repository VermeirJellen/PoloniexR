PoloniexR
================

[![Travis-CI Build Status](https://travis-ci.org/VermeirJellen/PoloniexR.svg?branch=master)](https://travis-ci.org/VermeirJellen/PoloniexR)

This package aims to provide a user-friendly R wrapper on top of the Poloniex (Cryptocurrency Trading) REST API. Results are converted into R datastructures and are returned to the users in a more intuitive manner.

Installation:

``` r
# install.packages("devtools"")
devtools::install_github("VermeirJellen/PoloniexR")
```

PoloniexPublicAPI / PoloniexTradingAPI
--------------------------------------

A `PoloniexPublicAPI` object can be created as follows:

`poloniex.public <- PoloniexPublicAPI()`

Methods Provided:

-   `ReturnTicker`
-   `Return24hVolume`
-   `ReturnOrderBook`
-   `ReturnTradeHistory`
-   `ReturnChartData`
-   `ReturnCurrencies`
-   `ReturnLoanOrders`

A `PoloniexTradingAPI` object can be created as follows:

`poloniex.trading <- PoloniexTradingAPI(key, secret)`

Methods Provided:

-   **ProcessTradingRequest()**: Allows the users to call any of the trading API methods that are provided by Poloniex.
-   `ReturnBalances`
-   `ReturnCompleteBalances`

Todo: Higher level methods can potentially be wrapped on top of the `ProcessTradingRequest` method (as was done for the `ReturnBalances` and `ReturnCompleteBalances` functions).

**!! EXAMPLES BELOW !!**

### PUBLIC API - EXAMPLES

#### ReturnTicker

Run `?ReturnTicker` for additional function documentation.

``` r
library(PoloniexR)
poloniex.public <- PoloniexPublicAPI()
ticker.info     <- ReturnTicker(poloniex.public)
head(ticker.info)
```

    ##          id       last  lowestAsk highestBid percentChange    baseVolume
    ## BTC_BCN   7 0.00000063 0.00000063 0.00000062   -0.08695652  277.37903586
    ## BTC_BELA  8 0.00008232 0.00008279 0.00008232   -0.00843170  180.74523509
    ## BTC_BLK  10 0.00013070 0.00013070 0.00013020   -0.03221029  288.08522392
    ## BTC_BTCD 12 0.02220520 0.02220774 0.02220520   -0.03962728   29.51489308
    ## BTC_BTM  13 0.00026391 0.00026489 0.00026392   -0.05944616   20.51282144
    ## BTC_BTS  14 0.00007164 0.00007165 0.00007164   -0.04759372 3438.28410768
    ##                 quoteVolume isFrozen   high24hr    low24hr
    ## BTC_BCN  434688688.47180653        0 0.00000070 0.00000057
    ## BTC_BELA   2230639.75011194        0 0.00008469 0.00007557
    ## BTC_BLK    2332774.02799669        0 0.00016600 0.00010553
    ## BTC_BTCD      1327.84009431        0 0.02337140 0.02111147
    ## BTC_BTM      76248.78981316        0 0.00029592 0.00024126
    ## BTC_BTS   49528426.61819916        0 0.00007727 0.00006233

#### Return24hVolume

Run `?Return24hVolume` for additional function documentation.

``` r
poloniex.public <- PoloniexPublicAPI()
volume.info <- Return24hVolume(poloniex.public)
head(volume.info$volume.pairs)
```

    ##               pair1        pair2
    ## BTC_BCN   277.37904 434688688.47
    ## BTC_BELA  180.74524   2230639.75
    ## BTC_BLK   288.08522   2332774.03
    ## BTC_BTCD   29.51489      1327.84
    ## BTC_BTM    20.51282     76248.79
    ## BTC_BTS  3438.28411  49528426.62

``` r
volume.info$volume.totals
```

    ##                   BTC            ETH              USDT            XMR
    ## volume 83837.31200634 14808.30274235 56464510.28486143 72456.61452282
    ##              XUSD
    ## volume 0.00000000

#### ReturnOrderBook

Run `?ReturnOrderBook` for additional function documentation.

``` r
pair       <- "BTC_NXT"
depth      <- 10
order.book <- ReturnOrderBook(poloniex.public,
                              pair  = pair,
                              depth = depth)
head(order.book$bid)
```

    ##          bid        amount
    ## 1 0.00004251  425.78917834
    ## 2 0.00004250    5.87647059
    ## 3 0.00004245   12.79422658
    ## 4 0.00004244 2036.17298307
    ## 5 0.00004227            30
    ## 6 0.00004224           500

``` r
head(order.book$ask)
```

    ##          ask         amount
    ## 1 0.00004307  4678.09810846
    ## 2 0.00004308 19366.08667495
    ## 3 0.00004310          19.97
    ## 4 0.00004311   267.18138451
    ## 5 0.00004312  3930.80563282
    ## 6 0.00004314   709.15314188

``` r
order.book$frozen
```

    ## [1] FALSE

``` r
order.book$seq
```

    ## [1] 37161720

``` r
pair       <- "all"
depth      <- 10
order.book <- ReturnOrderBook(poloniex.public,
                              pair  = pair,
                              depth = depth)

order.book$BTC_ETH$bid
```

    ##           bid      amount
    ## 1  0.09794047  3.35759384
    ## 2  0.09790000 18.31825087
    ## 3  0.09789926           3
    ## 4  0.09787924         3.1
    ## 5  0.09786737         2.8
    ## 6  0.09785898        3.12
    ## 7  0.09783369         2.7
    ## 8  0.09782101      29.658
    ## 9  0.09782100     14.1428
    ## 10 0.09782048  2.38399325

``` r
order.book$BTC_ETH$ask
```

    ##           ask     amount
    ## 1  0.09801698  2.5576468
    ## 2  0.09801699 3.38163078
    ## 3  0.09801700 6.40172133
    ## 4  0.09801945          3
    ## 5  0.09804320       2.76
    ## 6  0.09804998 0.00472952
    ## 7  0.09805000 1.13076317
    ## 8  0.09806243     28.346
    ## 9  0.09806244        2.8
    ## 10 0.09808107       2.77

``` r
order.book$BTC_ETH$frozen
```

    ## [1] FALSE

``` r
order.book$BTC_ETH$seq
```

    ## [1] 368925769

#### ReturnTradeHistory

Run `?ReturnTradeHistory` for additional function documentation.

``` r
Sys.setenv(tz="UTC")
pair   <- "BTC_ETH"
from   <- as.POSIXct("2017-07-01 00:00:00 UTC")
to     <- as.POSIXct("2017-07-04 00:00:00 UTC")

trades.data <- ReturnTradeHistory(theObject = poloniex.public,
                                  pair      = pair,
                                  from      = from,
                                  to        = to)

tail(trades.data)
```

    ##                     globalTradeID tradeID    type  rate        
    ## 2017-07-03 23:59:41 "183463123"   "29391027" "buy" "0.10833668"
    ## 2017-07-03 23:59:44 "183463138"   "29391033" "buy" "0.10857999"
    ## 2017-07-03 23:59:46 "183463154"   "29391034" "buy" "0.10863293"
    ## 2017-07-03 23:59:55 "183463170"   "29391037" "buy" "0.10865144"
    ## 2017-07-03 23:59:55 "183463169"   "29391036" "buy" "0.10863293"
    ## 2017-07-03 23:59:55 "183463168"   "29391035" "buy" "0.10846100"
    ##                     amount        total       
    ## 2017-07-03 23:59:41 "0.99125595"  "0.10738937"
    ## 2017-07-03 23:59:44 "0.22670282"  "0.02461538"
    ## 2017-07-03 23:59:46 "14.87694700" "1.61612634"
    ## 2017-07-03 23:59:55 "4.59690907"  "0.49946079"
    ## 2017-07-03 23:59:55 "2.19075626"  "0.23798827"
    ## 2017-07-03 23:59:55 "0.92199039"  "0.09999999"

#### ReturnChartData

Run `?ReturnChartData` for additional function documentation.

``` r
Sys.setenv(tz="UTC")
pair    <- "BTC_ETH"
from    <- as.POSIXct("2015-01-01 00:00:00 UTC")
to      <- as.POSIXct("2018-04-09 00:00:00 UTC")
period  <- "4H"

chart.data <- ReturnChartData(theObject = poloniex.public,
                              pair      = pair,
                              from      = from,
                              to        = to,
                              period    = period)

tail(chart.data)
```

    ##                           high        low       open      close    volume
    ## 2017-07-07 20:00:00 0.09861897 0.09560000 0.09794200 0.09637649 2904.1812
    ## 2017-07-08 00:00:00 0.09700501 0.09314993 0.09633197 0.09606020 6122.1190
    ## 2017-07-08 04:00:00 0.09828000 0.09569548 0.09606020 0.09670868 2002.6569
    ## 2017-07-08 08:00:00 0.09737591 0.09387972 0.09670867 0.09484001 3395.7858
    ## 2017-07-08 12:00:00 0.09828000 0.09468260 0.09484000 0.09793757 3256.3735
    ## 2017-07-08 16:00:00 0.09830000 0.09755742 0.09793757 0.09801700  276.2542
    ##                     quotevolume weightedaverage
    ## 2017-07-07 20:00:00   30012.900      0.09676443
    ## 2017-07-08 00:00:00   64453.257      0.09498540
    ## 2017-07-08 04:00:00   20653.349      0.09696523
    ## 2017-07-08 08:00:00   35667.894      0.09520567
    ## 2017-07-08 12:00:00   33710.114      0.09659930
    ## 2017-07-08 16:00:00    2818.442      0.09801664

``` r
# install.packages("quantmod")
library(quantmod)
chart.plot <- chart_Series(chart.data[, "close"],
                           type   = "line",
                           name   = "BTC_ETH",
                           subset = "201705/201708")
chart.plot <- add_MACD()
chart.plot <- add_BBands()
chart.plot <- add_RSI()
chart.plot
```

![](README_files/figure-markdown_github/unnamed-chunk-6-1.png)

#### ReturnCurrencies

Run `?ReturnCurrencies` for function additional function documentation.

``` r
currencies <- ReturnCurrencies(poloniex.public)
head(currencies)
```

    ##      id           name      txFee minConf disabled delisted frozen
    ## 1CR   1        1CRedit 0.01000000       3        0        1      0
    ## ABY   2        ArtByte 0.01000000       8        0        1      0
    ## AC    3       AsiaCoin 0.01000000      15        0        1      0
    ## ACH   4 Altcoin Herald 0.00000000       5        0        1      0
    ## ADN   5          Aiden 0.01000000      24        0        1      0
    ## AEON  6      AEON Coin 0.01000000      10        0        1      0

#### ReturnLoanOrders

Run `?ReturnLoanOrders` for additional function documentation.

``` r
currency        <- "BTC"
loan.orders     <- ReturnLoanOrders(poloniex.public,
                                    currency = currency)
head(loan.orders$offers)
```

    ##         rate     amount min.days max.days
    ## 1 0.00087700 0.01000000        2        2
    ## 2 0.00089100 0.00004531        2        2
    ## 3 0.00089500 0.01000000        2        2
    ## 4 0.00091400 0.01000000        2        2
    ## 5 0.00092700 0.01098169        2        2
    ## 6 0.00093300 0.01000000        2        2

``` r
head(loan.orders$demands)
```

    ##         rate     amount min.days max.days
    ## 1 0.02000000 0.00006500        2        2
    ## 2 0.00060000 0.06405245        2        2
    ## 3 0.00050000 0.14400000        2        2
    ## 4 0.00030000 0.04835525        2        2
    ## 5 0.00020000 0.08027924        2        2

#### GET / SET public API URL and command Strings.

Note: Changing these settings is only useful if Poloniex makes changes to the base URL and/or command strings in the future. If nothing changes, object construction can remain default.

``` r
library(PoloniexR)

poloniex.public <- PoloniexPublicAPI() # Default constructor
GetPoloniexPublicURL(poloniex.public)
```

    ## [1] "https://poloniex.com/public?"

``` r
poloniex.public <- PoloniexPublicAPI(base.url                     = "https://not_working/public?")
poloniex.public <- SetPoloniexPublicURL(poloniex.public, base.url = "https://poloniex.com/public?")
GetPoloniexPublicURL(poloniex.public)
```

    ## [1] "https://poloniex.com/public?"

``` r
GetPoloniexPublicCommands(poloniex.public)
```

    ## $returnTicker
    ## [1] "returnTicker"
    ## 
    ## $return24hVolume
    ## [1] "return24hVolume"
    ## 
    ## $returnOrderBook
    ## [1] "returnOrderBook"
    ## 
    ## $returnTradeHistory
    ## [1] "returnTradeHistory"
    ## 
    ## $returnChartData
    ## [1] "returnChartData"
    ## 
    ## $returnCurrencies
    ## [1] "returnCurrencies"
    ## 
    ## $returnLoanOrders
    ## [1] "returnLoanOrders"

``` r
commands.new <- list(returnTicker    = "returnTicker.new",
                     return24hVolume = "return24hVolume.new")

# missing commands are kept default
poloniex.public <- SetPoloniexPublicCommands(poloniex.public,
                                             commands = commands.new)
```

    ## Warning in SetPoloniexPublicCommands(poloniex.public, commands =
    ## commands.new): Not all commands were set in the API command list input
    ## arguments: Setting missing commands to their respective default values.

``` r
GetPoloniexPublicCommands(poloniex.public)
```

    ## $returnTicker
    ## [1] "returnTicker.new"
    ## 
    ## $return24hVolume
    ## [1] "return24hVolume.new"
    ## 
    ## $returnOrderBook
    ## [1] "returnOrderBook"
    ## 
    ## $returnTradeHistory
    ## [1] "returnTradeHistory"
    ## 
    ## $returnChartData
    ## [1] "returnChartData"
    ## 
    ## $returnCurrencies
    ## [1] "returnCurrencies"
    ## 
    ## $returnLoanOrders
    ## [1] "returnLoanOrders"

### TRADING API - EXAMPLES

Trading should be enabled in your Poloniex settings and you should have access to your account key / secret in order to construct the `PoloniexTradingAPI` object. Internally, all calls to the trading API are sent via HTTP POST. The POST data itself is signed with your key's secret according to the HMAC-SHA512 method.

#### ReturnBalances

Wrapper on top of `ProcessTradingRequest` to fetch account balance info. Run `?ReturnBalances` for additional info.

``` r
key    = your.key
secret = your.secret
poloniex.trading <- PoloniexTradingAPI(key    = key,
                                       secret = secret)
balances <- ReturnBalances(poloniex.trading)
head(balances)
```

#### ReturnCompleteBalances

Wrapper on top of `ProcessTradingRequests` to fetch complete (margin, lending, ..) account balance info. Run `?ReturnCompleteBalances` for additional info.

``` r
balances <- ReturnCompleteBalances(poloniex.trading)
head(balances)

balances <- ReturnCompleteBalances(poloniex.trading, all.balances=TRUE)
head(balances)
```

#### ProcessTradingRequest

This function allows the users to call any of the trading functions that are accessible through the Poloniex Trading API. The `ProcessTradingRequest` method takes a command string as input argument in combination with a list of additional input arguments that correspond to the particular command in question. Largely untested, but should work just fine.. (todo: test!).

Some examples:

``` r
##########################
# returnDepositAddresses #
##########################
?ProcessTradingRequest
deposit.addresses <- ProcessTradingRequest(poloniex.trading,
                                           command = poloniex.trading@commands$returnDepositAddresses)

#########################
# generateNewAddress ####
#########################
new.address <- ProcessTradingRequest(poloniex.trading,
                                     command = poloniex.trading@commands$generateNewAddress,
                                     args    = list(currency = "BTC"))


##############################
# returnDepositsWithdrawals ##
##############################
account.activity <- ProcessTradingRequest(poloniex.trading,
                                          command = poloniex.trading@commands$returnDepositWithdrawals,
                                          args = list(start = as.numeric(as.POSIXct("2017-01-01 00:00:00 UTC"))),
                                                      end   = as.numeric(as.POSIXct("2018-01-01 00:00:00 UTC")))

##############################
### returnOpenOrders #########
##############################
open.orders <- ProcessTradingRequest(poloniex.trading,
                                     command = poloniex.trading@commands$returnOpenOrders,
                                     args    = list(currencyPair = "BTC_ETH"))

open.orders.all <- ProcessTradingRequest(poloniex.trading,
                                         command = poloniex.trading@commands$returnOpenOrders,
                                         args    = list(currencyPair = "all"))


##############################
### Return Trade History #####
##############################
trade.history <-  ProcessTradingRequest(poloniex.trading,
                                        command = poloniex.trading@commands$returnTradeHistory,
                                        args = list(currencyPair = "BTC_ETH",
                                                    start        = as.numeric(as.POSIXct("2017-01-01 00:00:00 UTC"))),
                                                    end          = as.numeric(as.POSIXct("2018-01-01 00:00:00 UTC")))

# no range specified: limit to one day
trade.history.all <-  ProcessTradingRequest(poloniex.trading,
                                            command = poloniex.trading@commands$returnTradeHistory,
                                            args    = list(currencyPair = "all"))


##############################
### ReturnOrderTrades ########
##############################
order.trades <- ProcessTradingRequest(poloniex.trading,
                                      command = poloniex.trading@commands$returnOrderTrades,
                                      args    = list(orderNumber = 1))

##############################
######### Buy ################
##############################
buy.order <- ProcessTradingRequest(poloniex.trading,
                                   command = poloniex.trading@commands$buy,
                                   args    = list(currencyPair      = "BTC_ETH",
                                                  rate              = 0.01,
                                                  amount            = 1,
                                                  immediateOrCancel = 1)) # fillOrKill, postOnly

##############################
######### Sell ###############
##############################
sell.order <- ProcessTradingRequest(poloniex.trading,
                                    command = poloniex.trading@commands$sell,
                                    args    = list(currencyPair      = "BTC_ETH",
                                                   rate              = 0.01,
                                                   amount            = 1))


##############################
######### cancelOrder ########
##############################
cancel.order <- ProcessTradingRequest(poloniex.trading,
                                      command = poloniex.trading@commands$cancelOrder,
                                      args    = list(orderNumber = 1))

##############################
######### moveOrder ##########
##############################
move.order <- ProcessTradingRequest(poloniex.trading,
                                    command = poloniex.trading@commands$moveOrder,
                                    args    = list(orderNumber       = 1,
                                                   rate              = 0.1,
                                                   amount            = 1,
                                                   immediateOrCancel = 1)) # postOnly
```

Other Trade functionality (View Poloniex API documentation):

-   withdraw: `poloniex.trading@commands$withdraw`
-   returnFeeInfo: `poloniex.trading@commands$returnFeeInfo`
-   returnAvailableAccountBalances: `poloniex.trading@commands$returnAvailableAccountBalances`
-   returnTradeableBalances: `poloniex.trading@commands$returnTradeableBalances`
-   transferBalance: `poloniex.trading@commands$transferBalance`
-   returnMarginAccountSummary: `poloniex.trading@commands$returnMarginAccountSummary`
-   marginBuy: `poloniex.trading@commands$marginBuy`
-   marginSell: `poloniex.trading@commands$marginSell`
-   getmarginPosition: `poloniex.trading@getMarginPosition`
-   closeMarginPosition: `poloniex.trading@closeMarginPosition`
-   createLoanOffer: `poloniex.trading@commands$createLoanOffer`
-   cancelLoanOffer: `poloniex.trading@commands$cancelLoanOffer`
-   returnOpenLoanOffers: `poloniex.trading@commands$returnOpenLoanOffers`
-   returnActiveLoans: `poloniex.trading@commands$returnActiveLoans`
-   returnLendingHistory: `poloniex.trading@commands$returnLendingHistory`
-   toggleAutoRenew: `poloniex.trading@commands$toggleAutoRenew`

#### GETTERS / SETTERS

Same remark as before: Modification of the object fields are only required if and when Poloniex modifies the trading API base URL and/or the command strings. Default constructor can be used for now.

``` r
###########################################################
#################### GETTERs / SETTERS ####################
###########################################################

##################
# Get Trading URL#
##################
GetPoloniexTradingURL(poloniex.trading)

##################
# Set Trading URL#
##################
?SetPoloniexTradingURL
poloniex.trading <- PoloniexTradingAPI(trading.base.url = "https://not_working/tradingApi?",
                                       key              = your.key,
                                       secret           = your.secret)

poloniex.trading <- SetPoloniexTradingURL(poloniex.trading,
                                          trading.base.url = "https://poloniex.com/tradingApi?")
GetPoloniexTradingURL(poloniex.trading)

#######################
# Get Trading commands#
#######################
?GetPoloniexTradingCommands
GetPoloniexTradingCommands(poloniex.trading)

#######################
# Set Trading Commands#
#######################
?SetPoloniexTradingCommands
commands.new <- list(returnTradeHistory = "returnTradeHistory.new",
                     withdraw = "withdraw.new")
poloniex.trading <- SetPoloniexTradingCommands(poloniex.trading,
                                               commands = commands.new)

GetPoloniexTradingCommands(poloniex.trading)
commands.new <- list(returnTicker    = "returnTicker.new",
                     return24hVolume = "return24hVolume.new")
poloniex.trading <- SetPoloniexTradingCommands(poloniex.trading,
                                               commands = commands.new)
GetPoloniexPublicCommands(poloniex.public)
```

Donations
---------

If you find this software useful and/or you would like to see additional extensions or a future release to CRAN, feel free to donate some crypto:

Crypto Addresses:

-   BTC: 1QHtZLZ15Cmj4FPr5h5exDjYciBDhh7mzA
-   LTC: LhKf6MQ7LY1k8YMaAq9z3APz8kVyFX3L2M
-   ETH: 0x8E44D7C96896f2e0Cd5a6CC1A2e6a3716B85B479
-   DASH: Xvicgp3ga3sczHtLqt3ekt7fQ62G9KaKNB

Or preferably, donate some of my favorite coins :)

-   GAME: GMxcsDAaHCBkLnN42Fs9Dy1fpDiLNxSKX1
-   WAVES: 3PQ8KFdw2nWxQATsXQj8NJvSa1VhBcKePaf

Licensing
---------

Copyright 2017 Essential Data Science Consulting ltd. ([EssentialQuant.com](http://essentialquant.com "EssentialQuant") / <jellenvermeir@essentialquant.com>). This software is copyrighted under the MIT license: View added [LICENSE](./LICENSE) file.
