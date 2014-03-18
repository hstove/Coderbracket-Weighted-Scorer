# first, assing weights to the
# stats you care about. feel free
# to add, remove, and tweak this
# list!
weights =
  def_reb: 2
  off_reb: 2
  free_throw_pct: 3
  blocks_per_game: 2
  three_point_pct: 4
  win_pct: 5

statValues = {}
for team in teams
  for stat of weights
    statValues[stat] ||= []
    statValues[stat].push team[stat]

minMax = {}
for stat of statValues
  values = statValues[stat]
  max = Math.max.apply(null, values)
  min = Math.min.apply(null, values)
  minMax[stat] = [ min, max ]

editor.setValue """
function(game, team1, team2) {
  var normalize, stat, weighted;
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
  if (team1.score >= team2.score) {
    return team1.winsGame();
  } else {
    return team2.winsGame();
  }
}
"""