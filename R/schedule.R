#' @rdname schedule
#' @title **Find game_pk values for Mexican professional baseball games (LMB and LMP)**
#'
#' @param season The season for which you want to find game_pk values for MLB games
#' @param league lmb or lmp
#' @param game_type character vector of game types to include. Options are
#' "R" (regular sesason),
#' "F" (LMB first-round playoff series),
#' "D" (LMB zone series, LMP first round),
#' "L" (LMB zone championship series, LMP semi-final),
#' "W" (LMB Serie del Rey, LMP Serie Final)
#' Default is "R".
#'
#' @return Returns a tibble which includes `game_pk` values and additional
#' information for games scheduled or played with the following columns:
#'
#'  |col_name                        |types     |
#'  |:-------------------------------|:---------|
#'  |date                            |character |
#'  |total_items                     |integer   |
#'  |total_events                    |integer   |
#'  |total_games                     |integer   |
#'  |total_games_in_progress         |integer   |
#'  |game_pk                         |integer   |
#'  |link                            |character |
#'  |game_type                       |character |
#'  |season                          |character |
#'  |game_date                       |character |
#'  |official_date                   |character |
#'  |game_number                     |integer   |
#'  |public_facing                   |logical   |
#'  |double_header                   |character |
#'  |gameday_type                    |character |
#'  |tiebreaker                      |character |
#'  |calendar_event_id               |character |
#'  |season_display                  |character |
#'  |day_night                       |character |
#'  |scheduled_innings               |integer   |
#'  |reverse_home_away_status        |logical   |
#'  |inning_break_length             |integer   |
#'  |games_in_series                 |integer   |
#'  |series_game_number              |integer   |
#'  |series_description              |character |
#'  |record_source                   |character |
#'  |if_necessary                    |character |
#'  |if_necessary_description        |character |
#'  |status_abstract_game_state      |character |
#'  |status_coded_game_state         |character |
#'  |status_detailed_state           |character |
#'  |status_status_code              |character |
#'  |status_start_time_tbd           |logical   |
#'  |status_reason                   |character |
#'  |status_abstract_game_code       |character |
#'  |teams_away_split_squad          |logical   |
#'  |teams_away_series_number        |integer   |
#'  |teams_away_league_record_wins   |integer   |
#'  |teams_away_league_record_losses |integer   |
#'  |teams_away_league_record_pct    |character |
#'  |teams_away_team_id              |integer   |
#'  |teams_away_team_name            |character |
#'  |teams_away_team_link            |character |
#'  |teams_home_split_squad          |logical   |
#'  |teams_home_series_number        |integer   |
#'  |teams_home_league_record_wins   |integer   |
#'  |teams_home_league_record_losses |integer   |
#'  |teams_home_league_record_pct    |character |
#'  |teams_home_team_id              |integer   |
#'  |teams_home_team_name            |character |
#'  |teams_home_team_link            |character |
#'  |venue_id                        |integer   |
#'  |venue_name                      |character |
#'  |venue_link                      |character |
#'  |content_link                    |character |
#'  |is_tie                          |logical   |
#'  |description                     |character |
#'  |teams_away_score                |integer   |
#'  |teams_away_is_winner            |logical   |
#'  |teams_home_score                |integer   |
#'  |teams_home_is_winner            |logical   |
#'  |reschedule_date                 |character |
#'  |reschedule_game_date            |character |
#'  |rescheduled_from                |character |
#'  |rescheduled_from_date           |character |
#'  |resume_date                     |character |
#'  |resume_game_date                |character |
#'  |resumed_from                    |character |
#'  |resumed_from_date               |character |
#'  |events                          |list      |
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom glue glue
#' @importFrom rlang .data
#' @importFrom tidyr unnest
#' @import rvest
#' @export
#'
#' @examples \donttest{
#'   try(mlb_schedule(season = "2019"))
#' }

schedule <- function(season = 2024, league = c("lmb","lmp"), game_type = "R"){

  sport_ids <- match.arg(league)
  game_type <- sanitize_game_type(game_type)

  mlb_endpoint <- mlb_stats_endpoint("v1/schedule")

  query_params <- list(
    language = "en",
    sportId = switch(sport_ids, lmb = 23, lmp = 17),
    season = season,
    gameType = game_type
  )

  mlb_endpoint <- httr::modify_url(mlb_endpoint, query = query_params)

  games <- data.frame()
  tryCatch(
    expr = {

      resp <- mlb_endpoint %>%
        mlb_api_call() %>%
        jsonlite::toJSON() %>%
        jsonlite::fromJSON(flatten = TRUE)

      games <- resp$dates %>%
        tidyr::unnest("games") %>%
        as.data.frame() %>%
        janitor::clean_names() %>%
        dplyr::filter(teams_away_team_id %in% teams(league = "lmp")$team_id & teams_home_team_id %in% teams(league = "lmp")$team_id |
                        teams_away_team_id %in% teams(league = "lmb")$team_id & teams_home_team_id %in% teams(league = "lmb")$team_id) %>%
        make_baseballmexR_data(paste0(toupper(league), " Stats data from MLB.com"),Sys.time())

    },
    error = function(e) {
      message(glue::glue("{Sys.time()}: Invalid arguments provided"))
    },
    finally = {
    }
  )
  return(games)
}
