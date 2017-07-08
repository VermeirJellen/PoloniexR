#' An S4 class representing the Poloniex Trading API.
#' 
#' All calls to the trading API are sent via HTTP POST.
#' The POST data itself is signed with your key's secret
#' according to the HMAC-SHA512 method.
#'
#' @slot trading.base.url A length-one character vector.
#'   Represents the poloniex trading API web service base url.
#' @slot key A length-one character vector.
#'   Represents the public key of your Poloniex trading account
#' @slot secret A length-one character vector.
#'   Represents the private key of your Poloniex trading account
#' @slot commands A list containing Key/Value string pairs.
#' Represents the command strings of the associated trading API functions.
#' @export PoloniexTradingAPI
PoloniexTradingAPI <- setClass(
  # Set the name for the Trading API class.
  "PoloniexTradingAPI",
  # Define the slots.
  slots = c(trading.base.url = "character",
            key              = "character",
            secret           = "character",
            commands         = "list"),
  # Set the default values for the slots.
  prototype = list(trading.base.url = "https://poloniex.com/tradingApi?",
                   key              = NULL,
                   secret           = NULL,
                   commands         = trading.commands.default),

  validity=function(object){

    type.err <- "NOK - %s character slot must be a length-one character vector"

    if (!inherits(object@trading.base.url, "character")){
      return (sprintf(type.err, substitute(object@trading.base.url)))
    }
    if (!inherits(object@key, "character")){
      return (sprintf(type.err, substitute(object@key)))
    }
    if (!inherits(object@secret, "character")){
      return (sprintf(type.err, substitute(object@secret)))
    }

    rest.grep <- "https?://.*\\?$"
    if (!grepl(rest.grep, object@trading.base.url)){
      return (paste("NOK - trading.base.url input argument",
                    "must be of the following form:", rest.grep))
    }

    key.grep <- "(\\w{8}-){3}\\w{8}"
    if (!grepl(key.grep, object@key)){
      return (paste("NOK - key input argument" ,
                    "must be of the following form:", key.grep))
    }

    return (TRUE)
  }
)


##############################################################
################### GETTERS / SETTERS trading.base.url #######
##############################################################

#' Returns REST service URL for the Poloniex Trading API
#'
#' @param theObject The object on which the function should be called
#' @return trading.base.url - a length-one character vector.
#'  Represents the Poloniex Trading API service base url.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingURL(poloniex.trading)
#' }
#' @export
setGeneric(name="GetPoloniexTradingURL",
           def=function(theObject){
             standardGeneric("GetPoloniexTradingURL")
           })

#' Returns REST service URL for the Poloniex Trading API
#'
#' @param theObject The object on which the function should be called
#' @return trading.base.url - a length-one character vector.
#'  Represents the Poloniex Trading API service base url.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingURL(poloniex.trading)
#' }
#' @export
setMethod(f="GetPoloniexTradingURL",
          signature="PoloniexTradingAPI", definition=function(theObject){
            return(theObject@trading.base.url)
          })

#' Setter for REST service URL for the Poloniex Trading API
#'
#' @param theObject The Trading client API object on which the function should be called
#' @param trading.base.url length-one character vector. Represents the REST service URL.
#' @return theObject - a copy of the object with the modified trading.base.url slot
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret,
#'                                        trading.base.url = "https://not_working/trading?")
#' poloniex.trading <- SetPoloniexTradingURL(poloniex.trading, 
#'                                          trading.base.url = "https://poloniex.com/tradingApi?")
#' GetPoloniexTradingURL(poloniex.trading)
#' }
#' @export
setGeneric(name="SetPoloniexTradingURL",
           def=function(theObject, trading.base.url){
             standardGeneric("SetPoloniexTradingURL")
           })

#' Setter for REST service URL for the Poloniex Trading API
#'
#' @param theObject The Trading client API object on which the function should be called
#' @param trading.base.url length-one character vector. Represents the REST service URL.
#' @return theObject - a copy of the object with the modified trading.base.url slot
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret,
#'                                        trading.base.url = "https://not_working/trading?")
#' poloniex.trading <- SetPoloniexTradingURL(poloniex.trading, 
#'                                           trading.base.url = "https://poloniex.com/tradingApi?")
#' GetPoloniexTradingURL(poloniex.trading)
#' }
#' @export
setMethod(f="SetPoloniexTradingURL",
          signature="PoloniexTradingAPI", definition=function(theObject, trading.base.url){
            theObject@trading.base.url <- trading.base.url
            validObject(theObject)
            return(theObject)
          })


##############################################################
################### GETTERS / SETTERS commands ###############
##############################################################

#' Returns REST service commands for the Poloniex Trading API
#'
#' @param theObject The Trading client API object on which the function should be called
#' @return commands - a list with Key/value string pairs
#'  Represents the command strings for the respective Trading API functions.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingCommands(poloniex.trading)
#' }
#' @export
setGeneric(name="GetPoloniexTradingCommands",
           def=function(theObject){
             standardGeneric("GetPoloniexTradingCommands")
           })

#' Returns REST service commands for the Poloniex Trading API
#'
#' @param theObject The Trading client API object on which the function should be called
#' @return commands - a list with Key/value string pairs
#'  Represents the command strings for the respective Trading API functions.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingCommands(poloniex.trading)
#' }
#' @export
setMethod(f="GetPoloniexTradingCommands",
          signature="PoloniexTradingAPI", definition=function(theObject){
            return(theObject@commands)
          })

#' Setter for REST service commands for the Poloniex Trading API.
#'
#' @param theObject The Trading client API object on which the function should be called
#' @param commands -  a list with Key/value string pairs
#'  Represents the command strings for the respective Trading API functions.
#' @return theObject - a copy of the object with the modified command slot.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingCommands(poloniex.trading)
#' commands.new <- list(returnTradeHistory = "returnTradeHistory.new",
#'                      withdraw = "withdraw.new")
#' poloniex.trading <- SetPoloniexTradingCommands(poloniex.trading,
#'                                                commands = commands.new)
#' GetPoloniexTradingCommands(poloniex.trading)
#' }
#' @export
setGeneric(name="SetPoloniexTradingCommands",
           def=function(theObject, commands){
             standardGeneric("SetPoloniexTradingCommands")
           })

#' Setter for REST service commands for the Poloniex Trading API.
#'
#' @param theObject The Trading client API object on which the function should be called
#' @param commands -  a list with Key/value string pairs
#'  Represents the command strings for the respective Trading API functions.
#' @return theObject - a copy of the object with the modified command slot.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' GetPoloniexTradingCommands(poloniex.trading)
#' commands.new <- list(returnTradeHistory = "returnTradeHistory.new",
#'                      withdraw = "withdraw.new")
#' poloniex.trading <- SetPoloniexTradingCommands(poloniex.trading,
#'                                                commands = commands.new)
#' GetPoloniexTradingCommands(poloniex.trading)
#' }
#' @export
setMethod(f="SetPoloniexTradingCommands",
          signature="PoloniexTradingAPI", definition=function(theObject, commands){
            theObject@commands <- commands

            # Set missing commands to default (for convenience reasons)
            commands.input.names <- names(commands)
            commands.required.names <- names(trading.commands.default)
            missing.mask <- vapply(commands.required.names,
                                   function(x) ifelse(!x %in% commands.input.names, TRUE, FALSE),
                                   logical(1))
            if(sum(missing.mask) > 0){
              warning(paste("Not all commands were set in the API command list input arguments:",
                            "Setting missing commands to their respective default values."))
              for(missing.name in commands.required.names[missing.mask]){
                theObject@commands[[missing.name]] <- trading.commands.default[[missing.name]]
              }
            }

            validObject(theObject)
            return(theObject)
          })


#############################################################
########################## API FUNCTIONS ####################
#############################################################

############################################
#### ProcessTradingRequest #################
############################################

#' Process a trading request.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @param command - A length-one character vector.
#'  Represents the trading command that should be executed by Poloniex.
#' @param args - list of optional trading arguments for the
#'  trading command that should be executed.
#' @return List - Results of the Trading Requests. Exact contents depend on the
#'  type of Trading API Call that should be processed.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' deposit.addresses <- ProcessTradingRequest(poloniex.trading,
#'  command = poloniex.trading@commands$returnDepositAddresses)
#' }
#' @export
setGeneric(name="ProcessTradingRequest",
           def=function(theObject, command, args = list()){
             standardGeneric("ProcessTradingRequest")
           })

#' Process a trading request.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @param command - A length-one character vector.
#'  Represents the trading command that should be executed by Poloniex.
#' @param args - list of optional trading arguments for the
#'  trading command that should be executed.
#' @return List - Results of the Trading Requests. Exact contents depend on the
#'  type of Trading API Call that should be processed.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' deposit.addresses <- ProcessTradingRequest(poloniex.trading,
#'  command = poloniex.trading@commands$returnDepositAddresses)
#' }
#' @export
setMethod(f="ProcessTradingRequest",
          signature="PoloniexTradingAPI",
          definition=function(theObject,
                              command,
                              args = list()){

  #########################
  ## PROCESS THE REQUEST ##
  #########################
  request <- c(list(command = command,
                    nonce   = round(as.numeric(Sys.time()) * 1e4, 0)),
               args)
  to.be.signed       <- paste(sprintf("%s=%s", names(request), request), collapse = "&")
  signed.hmac.sha512 <- digest::hmac(key    = theObject@secret,
                                     object = to.be.signed,
                                     algo   = "sha512")
  request.str  <- theObject@trading.base.url
  response     <- httr::POST(url = request.str,
                             httr::add_headers(key  = theObject@key,
                                               sign = signed.hmac.sha512),
                             body = request,
                             encode = "form")

  ####################################
  ## EXTRACT INFORMATION / RESPONSE ##
  ####################################
  resp.code <- httr::status_code(response)
  if (resp.code == "200"){

    resp.content <- httr::content(response)
    resp.err     <- resp.content$error

    if (is.null(resp.err)){
      return (httr::content(response))
    }
    else{
      stop (paste("Poloniex returned \"",
                  resp.err, "\" response error while processing parameters \"",
                  to.be.signed, "\"", sep=""))
    }
  }
  else{
    stop (paste("Unable to connect to ",
                request.str, " (", resp.code, ")", sep=""))
  }
})


################################################################
################### RETURN BALANCES ############################
################################################################

#' Returns all the available non-zero balances associated with
#' this account.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @return a vector containing non-zero currency balances. Each
#'  entry corresponds to a balance for a single currency.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' balances         <- ReturnBalances(poloniex.trading)
#' head(balances)
#' }
#' @export
setGeneric(name="ReturnBalances",
           def=function(theObject){
             standardGeneric("ReturnBalances")
           })

#' Returns all the available non-zero balances associated with
#' this account.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @return a vector containing non-zero currency balances. Each
#'  entry corresponds to a balance for a single currency.
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' balances         <- ReturnBalances(poloniex.trading)
#' head(balances)
#' }
#' @export
setMethod(f="ReturnBalances",
          signature="PoloniexTradingAPI",
          definition=function(theObject){

            returnbalances.command = theObject@commands$returnBalances
            balances <- ProcessTradingRequest(theObject, command = returnbalances.command)
          
            balances <- vapply(balances, as.numeric, numeric(1))
            balances <- balances[balances != 0]
          
            if (length(balances) > 0){
              return (balances)
            }
            else{
              warning(paste("No non-zero balances could be retrieved for the Poloniex account",
                            "associated with key", theObject@key))
              return (list())
            }
          })


################################################################
################### RETURN COMPLETE BALANCES ###################
################################################################

#' Returns all of your account balances, including available balance, balance on orders,
#' and the estimated BTC value of your balance.
#' By default, this call is limited to your exchange account; set the all.balances input parameter to TRUE
#' to include your margin and lending accounts.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @param all.balances logical - set to TRUE to also return margin and lending
#'  account balances.
#' @return todo
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' balances         <- ReturnCompleteBalances(poloniex.trading)
#' head(balances)
#'
#' balances.all <- ReturnCompleteBalances(poloniex.trading)
#' head(balances.all)
#' }
#' @export
setGeneric(name="ReturnCompleteBalances",
           def=function(theObject, all.balances = FALSE){
             standardGeneric("ReturnCompleteBalances")
           })

#' Returns all of your account balances, including available balance, balance on orders,
#' and the estimated BTC value of your balance.
#' By default, this call is limited to your exchange account; set the all.balances input parameter to TRUE
#' to include your margin and lending accounts.
#'
#' @param theObject The Trading client API object on which the function should be called.
#' @param all.balances logical - set to TRUE to also return margin and lending
#'  account balances.
#' @return todo
#' @examples
#' \dontrun{
#' poloniex.trading <- PoloniexTradingAPI(your.key, your.secret)
#' balances         <- ReturnCompleteBalances(poloniex.trading)
#' head(balances)
#'
#' balances.all <- ReturnCompleteBalances(poloniex.trading)
#' head(balances.all)
#' }
#' @export
setMethod(f="ReturnCompleteBalances",
          signature="PoloniexTradingAPI",
          definition=function(theObject, all.balances = FALSE){

            stopifnot(is(all.balances, "logical"))
  
            returnCompleteBalances.command = theObject@commands$returnCompleteBalances
            if (all.balances){
              balances <- ProcessTradingRequest(theObject,
                                                command = returnCompleteBalances.command,
                                                args    = list(account = "all"))
            }
            else {
              balances <- ProcessTradingRequest(theObject,
                                                command = returnCompleteBalances.command)
            }
          
            balances.available <- vapply(balances, function(x) as.numeric(x$available), numeric(1))
            balances.orders    <- vapply(balances, function(x) as.numeric(x$onOrders), numeric(1))
            balances.total     <- balances.available + balances.orders
            balances.btc.value <- vapply(balances, function(x) as.numeric(x$btcValue), numeric(1))
          
            mask <- (balances.total != 0)
          
            if (sum(mask) > 0){
          
              df <- data.frame(available = balances.available[mask],
                               on.orders = balances.orders[mask],
                               total     = balances.total[mask],
                               btc.value = balances.btc.value[mask])
              df$percentage <- df$btc.value / sum(df$btc.value)
              return (df)
            }
            else{
              warning(paste("No non-zero balances could be retrieved for the Poloniex account",
                            "associated with key", theObject@key))
              return (data.frame(available = NULL,
                                 on.orders = NULL,
                                 total     = NULL,
                                 btc.value = NULL))
            }
          })
