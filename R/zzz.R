.onAttach <- function(libname = find.package("PoloniexR"),
                      pkgname = "PoloniexR") {
  packageStartupMessage(
    "Poloniex API wrapper - Provided by Essential Data Science Consulting ltd."
  )
  packageStartupMessage(
    "  Author      - Jellen Vermeir (jellenvermeir@essentialquant.com)"
  )
  packageStartupMessage(
    "  Github      - https://github.com/VermeirJellen/PoloniexR"
  )
  packageStartupMessage(
    "  Examples    - http://EssentialQuant.com/blog/PoloniexR"
  )
  packageStartupMessage(
    "BTC Donations - 1QHtZLZ15Cmj4FPr5h5exDjYciBDhh7mzA"
  )
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.poloniex <- list( poloniex.path = "~/R-dev",
                       poloniex.install.args = "",
                       poloniex.name = "poloniex",
                       poloniex.desc.author = 'person("Jellen", "Vermeir",
                       "jellenvermeir@essentialquant.com", role = c("aut", "cre"))',
                       poloniex.desc.license = "MIT",
                       poloniex.desc.suggests = NULL,
                       poloniex.desc = list() )
  toset <- !(names(op.poloniex) %in% names(op))
  if (any(toset)) options(op.poloniex[toset])
  invisible()
}
