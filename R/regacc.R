#' Data of Regional Accounts published by Eurostat in 2022
#'
#' The data corresponds to the data released by Eurostat in the year 2022 in the several datasets related to Regional Accounts. It consolidates all of them in a single table to make easier to combine them and adds some useful features like a country code, NUTS level, etc.
#'
#' @format A data.frame / data.table:
#' \describe{
#'   \item{table}{Name of the table in Eurostat's eurobase database(2gdp)}
#'   \item{country}{Country code (AT, BE,...)} 
#'   \item{NUTS}{Level of the NUTS (0,1,2,3)}
#'   \item{geo}{Code of the region (AT11,BE100,...)}
#'   \item{label}{Name of the region}
#'   \item{na_item}{national accounts variable (B1GQ for GDP, EMP for employment,...)}
#'   \item{nace_r2}{Classification of Economic Activities, when not relevant the code Z is used}
#'   \item{acc}{Type of transaction for Household Accounts (PAID, RECV,BAL), when not relevant the code Z is used}
#'   \item{unit}{Unit in which the variable is measured (MIO_EUR, PS, HW, ...)}
#'   \item{time}{year of  the data}
#'   \item{values}{value of the observation}
#'   \item{flag}{flag for specific values (P,E,...)}
#' }
#' @source \url{https://ec.europa.eu/eurostat}
"regacc"