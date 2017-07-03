.onAttach <- function(libname = find.package("PoloniexR"),
                      pkgname = "PoloniexR") {
  packageStartupMessage(
    "Poloniex API wrapper - Provided by EssentialQuant.com"
  )
  packageStartupMessage(
    "Author: Jellen Vermeir (jellenvermeir@essentialquant.com)"
  )
  packageStartupMessage(
    "Tutorial (todo): EssentialQuant.com/blog/PoloniexR"
  )
  packageStartupMessage(
    "Github: https://github.com/VermeirJellen/PoloniexR"
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
