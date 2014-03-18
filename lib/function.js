(function(game, team1, team2) {
  var normalize, stat, weighted;
  if (!team1.score) {
    team1.score = 0;
    team2.score = 0;
    normalize = function(num, stat) {
      var max, min, _ref;
      _ref = minMax[stat], min = _ref[0], max = _ref[1];
      return (num - min) / (max - min);
    };
    weighted = function(team, stat) {
      var normal;
      normal = normalize(team[stat], stat);
      return normal * weights[stat];
    };
    for (stat in weights) {
      if (!team1[stat]) {
        console.log("" + stat + " is not a valid statistic");
        continue;
      }
      team1.score += weighted(team1, stat);
      team2.score += weighted(team2, stat);
    }
  }
  if (team1.score >= team2.score) {
    return team1.winsGame();
  } else {
    return team2.winsGame();
  }
});
