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
