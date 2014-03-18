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