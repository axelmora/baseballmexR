
<!-- README.md is generated from README.Rmd. Please edit that file -->

# baseballmexR

<!-- badges: start -->
<!-- badges: end -->

`baseballmexR` is a package written for R focused on mexican baseball
analysis based on the `baseballr` and `sabRmetrics` packages. It
includes functions for scraping
[statsapi.mlb.com.com](https://www.statsapi.mlb.com/) focused on the
Mexican Pro Baseball leagues LMB and LMP.

## Installation

You can install the development version of baseballmexR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("axelmora/baseballmexR")
```

## General considerations

For all functions you have to define the league that you want to query
with the parameter `league`: “lmb” for Mexican League and “lmp” for
Winter Mexican League.

``` r
library(baseballmexR)
standings(season = 2024, league = "lmb")
#> ── LMB Stats data from MLB.com ─────────────────────────── baseballmexR 0.1.1 ──
#> ℹ Data updated: 2024-11-20 11:37:10 PST
#> # A tibble: 20 × 54
#>    standings_type last_updated        team_records_season team_records_divisio…¹
#>    <chr>          <chr>               <chr>               <chr>                 
#>  1 regularSeason  2024-08-02T05:31:2… 2024                1                     
#>  2 regularSeason  2024-08-02T05:31:2… 2024                2                     
#>  3 regularSeason  2024-08-02T05:31:2… 2024                3                     
#>  4 regularSeason  2024-08-02T05:31:2… 2024                4                     
#>  5 regularSeason  2024-08-02T05:31:2… 2024                5                     
#>  6 regularSeason  2024-08-02T05:31:2… 2024                6                     
#>  7 regularSeason  2024-08-02T05:31:2… 2024                7                     
#>  8 regularSeason  2024-08-02T05:31:2… 2024                8                     
#>  9 regularSeason  2024-08-02T05:31:2… 2024                9                     
#> 10 regularSeason  2024-08-02T05:31:2… 2024                10                    
#> 11 regularSeason  2024-10-28T17:43:0… 2024                1                     
#> 12 regularSeason  2024-10-28T17:43:0… 2024                2                     
#> 13 regularSeason  2024-10-28T17:43:0… 2024                3                     
#> 14 regularSeason  2024-10-28T17:43:0… 2024                4                     
#> 15 regularSeason  2024-10-28T17:43:0… 2024                5                     
#> 16 regularSeason  2024-10-28T17:43:0… 2024                6                     
#> 17 regularSeason  2024-10-28T17:43:0… 2024                7                     
#> 18 regularSeason  2024-10-28T17:43:0… 2024                8                     
#> 19 regularSeason  2024-10-28T17:43:0… 2024                9                     
#> 20 regularSeason  2024-10-28T17:43:0… 2024                10                    
#> # ℹ abbreviated name: ¹​team_records_division_rank
#> # ℹ 50 more variables: team_records_league_rank <chr>,
#> #   team_records_sport_rank <chr>, team_records_games_played <int>,
#> #   team_records_games_back <chr>, team_records_wild_card_games_back <chr>,
#> #   team_records_league_games_back <chr>,
#> #   team_records_spring_league_games_back <chr>,
#> #   team_records_sport_games_back <chr>, …
```

In some functions, you can to define the `game_type` that correspond for
regular season or post-season data defined in this way:

- “R” (regular season)
- “F” (LMB first-round playoff series)
- “D” (LMB zone series, LMP first-round playoff series)
- “L” (LMB zone championship series, LMP semi-final)
- “W” (LMB Championship series “Serie del Rey”, LMP “Serie Final”)

Default is “R”.

## Example

The package consists mainly of data acquisition for the Mexican League
(LMB) and the Winter Mexican League (LMP).

For example, if you want to see the teams for a specific league, you can
use the `teams()` function. Just pass the league you want (lmb or lmp):

``` r
teams(league = "lmb")
#> ── LMB Stats data from MLB.com ─────────────────────────── baseballmexR 0.1.1 ──
#> ℹ Data updated: 2024-11-20 11:37:11 PST
#> # A tibble: 20 × 29
#>    all_star_status team_id team_full_name       link  season team_code file_code
#>    <chr>             <int> <chr>                <chr>  <int> <chr>     <chr>    
#>  1 N                  6304 Charros de Jalisco   /api…   2024 jal       t6304    
#>  2 N                   579 Guerreros de Oaxaca  /api…   2024 oax       t579     
#>  3 N                   520 Pericos de Puebla    /api…   2024 pue       t520     
#>  4 N                   523 Piratas de Campeche  /api…   2024 cam       t523     
#>  5 N                   496 Leones de Yucatan    /api…   2024 yuc       t496     
#>  6 N                   560 Acereros del Norte   /api…   2024 mva       t560     
#>  7 N                   528 Rieleros de Aguasca… /api…   2024 agu       t528     
#>  8 N                   434 Bravos de Leon       /api…   2024 leo       t434     
#>  9 N                  5010 Toros de Tijuana     /api…   2024 tij       t5010    
#> 10 N                   562 Sultanes de Monterr… /api…   2024 mty       t562     
#> 11 N                   532 Diablos Rojos del M… /api…   2024 mxo       t532     
#> 12 N                   502 Saraperos de Saltil… /api…   2024 slt       t502     
#> 13 N                   536 Tecos de los Dos La… /api…   2024 lar       t536     
#> 14 N                   569 Tigres de Quintana … /api…   2024 qui       t569     
#> 15 N                   442 Olmecas de Tabasco   /api…   2024 tab       t442     
#> 16 N                  4444 Caliente de Durango  /api…   2024 dur       t4444    
#> 17 N                  6303 Conspiradores de Qu… /api…   2024 qro       t6303    
#> 18 N                  5567 El Aguila de Veracr… /api…   2024 ver       t5567    
#> 19 N                   575 Dorados de Chihuahua /api…   2024 chi       t575     
#> 20 N                   447 Algodoneros Union L… /api…   2024 vaq       t447     
#> # ℹ 22 more variables: team_abbreviation <chr>, team_name <chr>,
#> #   location_name <chr>, first_year_of_play <chr>, short_name <chr>,
#> #   parent_org_name <chr>, parent_org_id <int>, franchise_name <chr>,
#> #   club_name <chr>, active <lgl>, venue_id <int>, venue_name <chr>,
#> #   venue_link <chr>, league_id <int>, league_name <chr>, league_link <chr>,
#> #   division_id <int>, division_name <chr>, division_link <chr>,
#> #   sport_id <int>, sport_link <chr>, sport_name <chr>
```

For see the schedule for a league in a specific year, you can use the
`schedule()` function. Just pass the season and the league:

``` r
schedule(season = 2024, league = "lmp")
#> ── LMP Stats data from MLB.com ─────────────────────────── baseballmexR 0.1.1 ──
#> ℹ Data updated: 2024-11-20 11:37:12 PST
#> # A tibble: 340 × 71
#>    date      total_items total_events total_games total_games_in_progr…¹ game_pk
#>    <chr>           <int>        <int>       <int>                  <int>   <int>
#>  1 2024-10-…           6            0           6                      0  787208
#>  2 2024-10-…           6            0           6                      0  787376
#>  3 2024-10-…          11            0          11                      0  787020
#>  4 2024-10-…          11            0          11                      0  787093
#>  5 2024-10-…          11            0          11                      0  787277
#>  6 2024-10-…          11            0          11                      0  787244
#>  7 2024-10-…           9            0           9                      0  787170
#>  8 2024-10-…           9            0           9                      0  787312
#>  9 2024-10-…           9            0           9                      0  787057
#> 10 2024-10-…           9            0           9                      0  787345
#> # ℹ 330 more rows
#> # ℹ abbreviated name: ¹​total_games_in_progress
#> # ℹ 65 more variables: game_guid <chr>, link <chr>, game_type <chr>,
#> #   season <chr>, game_date <chr>, official_date <chr>, is_tie <lgl>,
#> #   game_number <int>, public_facing <lgl>, double_header <chr>,
#> #   gameday_type <chr>, tiebreaker <chr>, calendar_event_id <chr>,
#> #   season_display <chr>, day_night <chr>, scheduled_innings <int>, …
```

You can also pull data for a specific stat type and season for a league.
Here are the results hitting stats for the 2023 season in the LMB:

``` r
stats(league = "lmb", stat_group = "hitting", stat_type = "season", season = 2024, player_pool = "all")
#> [1] "http://statsapi.mlb.com/api/v1/stats?stats=season&playerPool=all&group=hitting&season=2024&leagueIds=125&limit=1000"
#> ── LMB Stats data from MLB.com ─────────────────────────── baseballmexR 0.1.1 ──
#> ℹ Data updated: 2024-11-20 11:37:12 PST
#> # A tibble: 450 × 59
#>    total_splits season num_teams  rank games_played ground_outs air_outs  runs
#>           <int> <chr>      <int> <int>        <int>       <int>    <int> <int>
#>  1          450 2024           1     1            1           0        0     0
#>  2          450 2024           1     1            1           0        0     1
#>  3          450 2024           1     3            5           1        0     2
#>  4          450 2024           1     4            8           0        0     2
#>  5          450 2024           1     5            3           0        0     0
#>  6          450 2024           1     5            3           2        0     0
#>  7          450 2024           1     7            7           7        1     4
#>  8          450 2024           1     8           78          90       58    62
#>  9          450 2024           1     9           85          79       68    64
#> 10          450 2024           1    10            3           1        3     1
#> # ℹ 440 more rows
#> # ℹ 51 more variables: doubles <int>, triples <int>, home_runs <int>,
#> #   strike_outs <int>, base_on_balls <int>, intentional_walks <int>,
#> #   hits <int>, hit_by_pitch <int>, avg <chr>, at_bats <int>, obp <chr>,
#> #   slg <chr>, ops <chr>, caught_stealing <int>, stolen_bases <int>,
#> #   stolen_base_percentage <chr>, ground_into_double_play <int>,
#> #   number_of_pitches <int>, plate_appearances <int>, total_bases <int>, …
```
