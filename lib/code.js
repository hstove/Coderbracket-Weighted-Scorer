var max, min, minMax, stat, statValues, team, values, weights, _i, _len;

weights = {
  def_reb: 2,
  off_reb: 2,
  free_throw_pct: 3,
  blocks_per_game: 2,
  three_point_pct: 4,
  win_pct: 5
};

statValues = {};

for (_i = 0, _len = teams.length; _i < _len; _i++) {
  team = teams[_i];
  for (stat in weights) {
    statValues[stat] || (statValues[stat] = []);
    statValues[stat].push(team[stat]);
  }
}

minMax = {};

for (stat in statValues) {
  values = statValues[stat];
  max = Math.max.apply(null, values);
  min = Math.min.apply(null, values);
  minMax[stat] = [min, max];
}

editor.setValue("function(game, team1, team2) {\n  var normalize, stat, weighted;\n  team1.score = 0;\n  team2.score = 0;\n  normalize = function(num, stat) {\n    var max, min, _ref;\n    _ref = minMax[stat], min = _ref[0], max = _ref[1];\n    return (num - min) / (max - min);\n  };\n  weighted = function(team, stat) {\n    var normal;\n    normal = normalize(team[stat], stat);\n    return normal * weights[stat];\n  };\n  for (stat in weights) {\n    if (!team1[stat]) {\n      console.log(\"\" + stat + \" is not a valid statistic\");\n      continue;\n    }\n    team1.score += weighted(team1, stat);\n    team2.score += weighted(team2, stat);\n  }\n  if (team1.score >= team2.score) {\n    return team1.winsGame();\n  } else {\n    return team2.winsGame();\n  }\n}");
