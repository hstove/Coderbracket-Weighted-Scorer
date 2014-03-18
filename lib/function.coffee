(game, team1, team2) ->
  unless team1.score
    team1.score = 0
    team2.score = 0

    normalize = (num, stat) ->
      [min, max] = minMax[stat]
      (num - min) / (max - min)

    weighted = (team, stat) ->
      normal = normalize(team[stat], stat)
      normal * weights[stat]

    for stat of weights
      unless team1[stat]
        console.log "#{stat} is not a valid statistic"
        continue
      team1.score += weighted(team1, stat)
      team2.score += weighted(team2, stat)

  if team1.score >= team2.score
    team1.winsGame()
  else
    team2.winsGame()
