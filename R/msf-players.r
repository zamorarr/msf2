#' Lists all players for a league on a given date, with full bio and other details.
#' @param date given date
#' @param sport mlb | nfl | nba | etc..
#' @param ... optional query parameters
#'
#' @examples
#' \dontrun{
#' j <- all_players("mlb", team = "bos", rosterstatus = c("assigned-to-roster", "assigned-to-injury-list"))
#' }
#' @export
all_players <- function(sport, date = Sys.Date(), ...) {
  stopifnot(length(date) == 1L, length(sport) == 1L)
  path <- sprintf("%s/players.json", sport)

  query <- list(date = msf_date(date), ...)
  query <- lapply(query, paste, collapse = ",")

  result <- msf_api(path, query)
  attr(result, "local_path") <- sprintf("%s/players/%s.json", sport, format(date, "%Y%m%d"))

  result <- msf_class(result, "players")
  result
}
