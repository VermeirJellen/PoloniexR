##########################################################
##########################################################
################### POLONIEX PUBLIC API ##################
##########################################################
##########################################################

#' An S4 class representing the Poloniex Public API
#'
#' @slot base.url A length-one numeric vector.
#' Represents the poloniex public API service base url.
#' @slot commands A list containing Key/Value string pairs.
#' Represents the command strings of the associated public API functions.
#' @export PoloniexPublicAPI
PoloniexPublicAPI <- setClass(
  # Set the name for the public API class
  "PoloniexPublicAPI",
  slots = c(base.url = "character",
            commands = "list"),

  # Set the default value for the slots
  prototype=list(base.url = "https://poloniex.com/public?",
                 commands = public.commands.default),

  validity=function(object){
    if (!(is(object@base.url, "character"))){
      return("base.url must be a length-one numeric vector.")
    }
    if(!is(object@commands, "list")){
      return("commands input argument must be a list containing Key/Value string pairs.")
    }

    rest.grep <- "https?://.*\\?$"
    if (!grepl(rest.grep, object@base.url)){
      return(paste("NOK - base.url must be of the following form:", rest.grep))
    }

    commands.required.names <- names(public.commands.default)
    commands.input.names <- names(object@commands)
    missing.mask <- vapply(commands.required.names,
                           function(x) ifelse(!x %in% commands.input.names, TRUE, FALSE),
                           logical(1))
    if(sum(missing.mask) > 0){
      return(paste("NOK - commands list has missing key values.",
                   "Following key values are missing:",
                   paste(commands.required.names[missing.mask], collapse=', ')))
    }

    return(TRUE)
  }
)


##############################################################
################### GETTERS / SETTERS base.url ###############
##############################################################

#' Returns REST service URL for the Poloniex Public API
#'
#' @param theObject The object on which the function should be called
#' @return base.url - a length-one character vector.
#'  Represents the Poloniex public API service base url.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setGeneric(name="GetPoloniexPublicURL",
           def=function(theObject){
             standardGeneric("GetPoloniexPublicURL")
           })

#' Returns REST service URL for the Poloniex Public API
#'
#' @param theObject The object on which the function should be called
#' @return base.url - a length-one character vector.
#'  Represents the Poloniex public API service base url.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setMethod(f="GetPoloniexPublicURL",
          signature="PoloniexPublicAPI", definition=function(theObject){
            return(theObject@base.url)
          })


#' Setter for REST service URL for the Poloniex public API
#'
#' @param theObject The public client API object on which the function should be called
#' @param base.url length-one character vector. Represents the REST service URL.
#' @return theObject - a copy of the object with the modified base.url slot
#' @examples
#' poloniex.public <- PoloniexPublicAPI(base.url = "https://not_working/public?")
#' poloniex.public <- SetPoloniexPublicURL(poloniex.public, 
#'                                         base.url = "https://poloniex.com/public?")
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setGeneric(name="SetPoloniexPublicURL",
           def=function(theObject, base.url){
             standardGeneric("SetPoloniexPublicURL")
           })

#' Setter for REST service URL for the Poloniex public API
#'
#' @param theObject The public client API object on which the function should be called
#' @param base.url length-one character vector. Represents the REST service URL.
#' @return theObject - a copy of the object with the modified base.url slot
#' @examples
#' poloniex.public <- PoloniexPublicAPI(base.url = "https://not_working/public?")
#' poloniex.public <- SetPoloniexPublicURL(poloniex.public, 
#'                                         base.url = "https://poloniex.com/public?")
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setMethod(f="SetPoloniexPublicURL",
          signature="PoloniexPublicAPI", definition=function(theObject, base.url){
            theObject@base.url <- base.url
            validObject(theObject)
            return(theObject)
          })


##############################################################
################### GETTERS / SETTERS commands ###############
##############################################################

#' Returns REST service commands for the Poloniex Public API
#'
#' @param theObject The public client API object on which the function should be called
#' @return commands - a list with Key/value string pairs
#'  Represents the command strings for the respective public API functions.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicCommands(poloniex.public)
#' @export
setGeneric(name="GetPoloniexPublicCommands",
           def=function(theObject){
             standardGeneric("GetPoloniexPublicCommands")
           })

#' Returns REST service commands for the Poloniex Public API
#'
#' @param theObject The public client API object on which the function should be called
#' @return commands - a list with Key/value string pairs
#'  Represents the command strings for the respective public API functions.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicCommands(poloniex.public)
#' @export
setMethod(f="GetPoloniexPublicCommands",
          signature="PoloniexPublicAPI", definition=function(theObject){
            return(theObject@commands)
          })

#' Setter for REST service commands for the Poloniex public API.
#'
#' @param theObject The public client API object on which the function should be called
#' @param commands -  a list with Key/value string pairs
#'  Represents the command strings for the respective public API functions.
#' @return theObject - a copy of the object with the modified command slot
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicCommands(poloniex.public)
#' commands.new <- list(returnTicker = "returnTicker.new",
#'                     return24hVolume = "return24hVolume.new")
#' poloniex.public <- SetPoloniexPublicCommands(poloniex.public,
#'                                              commands = commands.new)
#' GetPoloniexPublicCommands(poloniex.public)
#' @export
setGeneric(name="SetPoloniexPublicCommands",
           def=function(theObject, commands){
             standardGeneric("SetPoloniexPublicCommands")
           })

#' Setter for REST service commands for the Poloniex public API.
#'
#' @param theObject The public client API object on which the function should be called
#' @param commands -  a list with Key/value string pairs
#'  Represents the command strings for the respective public API functions.
#' @return theObject - a copy of the object with the modified command slot
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicCommands(poloniex.public)
#' commands.new <- list(returnTicker = "returnTicker.new",
#'                     return24hVolume = "return24hVolume.new")
#' poloniex.public <- SetPoloniexPublicCommands(poloniex.public,
#'                                              commands = commands.new)
#' GetPoloniexPublicCommands(poloniex.public)
#' @export
setMethod(f="SetPoloniexPublicCommands",
          signature="PoloniexPublicAPI", definition=function(theObject, commands){
            theObject@commands <- commands

            # Set missing commands to default (for convenience reasons)
            commands.input.names <- names(commands)
            commands.required.names <- names(public.commands.default)
            missing.mask <- vapply(commands.required.names,
                                   function(x) ifelse(!x %in% commands.input.names, TRUE, FALSE),
                                   logical(1))
            if(sum(missing.mask) > 0){
              warning(paste("Not all commands were set in the API command list input arguments:",
                            "Setting missing commands to their respective default values."))
              for(missing.name in commands.required.names[missing.mask]){
                theObject@commands[[missing.name]] <- public.commands.default[[missing.name]]
              }
            }

            validObject(theObject)
            return(theObject)
          })


#############################################################
########################## API FUNCTIONS ####################
#############################################################

################################################
########### .ProcessRequest (private) ##########
################################################
.ProcessRequest <- function(request.str){
  response  <- httr::GET(request.str)
  resp.code <- httr::status_code(response)
  if (resp.code == "200"){
    resp.content <- httr::content(response)
    resp.err     <- resp.content$error
    if (is.null(resp.err)){
      return (httr::content(response))
    }
    else{
      stop (paste("Poloniex returned \"",
                  resp.err, "\" response error while processing ",
                  request.str, sep=""))
    }
  }
  else{
    stop (paste("Unable to connect to ",
                request.str, " (", resp.code, ")", sep=""))
  }
}


################################################
############### ReturnTicker ###################
################################################

#' Returns the ticker for all markets
#'
#' @param theObject The public client API object on which the function should be called
#' @return A dataframe containing ticker information
#'  Rows    - Cryptocurrency Pairs
#'  Columns - id, last, lowestAsk, highestBid, percentChange
#'   baseVolume, quoteVolume, isFrozen, high24hr, low24hr
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setGeneric(name="ReturnTicker",
           def=function(theObject){
             standardGeneric("ReturnTicker")
           })

#' Returns the ticker for all markets
#'
#' @param theObject The public client API object on which the function should be called
#' @return A dataframe containing ticker information
#'  Rows    - Cryptocurrency Pairs
#'  Columns - id, last, lowestAsk, highestBid, percentChange
#'   baseVolume, quoteVolume, isFrozen, high24hr, low24hr
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' GetPoloniexPublicURL(poloniex.public)
#' @export
setMethod(f="ReturnTicker",
          signature="PoloniexPublicAPI", definition=function(theObject){

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnTicker.command <- theObject@commands$returnTicker
            request.str <- paste(theObject@base.url,
                                 paste("command", returnTicker.command, sep="="),
                                 sep="")

            # Poloniex API Call
            tickers.info  <- .ProcessRequest(request.str)
            tickers.df    <- as.data.frame(matrix(unlist(tickers.info),
                                                 nrow=length(tickers.info),
                                                 byrow=TRUE))
            rownames(tickers.df) <- names(tickers.info)
            colnames(tickers.df) <- names(tickers.info[[1]])

            return(tickers.df)
          })


################################################
############### RETURN24HVOLUME ################
################################################

#' Returns 24-hour trading volumes for all available markets.
#' Additionally, total trading volumes for the 5 primary currencies
#' are also retrieved.
#'
#' @param theObject The public client API object on which the function should be called
#' @return A list containing the 24 hour volume information.
#'  volume.pairs: A dataframe
#'   Rows    - Cryptocurrency Trading Pairs.
#'             Every pair represents a market.
#'   Columns - Transacted trading volumes for a particular market.
#'             Volumes are expressed in both base currency units and quoted
#'             currency units.
#'  volume.totals: Total trading volumes of five primary currencies.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' volume.info <- Return24hVolume(poloniex.public)
#' head(volume.info$volume.pairs)
#' volume.info$volume.totals
#' @export
setGeneric(name="Return24hVolume",
           def=function(theObject){
             standardGeneric("Return24hVolume")
           })

#' Returns 24-hour trading volumes for all available markets.
#' Additionally, total trading volumes for the 5 primary currencies
#' are also retrieved.
#'
#' @param theObject The public client API object on which the function should be called
#' @return A list containing the 24 hour volume information.
#'  volume.pairs: A dataframe
#'   Rows    - Cryptocurrency Trading Pairs.
#'             Every pair represents a market.
#'   Columns - Transacted trading volumes for a particular market.
#'             Volumes are expressed in both base currency units and quoted
#'             currency units.
#'  volume.totals: Total trading volumes of five primary currencies.
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' volume.info <- Return24hVolume(poloniex.public)
#' head(volume.info$volume.pairs)
#' volume.info$volume.totals
#' @export
setMethod(f="Return24hVolume",
          signature="PoloniexPublicAPI", definition=function(theObject){

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            return24hVolume.command <- theObject@commands$return24hVolume
            request.str <- paste(theObject@base.url,
                                 paste("command", return24hVolume.command, sep="="),
                                 sep="")

            # Poloniex API Call
            volume.info <- .ProcessRequest(request.str)

            volumes.totals    <- Filter(function(x) is(x, "character"), volume.info)
            volumes.totals.df <- as.data.frame(x = matrix(unlist(volumes.totals), nrow=1))

            rownames(volumes.totals.df) <- "volume"
            colnames(volumes.totals.df) <- gsub("total", "", names(volumes.totals))

            volumes.pairs    <- Filter(function(x) is(x, "list"), volume.info)
            volumes.pairs.df <- as.data.frame(do.call("rbind",
                                                      lapply(volumes.pairs, as.numeric)))
            colnames(volumes.pairs.df) <- c("pair1", "pair2")

            return( list(volume.pairs   = volumes.pairs.df,
                          volume.totals = volumes.totals.df) )
          })


################################################
############### ReturnOrderBook ################
################################################

#' Returns the order book for a given market,
#' as well as a sequence number for use with the Push API
#' and an indicator specifying whether the market is frozen.
#'
#' @param theObject The public client API object on which the function should be called.
#' @param pair length one-character vector - The currencypair
#'  for which orderbook information should be fetched.
#'  You may set pair to "all" to fetch the order books of all markets.
#' @param depth numeric - depth of the orderbook.
#' @return A list containing orderbook information.
#'
#'  if pair == "all": a list containing orderbook
#'   information for all available markets.
#'   Each list entry contains information for one
#'   specific market.
#'  if !pair == "all": a list containing orderbook
#'   information for the requested markets.
#'
#'  Each market list contains following fields:
#'   - ask: Orderbook sell side, Dataframe containing
#'          ask prices and corresponding amounts.
#'   - bid: Orderbook buy side. Dataframe containing
#'          bid prices and corresponding amounts.
#'   - frozen: indicator specifying wheather market
#'             is frozen or not.
#'   - seq: Sequence number for Push API.
#'
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#'
#' pair <- "BTC_NXT"
#' depth <- 100
#' order.book <- ReturnOrderBook(poloniex.public,
#'                               pair  = pair,
#'                               depth = 10)
#' order.book$bid
#' order.book$ask
#' order.book$frozen
#' order.book$seq
#'
#' pair <- "all"
#' depth <- 10
#' order.book <- ReturnOrderBook(poloniex.public,
#'                               pair  = pair,
#'                               depth = 10)
#'
#' names(order.book)
#' order.book$BTC_ETH$ask
#' @export
setGeneric(name="ReturnOrderBook",
           def=function(theObject, pair = "all", depth = 10){
             standardGeneric("ReturnOrderBook")
           })

#' Returns the order book for a given market,
#' as well as a sequence number for use with the Push API
#' and an indicator specifying whether the market is frozen.
#'
#' @param theObject The public client API object on which the function should be called.
#' @param pair length one-character vector - The currencypair
#'  for which orderbook information should be fetched.
#'  You may set pair to "all" to fetch the order books of all markets.
#' @param depth numeric - depth of the orderbook.
#' @return A list containing orderbook information.
#'
#'  if pair == "all": a list containing orderbook
#'   information for all available markets.
#'   Each list entry contains information for one
#'   specific market.
#'  if !pair == "all": a list containing orderbook
#'   information for the requested markets.
#'
#'  Each market list contains following fields:
#'   - ask: Orderbook sell side, Dataframe containing
#'          ask prices and corresponding amounts.
#'   - bid: Orderbook buy side. Dataframe containing
#'          bid prices and corresponding amounts.
#'   - frozen: indicator specifying wheather market
#'             is frozen or not.
#'   - seq: Sequence number for Push API.
#'
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#'
#' pair <- "BTC_NXT"
#' depth <- 100
#' order.book <- ReturnOrderBook(poloniex.public,
#'                               pair  = pair,
#'                               depth = 10)
#' order.book$bid
#' order.book$ask
#' order.book$frozen
#' order.book$seq
#'
#' pair <- "all"
#' depth <- 10
#' order.book <- ReturnOrderBook(poloniex.public,
#'                               pair  = pair,
#'                               depth = 10)
#'
#' names(order.book)
#' order.book$BTC_ETH$ask
#' @export
setMethod(f="ReturnOrderBook",
          signature="PoloniexPublicAPI",
          definition=function(theObject,
                              pair  = "all",
                              depth = 10){

            ########################
            ## INPUT VERIFICATION ##
            ########################
            stopifnot(inherits(pair,  "character"))
            stopifnot(inherits(depth, "numeric") & depth > 0)

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnOrderBook.command <- theObject@commands$returnOrderBook
            request.str <- paste(theObject@base.url,
                                 paste(
                                   paste("command", returnOrderBook.command, sep="="),
                                   paste("currencyPair", pair, sep="="),
                                   paste("depth", depth, sep="="),
                                   sep="&"),
                                 sep="")

            # Poloniex API Call
            orderbook <- .ProcessRequest(request.str)

            ExtractInfo <- function (pair.book){
              bid           <- as.data.frame(matrix(unlist(pair.book$bids), ncol=2, byrow = TRUE))
              colnames(bid) <- c("bid", "amount")
              ask           <- as.data.frame(matrix(unlist(pair.book$asks), ncol=2, byrow = TRUE))
              colnames(ask) <- c("ask", "amount")

              return (list(bid    = bid,
                           ask    = ask,
                           frozen = as.logical(as.numeric(pair.book$isFrozen)),
                           seq    = pair.book$seq))
            }

            if (pair == "all"){
              return (lapply(orderbook, ExtractInfo))
            }
            else{
              return (ExtractInfo(orderbook))
            }
          })

################################################
############### ReturnTradeHistory #############
################################################

#' Returns the past 200 trades for a given market, or up to
#' 50,000 trades inside a specified input date range interval.
#'
#' @param theObject The public client API object on which the function should be called.
#' @param pair length-one character vector - The currencypair
#' for which trade history information should be fetched.
#' @param from POSIXct (or NULL) - starting timestamp
#'  for optional date range interval.
#'    if from != NULL: from must be < 'to' &
#'    from must be >= (to - 1 year)
#' @param to POSIXct (or NULL) - ending timestamp for optional
#'  date range interval.
#' @return an xts object containing historical trade information
#'
#'  Rows    - Information for one specific trade.
#'  Columns - globalTradeID, tradeID, type, rate, amount, total
#'
#'    if from == NULL:
#'      Receive information for last 200 trades before 'to'
#'    if to == NULL:
#'      Ending timestamp for daterange will be set to Sys.time()
#'
#' @examples
#' Sys.setenv(tz = "UTC")
#' poloniex.public <- PoloniexPublicAPI()
#' pair   <- "BTC_NXT"
#' from   <- as.POSIXct("2017-01-01 00:00:00 UTC")
#' to     <- as.POSIXct("2017-12-30 00:00:00 UTC")
#'
#' trades.data <- ReturnTradeHistory(theObject = poloniex.public,
#'                                   pair      = pair,
#'                                   from      = from,
#'                                   to        = to)
#'
#' @export
setGeneric(name="ReturnTradeHistory",
           def=function(theObject,
                        pair = "USDT_BTC",
                        from = NULL,
                        to   = NULL){
             standardGeneric("ReturnTradeHistory")
           })

#' Returns the past 200 trades for a given market, or up to
#' 50,000 trades inside a specified input date range interval.
#'
#' @param theObject The public client API object on which the function should be called.
#' @param pair length-one character vector - The currencypair
#' for which trade history information should be fetched.
#' @param from POSIXct (or NULL) - starting timestamp
#'  for optional date range interval.
#'    if from != NULL: from must be < 'to' &
#'    from must be >= (to - 1 year)
#' @param to POSIXct (or NULL) - ending timestamp for optional
#'  date range interval.
#' @return an xts object containing historical trade information
#'
#'  Rows    - Information for one specific trade.
#'  Columns - globalTradeID, tradeID, type, rate, amount, total
#'
#'    if from == NULL:
#'      Receive information for last 200 trades before 'to'
#'    if to == NULL:
#'      Ending timestamp for daterange will be set to Sys.time()
#'
#' @examples
#' Sys.setenv(tz = "UTC")
#' poloniex.public <- PoloniexPublicAPI()
#' pair   <- "BTC_NXT"
#' from   <- as.POSIXct("2017-07-04 00:00:00 UTC")
#' to     <- as.POSIXct("2017-07-05 00:00:00 UTC")
#'
#' trades.data <- ReturnTradeHistory(theObject = poloniex.public,
#'                                   pair      = pair,
#'                                   from      = from,
#'                                   to        = to)
#'
#' @export
setMethod(f="ReturnTradeHistory",
          signature="PoloniexPublicAPI",
          definition=function(theObject,
                              pair = "USDT_BTC",
                              from = NULL,
                              to   = NULL){

            ########################
            ## INPUT VERIFICATION ##
            ########################
            stopifnot(inherits(pair, "character"))
            stopifnot(is.null(from) | inherits(from, "POSIXct"))
            stopifnot(is.null(to) | inherits(to, "POSIXct"))

            if (!is.null(from)){
              if (is.null(to)){
                to <- Sys.time()
              }
              if(difftime(to, from) <= 0){
                stop (paste("The 'to' POSIXct input argument must greater later than",
                            "the 'from' POSIXct input argument"))
              }
              if(difftime(to, from) > 364){
                stop (paste("The 'from' and 'to' POSIXct input arguments",
                            "must lie less than 365 days apart", sep=" "))
              }
            }

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnTradeHistory.command <- theObject@commands$returnTradeHistory
            request.str <- paste(paste(theObject@base.url,
                                       paste("command",
                                             returnTradeHistory.command, sep="="), sep=""),
                                 paste("currencyPair", pair, sep="="), sep="&")
            if(!is.null(from)){
              request.str <- paste(request.str,
                                   paste("start", as.numeric(from), sep="="),
                                   sep = "&")
            }
            if(!is.null(to)){
              request.str <- paste(request.str,
                                   paste("end", as.numeric(to), sep="="),
                                   sep = "&")
            }

            # Poloniex API Call
            trades.history <- .ProcessRequest(request.str)

            if (length(trades.history) > 0){
              trades.mat    <- matrix(unlist(trades.history),
                                      byrow = TRUE,
                                      ncol  = length(trades.history[[1]]))
              trades.xts    <- xts::xts(trades.mat[,-3],
                                        order.by = anytime::anytime(as.POSIXct(trades.mat[, 3]),
                                                                    asUTC=TRUE))
              names(trades.xts) <- names(trades.history[[1]])[-3]

              return (trades.xts)
            }
            else{
              warning(paste("No trade data found between",
                             from, "and", to,
                            "for currency pair", pair, sep=" "))
              return (NULL)
            }
          })

################################################
############### ReturnChartData ################
################################################

#' Fetch OHLC and volume timeseries data for a specific market.
#' The caller must specify a date range interval
#' and datafrequency for the requested timeseries.
#'
#' @param theObject The object on which the function should be called.
#' @param pair a length-one character vector - The currencypair
#' for which timeseries information should be fetched.
#' @param from POSIXct - Starting timestamp for
#'  daterange interval.
#' @param to POSIXct - Ending timestamp for daterange interval.
#' @param period length-one character vector OR length-one
#'  numeric vector - datafrequency for requested timeseries.
#'   if is(period, "numeric"): 300 / 900 / 1800 / 7200 / 14400 / 86400
#'   if is(period, "character"): "5M", "15M", "30M", "2H", "4H", "D"
#' @return an xts timeseries object.
#'  rows    - ohcl and volume information for one timestamp.
#'  columns - high, low, open, close, volume, quotevolume,
#'   weightedaverage.
#' @examples
#' Sys.setenv(tz = "UTC")
#' poloniex.public <- PoloniexPublicAPI()
#' pair    <- "BTC_NXT"
#' from    <- as.POSIXct("2010-01-01 00:00:00 UTC")
#' to      <- as.POSIXct("2012-04-09 00:00:00 UTC")
#' period  <- "4H"
#'
#' chart.data <- ReturnChartData(theObject = poloniex.public,
#'                               pair      = pair,
#'                               from      = from,
#'                               to        = to,
#'                               period    = period)
#' @export
setGeneric(name="ReturnChartData",
           def=function(theObject,
                        pair   = "USDT_BTC",
                        from   = as.POSIXct("2014-01-01 00:00:00 UTC"),
                        to     = as.POSIXct("2018-01-01 00:00:00 UTC"),
                        period = "4H"){
             standardGeneric("ReturnChartData")
           })

#' Fetch OHLC and volume timeseries data for a specific market.
#' The caller must specify a date range interval
#' and datafrequency for the requested timeseries.
#'
#' @param theObject The object on which the function should be called.
#' @param pair a length-one character vector - The currencypair
#' for which timeseries information should be fetched.
#' @param from POSIXct - Starting timestamp for
#'  daterange interval.
#' @param to POSIXct - Ending timestamp for daterange interval.
#' @param period length-one character vector OR length-one
#'  numeric vector - datafrequency for requested timeseries.
#'   if is(period, "numeric"): 300 / 900 / 1800 / 7200 / 14400 / 86400
#'   if is(period, "character"): "5M", "15M", "30M", "2H", "4H", "D"
#' @return an xts timeseries object.
#'  rows    - ohcl and volume information for one timestamp.
#'  columns - high, low, open, close, volume, quotevolume,
#'   weightedaverage.
#' @examples
#' Sys.setenv(tz = "UTC")
#' poloniex.public <- PoloniexPublicAPI()
#' pair    <- "BTC_NXT"
#' from    <- as.POSIXct("2010-01-01 00:00:00 UTC")
#' to      <- as.POSIXct("2012-04-09 00:00:00 UTC")
#' period  <- "4H"
#'
#' chart.data <- ReturnChartData(theObject = poloniex.public,
#'                               pair      = pair,
#'                               from      = from,
#'                               to        = to,
#'                               period    = period)
#' @export
setMethod(f="ReturnChartData",
          signature="PoloniexPublicAPI",
          definition=function(theObject,
                              pair   = "USDT_BTC",
                              from   = as.POSIXct("2014-01-01 00:00:00 UTC"),
                              to     = as.POSIXct("2018-01-01 00:00:00 UTC"),
                              period = "4H"){

            ########################
            ## INPUT VERIFICATION ##
            ########################
            stopifnot(inherits(pair, "character"))
            stopifnot(inherits(from, "POSIXct"))
            stopifnot(inherits(to, "POSIXct"))
            stopifnot(inherits(period, "character") |
                      inherits(period, "numeric"))

            periods.num <- c(300, 900, 1800, 7200, 14400, 86400)
            if (inherits(period, "numeric") & !period %in% periods.num){
              stop (paste("Numeric period input argument must be one of the following values:",
                          paste(periods.num, collapse =", ")))
            }

            periods.str <- c("5M", "15M", "30M", "2H", "4H", "D")
            if (inherits(period, "character")){
              if (!period %in% periods.str){
                stop (paste("Character period input argument must be one of the following values:",
                            paste(periods.str, collapse =", ")))
              }
              else{
                if(period=="5M")
                  period = 300
                else if(period=="15M")
                  period = 900
                else if(period=="30M")
                  period= 1800
                else if(period=="2H")
                  period = 7200
                else if(period=="4H")
                  period = 14400
                else if(period=="D")
                  period = 86400
              }
            }

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnChartData.command <- theObject@commands$returnChartData
            request.str <- paste(paste(theObject@base.url,
                                       paste("command",
                                             returnChartData.command, sep="="), sep=""),
                                 paste("currencyPair", pair, sep="="),
                                 paste("start",        as.numeric(from), sep="="),
                                 paste("end",          as.numeric(to), sep="="),
                                 paste("period",       period, sep="="), sep="&")

            # Poloniex API Call
            chart.list <- .ProcessRequest(request.str)

            if (length(chart.list) > 1){
              chart.mat <- matrix(unlist(chart.list),
                                  byrow=TRUE,
                                  ncol=length(chart.list[[1]]))
              chart.xts <- xts::xts(chart.mat[,-1],
                                    order.by=anytime::anytime(chart.mat[,1],
                                                           asUTC=TRUE))
              names(chart.xts) <- c("high", "low", "open", "close",
                                    "volume", "quotevolume", "weightedaverage")
              return (chart.xts)
            }
            else {
              warning(paste("No timeseries data found between",
                            from, "and", to,
                            "for currency pair", pair, sep=" "))
              return (NULL)
            }
          })

################################################
############### ReturnCurrencies ###############
################################################

#' Returns information about currencies
#'
#' @param theObject The object on which the function should be called
#' @return A dataframe with currency information
#'  - rows: Information about a single currency
#'  - columns: id, txfee, minConf, disabled, delisted, frozen
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' currencies <- ReturnCurrencies(poloniex.public)
#' @export
setGeneric(name="ReturnCurrencies",
           def=function(theObject){
             standardGeneric("ReturnCurrencies")
           })

#' Returns information about currencies
#'
#' @param theObject The object on which the function should be called
#' @return A dataframe with currency information
#'  - rows: Information about a single currency
#'  - columns: id, txfee, minConf, disabled, delisted, frozen
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' currencies <- ReturnCurrencies(poloniex.public)
#' @export
setMethod(f="ReturnCurrencies",
          signature="PoloniexPublicAPI",
          definition=function(theObject){

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnCurrencies.command <- theObject@commands$returnCurrencies
            request.str <- paste(theObject@base.url,
                                 paste("command",
                                       returnCurrencies.command, sep="="), sep="")

            # Poloniex API Call
            currencies    <- .ProcessRequest(request.str)
            currencies.df <- as.data.frame(do.call("rbind", currencies))
            currencies.df <- currencies.df[, -5]

            return (currencies.df)
          })

################################################
############### ReturnLoanOrders ###############
################################################

#' Returns a list of loan offers and demands for a given currency.
#'
#' @param theObject The object on which the function should be called
#' @param currency - a length-one character vector
#'  Represents the currency for which loan information should be
#'  fetched.
#' @return A list containing two items. Each item is a dataframe
#'  containing the actual loan offers or demands information.
#'   eg list$offers / list$demands
#'    - rows: offers / demand "order book" entries.
#'    - columns: rate, amount, min.days, max.days
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' currency        <- "BTC"
#' loan.orders     <- ReturnLoanOrders(poloniex.public)
#' @export
setGeneric(name="ReturnLoanOrders",
           def=function(theObject, currency = "BTC"){
             standardGeneric("ReturnLoanOrders")
           })
          
#' Returns a list of loan offers and demands for a given currency.
#'
#' @param theObject The object on which the function should be called
#' @param currency - a length-one character vector
#'  Represents the currency for which loan information should be
#'  fetched.
#' @return A list containing two items. Each item is a dataframe
#'  containing the actual loan offers or demands information.
#'   eg list$offers / list$demands
#'    - rows: offers / demand "order book" entries.
#'    - columns: rate, amount, min.days, max.days
#' @examples
#' poloniex.public <- PoloniexPublicAPI()
#' currency        <- "BTC"
#' loan.orders     <- ReturnLoanOrders(poloniex.public)                      
#' @export
setMethod(f="ReturnLoanOrders",
          signature="PoloniexPublicAPI",
          definition=function(theObject, currency = "BTC"){

            ########################
            ## INPUT VERIFICATION ##
            ########################
            stopifnot(inherits(currency, "character"))

            available.currencies <- rownames(ReturnCurrencies(theObject))
            if (!currency %in% available.currencies){
              stop (paste(currency, "is not a valid currency"))
            }

            #########################################
            ## REQUEST PROCESSING / DATA WRANGLING ##
            #########################################
            returnLoanOrders.command <- theObject@commands$returnLoanOrders
            request.str <- paste(paste(theObject@base.url,
                                       paste("command",
                                             returnLoanOrders.command, sep="="), sep=""),
                                 paste("currency", currency, sep="="), sep="&")

            # Poloniex API Call
            loan.orders <- .ProcessRequest(request.str)

            ExtractLoanOrders <- function(field){

              loans.names <- c("rate", "amount", "min.days", "max.days")
              loans       <- loan.orders[[field]]
              loans.depth <- length(loans)

              if (loans.depth > 0){
                loans.df  <- as.data.frame(matrix(unlist(loans),
                                                  nrow = loans.depth, byrow = TRUE))
              }
              else{
                loans.df <- data.frame(matrix(ncol = length(loans.names), nrow = 0))
              }
              names(loans.df) <- loans.names

              return (loans.df)
            }

            loan.demands <- ExtractLoanOrders(field = "demands")
            loan.offers  <- ExtractLoanOrders(field = "offers")

            return (list (offers  = loan.offers,
                          demands = loan.demands) )
          })
