# first, assing weights to the
# stats you care about. feel free
# to add, remove, and tweak this
# list!
weights =
  cbs_rank: 4
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


# Then lets use this function to gather
# our state. We want to know the possible
# values for these stats, so
# we can normalize later.
# Run this in the editor
# on codersbracket.com

# function (game, team1, team2) {
#   # console.log(arguments);

#   # Assign weights to different stats
#   var weights = {
#       cbs_rank: 10,
#       def_rebound: 2,
#       free_throw_pct: 3
#   }

#   # attempt to normalize data
#   # to a score between 0-1
#   function getScore(team) {
#       var score = 0;
#       var score += (150-cbs_rank)/149;
#   }

# }