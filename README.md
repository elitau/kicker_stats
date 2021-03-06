## Kickern App
Save and view your kicker games. List places where a kickertisch is available.

[![Build Status](https://secure.travis-ci.org/elitau/kicker_stats.png?branch=master)](http://travis-ci.org/elitau/kicker_stats)

## Players
A player has a nickname and an email address. A player is identified/unique by email.

### Create a player

post /player

JSON:

{
  nickname: "SuperNick",
  email: "supernick@example.com"
}

Response:

{
  success: true,
  errors: {}
}

#### Possible errors

Email unvalid:
TODO

Email already registered
TODO

### List all players

get /players

## Games

A game has 2 teams (named a and b). A team has one or two players. A game also has results. A result has team_a_goals and team_b_goals attributes.


### Create game

post /game

Payload JSON looks like this:

    {
      game: {
        teams: {
          team_a: ["supernick@example.com"],
          team_b: ["alex@example.com"]
        },
        results: [
          {
            team_a_goals: 6,
            team_b_goals: 3
          },
          {
            team_a_goals: 4,
            team_b_goals: 6
          },
          {
            team_a_goals: 6,
            team_b_goals: 0
          }
        ]
      }   
    }

### List all games

get /games


